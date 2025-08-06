import 'package:flutter/material.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/themes/parkea_input_decoration_theme.dart';
import 'package:parkea/app/themes/text_theme.dart';

import 'colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/24/23

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  final parkeaColors = isDarkTheme ? ParkeaColors.dark() : ParkeaColors.light();
  final colorScheme = isDarkTheme ? _darkColorScheme : _lightColorScheme;
  
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    extensions: <ThemeExtension<ParkeaColors>>[
      parkeaColors,
    ],
    scaffoldBackgroundColor: parkeaColors.background,
    fontFamily: 'GothicA1',
    inputDecorationTheme: parkeaInputDecorationTheme,
    textTheme: getTextTheme(isDarkTheme),
    
    // Modern Material Design 3 components
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return parkeaColors.secondary;
        }
        return parkeaColors.onSurface.withValues(alpha: 0.38);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return parkeaColors.secondary.withValues(alpha: 0.54);
        }
        return parkeaColors.onSurface.withValues(alpha: 0.12);
      }),
    ),
    
    listTileTheme: ListTileThemeData(
      iconColor: parkeaColors.primary,
      textColor: parkeaColors.onSurface,
    ),
    
    appBarTheme: AppBarTheme(
      backgroundColor: parkeaColors.surface,
      foregroundColor: parkeaColors.onSurface,
      elevation: 0,
      surfaceTintColor: parkeaColors.surface,
      iconTheme: IconThemeData(color: parkeaColors.primary),
      titleTextStyle: getTextTheme(isDarkTheme).titleLarge?.copyWith(
        color: parkeaColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: parkeaColors.surface,
      elevation: 2,
      shadowColor: parkeaColors.onSurface.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: parkeaColors.secondary,
        foregroundColor: parkeaColors.onError,
        elevation: 2,
        shadowColor: parkeaColors.secondary.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: parkeaColors.primary,
        side: BorderSide(color: parkeaColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: parkeaColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
    ),
    
    chipTheme: ChipThemeData(
      backgroundColor: parkeaColors.surface,
      selectedColor: parkeaColors.secondary.withValues(alpha: 0.12),
      secondarySelectedColor: parkeaColors.secondary,
      labelStyle: TextStyle(color: parkeaColors.onSurface),
      secondaryLabelStyle: TextStyle(color: parkeaColors.secondary),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: parkeaColors.primary.withValues(alpha: 0.2)),
      ),
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: parkeaColors.secondary,
      foregroundColor: parkeaColors.onError,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: parkeaColors.surface,
      selectedItemColor: parkeaColors.secondary,
      unselectedItemColor: parkeaColors.onSurface.withValues(alpha: 0.6),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: parkeaColors.surface,
      indicatorColor: parkeaColors.secondary.withValues(alpha: 0.12),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: parkeaColors.secondary);
        }
        return IconThemeData(color: parkeaColors.onSurface.withValues(alpha: 0.6));
      }),
    ),
  );
}

final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
  seedColor: parkeaBlueAccent,
  brightness: Brightness.light,
  primary: parkeaBlueAccent,
  secondary: parkeaOrange,
  tertiary: parkeaLightOrange,
  surface: parkeaWhite,
  onSurface: parkeaBlack,
  error: const Color(0xFFB00020),
  onError: parkeaWhite,
);

final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
  seedColor: parkeaBlueAccent,
  brightness: Brightness.dark,
  primary: parkeaBlueAccent,
  secondary: parkeaOrange,
  tertiary: parkeaLightOrange,
  surface: parkeaBlack,
  onSurface: parkeaWhite,
  error: const Color(0xFFCF6679),
  onError: parkeaBlack,
);
