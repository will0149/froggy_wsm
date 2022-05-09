import 'package:flutter/material.dart';

var parkeaInputDecorationTheme = InputDecorationTheme(
  labelStyle: TextStyle(color: Colors.cyan),
  hintStyle: TextStyle(color: Colors.cyan),
  suffixStyle: TextStyle(color: Colors.cyan),
  helperStyle: TextStyle(color: Colors.cyan),
  prefixStyle: TextStyle(color: Colors.cyan),
  floatingLabelStyle: const TextStyle(color: Colors.cyan),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Colors.cyan,
      width: 4,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Colors.cyan,
      width: 2.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    gapPadding: 0.0,
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(
      color: Colors.cyan,
      width: 2.5,
    ),
  ),
);