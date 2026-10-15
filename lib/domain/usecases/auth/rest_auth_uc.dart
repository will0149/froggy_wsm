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
import '../../../generated/l10n.dart';

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
    final expired = AuthRepository.sessionExpired.listen((_) => _expire());
    ref.onDispose(expired.cancel);
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
          fallbackError: S.current.errLogin,
        ));
  }

  Future<void> register(RegisterDto request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authenticate(
          () => repository.register(request),
          readTokens: (body) =>
              (body['access'] as String?, body['refresh'] as String?),
          errorMessage: _registerErrorMessage,
          fallbackError: S.current.errSignUp,
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
        return AuthState.error(S.current.errLoadProfile);
      }
      return AuthState.error('$fallbackError (sin tokens)');
    }
    return AuthState.error(
      errorMessage(body) ?? '$fallbackError (código: $status)',
      fieldErrors: apiFieldErrors(body),
    );
  }

  /// Los errores por campo se muestran en el formulario; aquí solo el general
  /// (`non_field_errors`: contraseña parecida al usuario, no coinciden…).
  String? _registerErrorMessage(Object? body) {
    final general =
        body is Map<String, dynamic> ? body['non_field_errors'] : null;
    if (general is List && general.isNotEmpty) return '${general.first}';
    if (apiFieldErrors(body).isNotEmpty) {
      return S.current.errSignUpIncomplete;
    }
    return apiErrorMessage(body);
  }

  /// Credenciales incorrectas llegan como `non_field_errors`.
  String? _signInErrorMessage(Object? body) {
    if (body is Map<String, dynamic> && body.containsKey('non_field_errors')) {
      return S.current.errWrongCredentials;
    }
    return apiErrorMessage(body);
  }

  /// Sube la foto de perfil y recarga el perfil. Devuelve null si salió bien
  /// o el mensaje de error.
  Future<String?> updateAvatar(String filePath) async {
    try {
      final result = await repository.uploadAvatar(filePath);
      final status = result['status'];
      if (status == timeoutStatus) return connectionErrorMessage;
      if (status != 200) {
        return apiErrorMessage(result['body']) ??
            S.current.avatarUploadFailed;
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      return connectionErrorMessage;
    }
    final user = await getUserProfile();
    if (user != null && ref.mounted && _isAuthenticated) {
      state = AsyncData(AuthState.authenticated(user));
    }
    return null;
  }

  Future<UserProfileDTO?> getUserProfile() async {
    try {
      final result = await repository.getUserProfile();
      final body = result['body'];
      if (result['status'] == 200 && body is Map<String, dynamic>) {
        return UserProfileDTO.fromJson(body);
      }
    } catch (e, stackTrace) {
      // También errores de parseo: un perfil ilegible equivale a no tenerlo.
      logger.e(e.toString());
      logger.e(stackTrace);
    }
    return null;
  }

  /// Al volver a la app: si el refresh token caducó en segundo plano, la
  /// sesión ya no se puede renovar.
  Future<void> checkSession() async {
    if (!_isAuthenticated) return;
    if (!await headersUtils.validateStorage()) _expire();
  }

  bool get _isAuthenticated => state.value?.isAuthenticated ?? false;

  void _expire() {
    if (!_isAuthenticated || !ref.mounted) return;
    logger.w('session expired');
    state = AsyncData(AuthState.unauthenticated());
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
