import 'package:flutter/material.dart';

import '../colors.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 08/01/22
 */

TextTheme getTextTheme(bool isDarkTheme) {
  return TextTheme(
    displayLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccentOpacity,
    ),
    displayMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    displaySmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    headlineLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    headlineMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    headlineSmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    titleLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    titleMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    titleSmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    //
    bodyLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    bodyMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    bodySmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    labelLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    labelMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
    labelSmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlueAccent,
    ),
  );
}
