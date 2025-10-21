import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_provider.g.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 08/03/23

@riverpod
class AppTheme extends _$AppTheme {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }

  void setTheme(bool isDark) {
    state = isDark;
  }
}