import 'package:flutter/material.dart';
import 'package:parkea/app/themes/border_radius.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/themes/parkea_input_decoration_theme.dart';
import 'package:parkea/app/themes/text_theme.dart';

import 'colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/24/23

/// Tema de antes del design system, congelado para las pantallas de auth
/// (bienvenida, login, registro y recuperar contraseña), que se mantienen
/// como están. El resto de la app usa `AppTheme`.
class AuthTheme extends StatelessWidget {
  final Widget child;

  const AuthTheme({super.key, required this.child});

  static final ThemeData light = _build(isDark: false);
  static final ThemeData dark = _build(isDark: true);

  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).brightness == Brightness.dark ? dark : light,
        child: child,
      );

  static ThemeData _build({required bool isDark}) {
    final parkeaColors = ParkeaColors.legacy(isDark: isDark);
    final colorScheme = isDark ? _darkColorScheme : _lightColorScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: <ThemeExtension<ParkeaColors>>[
        parkeaColors,
      ],
      scaffoldBackgroundColor: parkeaColors.background,
      fontFamily: parkeaFontFamily,
      inputDecorationTheme: getParkeaInputDecorationTheme(parkeaColors),
      textTheme: getTextTheme(parkeaColors.onSurface),
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
        titleTextStyle:
            getTextTheme(parkeaColors.onSurface).titleLarge?.copyWith(
                  color: parkeaColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
      ),
      cardTheme: CardThemeData(
        color: parkeaColors.surface,
        elevation: 2,
        shadowColor: parkeaColors.onSurface.withValues(alpha: 0.12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ParkeaBorderRadius.card),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: parkeaColors.secondary,
          foregroundColor: colorScheme.onSecondary,
          elevation: 2,
          shadowColor: parkeaColors.secondary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: parkeaFontFamily,
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
            borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(
            fontFamily: parkeaFontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: parkeaColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          textStyle: const TextStyle(
            fontFamily: parkeaFontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: parkeaColors.surface,
        selectedColor: parkeaColors.secondary.withValues(alpha: 0.12),
        secondarySelectedColor: parkeaColors.secondary,
        labelStyle: TextStyle(
            fontFamily: parkeaFontFamily, color: parkeaColors.onSurface),
        secondaryLabelStyle: TextStyle(
            fontFamily: parkeaFontFamily, color: parkeaColors.secondary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
          side: BorderSide(color: parkeaColors.primary.withValues(alpha: 0.2)),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: parkeaColors.secondary,
        foregroundColor: colorScheme.onSecondary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ParkeaBorderRadius.button),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: parkeaColors.navBar,
        indicatorColor: parkeaColors.navIndicator,
        height: 68,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStatePropertyAll(
          IconThemeData(color: parkeaColors.onNavBar, size: 26),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => TextStyle(
            fontFamily: parkeaFontFamily,
            color: parkeaColors.onNavBar,
            fontSize: 11,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.bold
                : FontWeight.w500,
          ),
        ),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: parkeaColors.reward,
        textColor: parkeaColors.onReward,
      ),
    );
  }
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
