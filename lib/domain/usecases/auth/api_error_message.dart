/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26
library;

const connectionErrorMessage = 'No se pudo conectar con el servidor';

/// El cliente HTTP convierte un timeout en `{"status": 408}`.
const timeoutStatus = 408;

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
