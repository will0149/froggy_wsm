import 'package:cct_management/app/themes/styles/text_theme.dart';
import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/10/24
 */

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.deepOrangeAccent,
  overlayColor: Colors.white,
  textStyle: getTextTheme().displayLarge,
  // minimumSize: Size(88, 36),
  fixedSize: Size(double.infinity, 60),
  padding: EdgeInsets.symmetric(horizontal: 16),
);