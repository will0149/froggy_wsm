import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/themes/parkea_input_decoration_theme.dart';
import 'package:parkea/app/themes/text_theme.dart';

import 'colors/app_colors.dart';
/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/24/23
 */

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    extensions: <ThemeExtension<AppColors>>[
      AppColors(
        color1: isDarkTheme ? Colors.blue : Colors.green,
        color2: isDarkTheme ? Colors.pink : Colors.blue,
        color3: isDarkTheme ? Colors.yellow : Colors.red,
      ),
    ],
    scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white,
    primarySwatch: Colors.cyan,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(
          isDarkTheme ? parkeaOrange : parkeaBlueAccent),
    ),
    listTileTheme: ListTileThemeData(
        iconColor: isDarkTheme ? Colors.orange : Colors.purple,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: isDarkTheme ? Colors.black : Colors.white,
      elevation: 0.10,
      iconTheme:
          IconThemeData(color: isDarkTheme ? Colors.white : Colors.black54),
    ),
    fontFamily: 'Gothic A1',
    inputDecorationTheme: parkeaInputDecorationTheme,
    textTheme: textThemeParkea,
        // .copyWith(
        //   titleSmall:
        //       Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 8),
        // )
        // .apply(
        //   bodyColor: isDarkTheme ? Colors.white : Colors.black,
        //   displayColor: Colors.grey,
        // ),
  );
}