import 'package:flutter/material.dart';

import 'colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 08/01/22

/// Familia de toda la app. Va también en cada estilo del tema: los
/// componentes (botones, chips, etc.) usan su `textStyle` tal cual y no
/// heredan `ThemeData.fontFamily`.
const parkeaFontFamily = 'Nunito';

/// Solo color, con los tamaños por defecto de Material; lo usan las
/// pantallas de auth (`AuthTheme`).
TextTheme getTextTheme(Color textColor) {
  final style = TextStyle(fontFamily: parkeaFontFamily, color: textColor);
  return TextTheme(
    displayLarge: style,
    displayMedium: style,
    displaySmall: style,
    headlineLarge: style,
    headlineMedium: style,
    headlineSmall: style,
    titleLarge: style,
    titleMedium: style,
    titleSmall: style,
    bodyLarge: style,
    bodyMedium: style,
    bodySmall: style,
    labelLarge: style,
    labelMedium: style,
    labelSmall: style,
  );
}

/// Escala tipográfica (Nunito): títulos en negrita para que las pantallas
/// no tengan que hacer `copyWith(fontWeight: bold)`.
TextTheme parkeaTextTheme(ParkeaColors palette) {
  TextStyle style(double size, FontWeight weight, {Color? color}) => TextStyle(
        fontFamily: parkeaFontFamily,
        fontSize: size,
        fontWeight: weight,
        color: color ?? palette.onSurface,
      );
  return TextTheme(
    displayLarge: style(57, FontWeight.w700),
    displayMedium: style(45, FontWeight.w700),
    displaySmall: style(36, FontWeight.w700),
    headlineLarge: style(32, FontWeight.w700),
    headlineMedium: style(28, FontWeight.w700),
    headlineSmall: style(24, FontWeight.w700),
    titleLarge: style(20, FontWeight.w700),
    titleMedium: style(16, FontWeight.w600),
    titleSmall: style(14, FontWeight.w600),
    bodyLarge: style(16, FontWeight.w400),
    bodyMedium: style(14, FontWeight.w400),
    bodySmall: style(12, FontWeight.w400, color: palette.onSurfaceMuted),
    labelLarge: style(14, FontWeight.w600),
    labelMedium: style(12, FontWeight.w600),
    labelSmall: style(11, FontWeight.w500),
  );
}
