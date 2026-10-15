/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26
library;

import '../../../generated/l10n.dart';

String get connectionErrorMessage => S.current.errConnection;

/// El cliente HTTP convierte un timeout o un fallo de red en
/// `{"status": 408}`.
const timeoutStatus = 408;

/// Error de una petición, con el mensaje listo para mostrar al usuario
/// (`toString` no le agrega el prefijo "Exception:").
class ApiException implements Exception {
  final String message;

  const ApiException(this.message);

  /// Desde una respuesta fallida: error de conexión, mensaje del API o
  /// [fallback].
  factory ApiException.from(Map<String, dynamic> result, String fallback) =>
      ApiException(result['status'] == timeoutStatus
          ? connectionErrorMessage
          : apiErrorMessage(result['body']) ?? fallback);

  @override
  String toString() => message;
}

/// Primer mensaje de un error del API. Llegan como
/// `{ "<campo>": ["msg", ...] }` o `{ "detail": "msg" }`.
String? apiErrorMessage(Object? body) {
  if (body is! Map<String, dynamic>) return null;
  for (final value in body.values) {
    if (value is List && value.isNotEmpty) return '${value.first}';
    if (value is String) return value;
  }
  return null;
}

/// Errores por campo (`{ "<campo>": ["msg", ...] }`), sin los generales.
Map<String, List<String>> apiFieldErrors(Object? body) {
  if (body is! Map<String, dynamic>) return const {};
  return {
    for (final MapEntry(:key, :value) in body.entries)
      if (key != 'non_field_errors' && value is List && value.isNotEmpty)
        key: [for (final message in value) '$message'],
  };
}
