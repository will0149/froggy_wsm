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
    Colors.blueAccent,
  ),
  backgroundColor: WidgetStateProperty.all<Color>(
    Colors.white.withValues(alpha: 0.70),
  ),
  overlayColor: WidgetStateProperty.all<Color>(
    parkeaOrange.withValues(alpha: 0.2),
  ),
);
