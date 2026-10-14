import 'package:flutter/services.dart';

import '../../device/utils/loggerConfig.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

enum PasswordIssue { tooSimilar, tooShort, tooCommon, entirelyNumeric }

/// Réplica de AUTH_PASSWORD_VALIDATORS del API (validadores por defecto de
/// Django 4.2) para avisar antes de enviar. El API sigue siendo quien decide.
abstract final class PasswordPolicy {
  static const minLength = 8;
  static const _maxSimilarity = 0.7;
  static const _commonPasswordsAsset = 'assets/data/common-passwords.txt';

  /// Lista de Django (common-passwords.txt.gz), ya en minúsculas.
  static Set<String>? _commonPasswords;
  static Future<void>? _loading;

  static final _nonWord = RegExp(r'[^\p{L}\p{N}_]+', unicode: true);
  static final _digits = RegExp(r'^\p{Nd}+$', unicode: true);

  /// Mientras no termine de cargar, [check] no revisa las contraseñas comunes.
  static Future<void> ensureLoaded() => _loading ??= _load();

  static Future<void> _load() async {
    try {
      final text = await rootBundle.loadString(_commonPasswordsAsset);
      _commonPasswords = text.split('\n').map((e) => e.trim()).toSet();
    } catch (e) {
      logger.e('common passwords not loaded: $e');
      _loading = null;
    }
  }

  /// [userAttributes]: username, email… con los que no debe parecerse.
  static List<PasswordIssue> check(String password,
      {Iterable<String?> userAttributes = const []}) {
    return [
      if (_isTooSimilar(password, userAttributes)) PasswordIssue.tooSimilar,
      if (password.length < minLength) PasswordIssue.tooShort,
      if (_commonPasswords?.contains(password.toLowerCase().trim()) ?? false)
        PasswordIssue.tooCommon,
      if (_digits.hasMatch(password)) PasswordIssue.entirelyNumeric,
    ];
  }

  /// UserAttributeSimilarityValidator: compara con cada atributo completo y
  /// con sus partes (p. ej. "jane" y "example" de "jane@example.com").
  static bool _isTooSimilar(String password, Iterable<String?> attributes) {
    final pwd = password.toLowerCase();
    for (final attribute in attributes) {
      if (attribute == null || attribute.isEmpty) continue;
      final value = attribute.toLowerCase();
      for (final part in [...value.split(_nonWord), value]) {
        if (_exceedsMaximumLengthRatio(pwd, part)) continue;
        if (_quickRatio(pwd, part) >= _maxSimilarity) return true;
      }
    }
    return false;
  }

  static bool _exceedsMaximumLengthRatio(String password, String value) {
    final pwdLen = password.runes.length;
    final valueLen = value.runes.length;
    return pwdLen >= 10 * valueLen && valueLen < _maxSimilarity / 2 * pwdLen;
  }

  /// `difflib.SequenceMatcher(a, b).quick_ratio()` de Python.
  static double _quickRatio(String a, String b) {
    final aRunes = a.runes.toList();
    final bRunes = b.runes.toList();
    final total = aRunes.length + bRunes.length;
    if (total == 0) return 1.0;
    final available = <int, int>{};
    for (final rune in bRunes) {
      available[rune] = (available[rune] ?? 0) + 1;
    }
    var matches = 0;
    for (final rune in aRunes) {
      final count = available[rune] ?? 0;
      if (count > 0) matches++;
      available[rune] = count - 1;
    }
    return 2.0 * matches / total;
  }
}
