import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../data/repositories/events_repository.dart';
import '../../generated/l10n.dart';
import 'auth/api_error_message.dart';
import 'repositories.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

part 'private_event_access_uc.g.dart';

/// Texto del QR de un evento PRIVATE.
String accessCodeQrData(String code) => Uri(
    scheme: 'parkea',
    host: 'events',
    path: '/join',
    queryParameters: {'code': code}).toString();

/// Código de un QR de [accessCodeQrData] o escrito a mano; null si no hay
/// código. Quita los espacios que se cuelan al copiarlo; el API ignora
/// mayúsculas y guiones.
String? parseAccessCode(String raw) {
  final text = raw.trim();
  final uri = Uri.tryParse(text);
  final fromQr = uri != null && uri.scheme == 'parkea' && uri.host == 'events'
      ? uri.queryParameters['code']
      : null;
  final code = (fromQr ?? text).replaceAll(RegExp(r'\s'), '');
  return code.isEmpty ? null : code;
}

sealed class AccessResult {
  const AccessResult();
}

class AccessGranted extends AccessResult {
  final EventDTO event;

  const AccessGranted(this.event);
}

class AccessDenied extends AccessResult {
  final String message;

  const AccessDenied(this.message);
}

/// Códigos de los eventos PRIVATE que el usuario abrió en esta sesión, por
/// id de evento. El detalle los manda al API y la inscripción no los vuelve
/// a pedir.
@Riverpod(keepAlive: true)
class PrivateEventAccessUC extends _$PrivateEventAccessUC {
  EventRepository get repository => ref.read(eventRepositoryProvider);

  @override
  Map<int, String> build() => const {};

  Future<AccessResult> unlock(String code) async {
    final Map<String, dynamic> result;
    try {
      result = await repository.eventByAccessCode(code);
    } on Exception {
      return AccessDenied(connectionErrorMessage);
    }
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) return AccessDenied(connectionErrorMessage);
    if (status == 404) return AccessDenied(S.current.invalidAccessCode);
    // 10 intentos por minuto, contando los aciertos.
    if (status == 429) return AccessDenied(S.current.tooManyAttempts);
    if (status != 200 || body is! Map<String, dynamic>) {
      return AccessDenied(apiErrorMessage(body) ?? S.current.invalidAccessCode);
    }
    final event = EventDTO.fromJson(body);
    final id = int.tryParse(event.id ?? '');
    if (id != null) state = {...state, id: code};
    return AccessGranted(event);
  }
}
