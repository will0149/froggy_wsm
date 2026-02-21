import 'package:flutter/material.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 08/01/22

TextTheme getTextTheme(Color textColor) {
  final style = TextStyle(color: textColor);
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
