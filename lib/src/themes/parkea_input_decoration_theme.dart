import 'package:flutter/material.dart';

import '../constants/colors.dart';

var parkeaInputDecorationTheme = InputDecorationTheme(
  labelStyle: const TextStyle(color: parkeaBlueAccent),
  hintStyle: const TextStyle(color: parkeaBlueAccent),
  suffixStyle: const TextStyle(color: parkeaBlueAccent),
  helperStyle: const TextStyle(color: parkeaBlueAccent),
  prefixStyle: const TextStyle(color: parkeaBlueAccent),
  floatingLabelStyle: const TextStyle(color: parkeaBlueAccent),
  filled: true,
  fillColor: Colors.white.withOpacity(0.70),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: parkeaBlueAccent,
      width: 4,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: parkeaBlueAccent,
      width: 2.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    gapPadding: 0.0,
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: parkeaBlueAccent,
      width: 2.5,
    ),
  ),

);