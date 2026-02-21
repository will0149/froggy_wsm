import 'package:flutter/material.dart';

import 'colors/app_colors.dart';

InputDecorationTheme getParkeaInputDecorationTheme(ParkeaColors parkeaColors) {
  return InputDecorationTheme(
    labelStyle: TextStyle(color: parkeaColors.primary),
    hintStyle: TextStyle(color: parkeaColors.primary),
    suffixStyle: TextStyle(color: parkeaColors.primary),
    helperStyle: TextStyle(color: parkeaColors.primary),
    prefixStyle: TextStyle(color: parkeaColors.primary),
    floatingLabelStyle: TextStyle(color: parkeaColors.primary),
    filled: true,
    fillColor: parkeaColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: parkeaColors.primary,
        width: 4,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: parkeaColors.primary,
        width: 2.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      gapPadding: 0.0,
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: parkeaColors.primary,
        width: 2.5,
      ),
    ),
  );
}