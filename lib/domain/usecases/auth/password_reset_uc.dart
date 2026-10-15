import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../device/utils/logger_config.dart';
import 'api_error_message.dart';
import '../../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

part 'password_reset_uc.g.dart';

/// Flujo de reset: solicitar el correo y confirmar con el uid/token del
/// enlace. No toca la sesión, por eso va aparte de [RestAuthUC].
/// El estado solo indica si hay una petición en curso.
@riverpod
class PasswordResetUC extends _$PasswordResetUC {
  final AuthRepository repository = AuthRepository();

  @override
  FutureOr<void> build() {}

  /// Devuelve null si salió bien o el mensaje de error.
  Future<String?> requestReset(String email) =>
      _send(() => repository.requestPasswordReset(email.trim()));

  Future<String?> confirmReset({
    required String uid,
    required String token,
    required String newPassword1,
    required String newPassword2,
  }) =>
      _send(
          () => repository.confirmPasswordReset(
                uid: uid.trim(),
                token: token.trim(),
                newPassword1: newPassword1,
                newPassword2: newPassword2,
              ),
          errorMessage: _confirmErrorMessage);

  /// uid o token inválidos llegan como `{"token": ["Invalid value"]}`.
  String? _confirmErrorMessage(Object? body) {
    if (body is Map<String, dynamic> &&
        (body.containsKey('uid') || body.containsKey('token'))) {
      return S.current.errInvalidResetLink;
    }
    return apiErrorMessage(body);
  }

  Future<String?> _send(
    Future<Map<String, dynamic>> Function() request, {
    String? Function(Object? body) errorMessage = apiErrorMessage,
  }) async {
    state = const AsyncValue.loading();
    String? error;
    try {
      final result = await request();
      final status = result['status'];
      if (status == timeoutStatus) {
        error = connectionErrorMessage;
      } else if (status != 200) {
        error = errorMessage(result['body']) ?? S.current.errWithCode(status);
      }
    } on Exception catch (e) {
      logger.e(e.toString());
      error = connectionErrorMessage;
    }
    if (ref.mounted) state = const AsyncValue.data(null);
    return error;
  }
}
