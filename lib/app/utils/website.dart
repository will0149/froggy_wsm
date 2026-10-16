// Made for parkea.
// By User: josedominguez
// Date: 10/16/26

/// Web del perfil. El API solo acepta URLs http/https (máximo 200
/// caracteres) y no completa el esquema.
abstract final class Website {
  static const maxLength = 200;

  /// Antepone `https://` si falta; null si está vacía.
  static String? normalize(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;
    return RegExp(r'^https?://', caseSensitive: false).hasMatch(text)
        ? text
        : 'https://$text';
  }

  /// true si [value] (ya normalizada) es una URL http/https con dominio.
  static bool isValid(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.contains('.') &&
        !uri.host.startsWith('.') &&
        !uri.host.endsWith('.');
  }

  /// Para mostrar: sin esquema, `www.` ni la `/` final.
  static String display(String url) => url
      .replaceFirst(RegExp(r'^https?://', caseSensitive: false), '')
      .replaceFirst(RegExp(r'^www\.', caseSensitive: false), '')
      .replaceFirst(RegExp(r'/$'), '');
}
