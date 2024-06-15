import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/10/24
 */

var inputDecorationTheme = InputDecorationTheme(
  labelStyle: const TextStyle(color: Colors.black),
  hintStyle: const TextStyle(color: Colors.black54),
  suffixStyle: const TextStyle(color: Colors.black),
  helperStyle: const TextStyle(color: Colors.black54),
  prefixStyle: const TextStyle(color: Colors.black),
  floatingLabelStyle: const TextStyle(color: Colors.black),
  filled: true,
  fillColor: Colors.white.withOpacity(0.70),
  errorStyle: const TextStyle(color: Colors.red),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(
      color: Colors.black87,
      width: 2,
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(
      color: Colors.black87,
      width: 0.5,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(18),
    borderSide: const BorderSide(
      color: Colors.purple,
      width: 2.0,
    ),
  )
);
