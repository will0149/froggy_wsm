import 'package:shared_preferences/shared_preferences.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

/// Hitos ya celebrados en este dispositivo, para celebrar cada uno una sola
/// vez (p. ej. `event_full_52`).
class MilestoneStore {
  static const _key = 'celebrated_milestones';

  /// true si [milestone] no se había celebrado; queda marcado.
  static Future<bool> claim(String milestone) async {
    final prefs = await SharedPreferences.getInstance();
    final celebrated = prefs.getStringList(_key) ?? const [];
    if (celebrated.contains(milestone)) return false;
    await prefs.setStringList(_key, [...celebrated, milestone]);
    return true;
  }
}
