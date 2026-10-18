import 'package:shared_preferences/shared_preferences.dart';

import 'logger_config.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/22

/// Si la bienvenida aún no se completó en esta instalación.
class IsFirstRun {
  static const _firstRunSettingsKey = 'is_first_run';

  static bool? _isFirstRun;

  /// true hasta que se llame a [complete]: si la app se cierra a mitad de
  /// la bienvenida, se vuelve a mostrar.
  Future<bool> isFirstRun() async {
    if (_isFirstRun case final cached?) return cached;
    logger.i('Validating if its first run');
    try {
      final prefs = await SharedPreferences.getInstance();
      _isFirstRun = prefs.getBool(_firstRunSettingsKey) ?? true;
    } on Exception {
      _isFirstRun = true;
    }
    return _isFirstRun!;
  }

  /// Marca la bienvenida como vista. Cambia el valor en memoria antes de
  /// guardarlo para que quien lea después (p. ej. al recargar la sesión) ya
  /// vea false.
  Future<void> complete() async {
    _isFirstRun = false;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstRunSettingsKey, false);
  }
}
