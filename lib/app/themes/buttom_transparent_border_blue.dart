import 'package:flutter/material.dart';

import '../../app/colors.dart';

ButtonStyle buttonTransparentBlue = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22.0),
      side: const BorderSide(color: parkeaBlueAccent, width: 1.2),
    ),
  ),
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.all(10),
  ),
  foregroundColor: MaterialStateProperty.all<Color>(
    Colors.blueAccent.withOpacity(1.0),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(
    Colors.white.withOpacity(0.70),
  ),
  overlayColor: MaterialStateProperty.all<Color>(
      parkeaOrange.withOpacity(0.2),
  ),
);
