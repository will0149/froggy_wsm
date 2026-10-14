import 'package:parkea/data/entities/user/user_profile_dto.dart';
import 'package:parkea/domain/models/auth/auth_state.dart' show AuthState;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/entities/auth/auth_response_entity.dart';
import '../../../data/entities/auth/register_dto.dart' show RegisterDto;
import '../../../data/entities/login_dto.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../device/utils/is_first_run.dart';
import '../../../device/utils/loggerConfig.dart';
import '../../../data/repositories/utils/build_header_utils.dart';
import '../../../data/repositories/utils/impl/build_headers_utils_impl.dart';
import 'api_error_message.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

part 'rest_auth_uc.g.dart';

@riverpod
class RestAuthUC extends _$RestAuthUC {
  final AuthRepository repository = AuthRepository();
  final BuildHeadersUtils headersUtils = BuildHeadersUtilsImpl();

  @override
  Future<AuthState> build() async {
    final isFirstRun = await IsFirstRun().isFirstRun();
    if (isFirstRun) {
      return AuthState.firstRun();
    }

    final hasStorage = await headersUtils.validateStorage();
    if (!hasStorage) {
      return AuthState.unauthenticated();
    }

    final user = await getUserProfile();
    if (user != null) {
      return AuthState.authenticated(user);
    }
    return AuthState.unauthenticated();
  }

  Future<void> signIn(LoginDTO request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(
          () => repository.signIn(request),
          readTokens: (body) {
            final tokens = AuthResponseEntity.fromJson(body);
            return (tokens.token, tokens.refreshToken);
          },
          errorMessage: _signInErrorMessage,
          fallbackError: 'Error al iniciar sesión',
        ));
  }

  Future<void> register(RegisterDto request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(
          () => repository.register(request),
          readTokens: (body) =>
              (body['access'] as String?, body['refresh'] as String?),
          errorMessage: apiErrorMessage,
          fallbackError: 'Error al registrarse',
        ));
  }

  /// Login y registro devuelven los tokens con nombres distintos
  /// (`token`/`refresh_token` vs `access`/`refresh`), de ahí [readTokens].
  Future<AuthState> _authenticate(
    Future<Map<String, dynamic>> Function() request, {
    required (String?, String?) Function(Map<String, dynamic> body) readTokens,
    required String? Function(Object? body) errorMessage,
    required String fallbackError,
  }) async {
    final Map<String, dynamic> result;
    try {
      result = await request();
    } on Exception catch (e) {
      logger.e(e.toString());
      return AuthState.error(connectionErrorMessage);
    }
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) {
      return AuthState.error(connectionErrorMessage);
    }
    if (status is int &&
        status >= 200 &&
        status < 300 &&
        body is Map<String, dynamic>) {
      final (access, refresh) = readTokens(body);
      if (access != null && refresh != null) {
        await headersUtils.saveTokens(access: access, refresh: refresh);
        final user = await getUserProfile();
        if (user != null) {
          return AuthState.authenticated(user);
        }
        // Sin perfil no hay sesión: que no reaparezca al reabrir la app.
        await headersUtils.dropTemporalMemory();
      }
      return AuthState.error('No se pudo cargar el perfil');
    }
    return AuthState.error(
        errorMessage(body) ?? '$fallbackError (código: $status)');
  }

  /// Credenciales incorrectas llegan como `non_field_errors`.
  String? _signInErrorMessage(Object? body) {
    if (body is Map<String, dynamic> && body.containsKey('non_field_errors')) {
      return 'Usuario o contraseña incorrectos';
    }
    return apiErrorMessage(body);
  }

  Future<UserProfileDTO?> getUserProfile() async {
    try {
      final result = await repository.getUserProfile();
      final body = result['body'];
      if (result['status'] == 200 && body is Map<String, dynamic>) {
        return UserProfileDTO.fromJson(body);
      }
    } on Exception catch (e, stackTrace) {
      logger.e(e.toString());
      logger.e(stackTrace);
    }
    return null;
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      try {
        await repository.logOut();
      } on Exception catch (e) {
        // La sesión local se cierra aunque el API no responda.
        logger.e(e.toString());
      }
      await headersUtils.dropTemporalMemory();
      return AuthState.unauthenticated();
    });
  }
}
