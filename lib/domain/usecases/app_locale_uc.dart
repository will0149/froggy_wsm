import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';
import 'event_categories_uc.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

part 'app_locale_uc.g.dart';

/// Idioma elegido en Ajustes; null = el del dispositivo. Se guarda en el
/// dispositivo y se restaura al abrir la app.
@Riverpod(keepAlive: true)
class AppLocaleUC extends _$AppLocaleUC {
  static const _key = 'app_locale';

  @override
  Locale? build() {
    _restore();
    return null;
  }

  Future<void> _restore() async {
    final code = (await SharedPreferences.getInstance()).getString(_key);
    if (code != null && _isSupported(code)) state = Locale(code);
  }

  static bool _isSupported(String code) =>
      S.delegate.supportedLocales.any((locale) => locale.languageCode == code);

  Future<void> select(Locale? locale) async {
    if (locale == state) return;
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.languageCode);
    }
    // El API traduce los nombres de las categorías según el idioma.
    ref.invalidate(eventCategoriesUCProvider);
  }
}
