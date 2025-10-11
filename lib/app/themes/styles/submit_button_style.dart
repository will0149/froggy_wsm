import 'package:froggy_soft/app/themes/styles/text_theme.dart';
import 'package:flutter/material.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/10/24

final ButtonStyle raisedButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.any)) {
      return Colors.green;
    }
    return Colors.orangeAccent;
  }),
  // foregroundColor: Colors.white,
  // overlayColor: Colors.white,
  textStyle: WidgetStateProperty.all(getTextTheme().displayLarge),
  minimumSize: WidgetStateProperty.all(Size(88, 50)),
  // fixedSize: const Size(double.infinity, 60),
  padding: WidgetStateProperty.all(
    EdgeInsets.symmetric(horizontal: 16),
  ),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      // side: const BorderSide(width: 1.2),
    ),
  ),
);
