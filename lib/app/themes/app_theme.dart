import 'package:cct_management/app/constants.dart';
import 'package:cct_management/app/themes/styles/input_decoration.dart';
import 'package:cct_management/app/themes/styles/submit_button_style.dart';
import 'package:cct_management/app/themes/styles/text_theme.dart';
import 'package:flutter/material.dart';

import 'colors/app_colors.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/10/24

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        color1: isDarkTheme ? Colors.blue : Colors.green,
        color2: isDarkTheme ? Colors.pink : Colors.blue,
        color3: isDarkTheme ? Colors.yellow : Colors.red,
      ),
    ],
    fontFamily: 'Ubuntu',
    textTheme: getTextTheme(),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.9,
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    cardTheme: const CardTheme(
      elevation: 15.0,
      margin: EdgeInsets.all(10.0),
    ),
    inputDecorationTheme: inputDecorationTheme,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: raisedButtonStyle,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: inputDecorationTheme,
    ),
    buttonTheme: ButtonThemeData(
      // buttonColor: isDarkTheme ? parkeaDarkBlueAccent : parkeaLightOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: const BorderSide(width: 1.2),
      ),
    ),
    iconTheme: IconThemeData(
      color: backGroundColor
    )
  );
}
