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
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    displaySmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    headlineLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    headlineMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    headlineSmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    titleLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    titleMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    titleSmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    //
    bodyLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    bodyMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    bodySmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    labelLarge: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    labelMedium: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
    labelSmall: TextStyle(
      color: isDarkTheme ? parkeaWhite :parkeaBlack,
    ),
  );
}
