import 'package:flutter/material.dart';

import 'colors/colors.dart';

ButtonStyle buttonTransparentBlue = ButtonStyle(
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22.0),
      side: const BorderSide(color: parkeaBlueAccent, width: 1.2),
    ),
  ),
  padding: WidgetStateProperty.all<EdgeInsets>(
    const EdgeInsets.all(10),
  ),
  foregroundColor: WidgetStateProperty.all<Color>(
    Colors.blueAccent.withOpacity(1.0),
  ),
  backgroundColor: WidgetStateProperty.all<Color>(
    Colors.white.withOpacity(0.70),
  ),
  overlayColor: WidgetStateProperty.all<Color>(
      parkeaOrange.withOpacity(0.2),
  ),
);
