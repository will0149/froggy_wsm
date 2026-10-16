import 'package:flutter/material.dart';
import 'package:parkea/app/themes/border_radius.dart';
import 'package:parkea/app/themes/parkea_input_decoration_theme.dart';
import 'package:parkea/app/themes/text_theme.dart';

import 'colors/app_colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/24/23

/// Tema de la app desde los tokens de [ParkeaColors] (ver
/// `docs/propuesta-design-system.md`). Las pantallas de auth usan
/// `AuthTheme`.
class AppTheme {
  AppTheme._();

  static final ThemeData light = _build(ParkeaColors.light(), Brightness.light);
  static final ThemeData dark = _build(ParkeaColors.dark(), Brightness.dark);

  /// Explícito, sin `fromSeed`, para que Material no invente tonos.
  static ColorScheme colorScheme(ParkeaColors c, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      primaryContainer: c.primaryContainer,
      onPrimaryContainer: c.onPrimaryContainer,
      secondary: c.brand,
      onSecondary: c.onBrand,
      secondaryContainer: c.brandContainer,
      onSecondaryContainer: c.onBrandContainer,
      tertiary: c.brandStrong,
      onTertiary: c.onBrandStrong,
      error: c.error,
      onError: c.onError,
      errorContainer:
          isDark ? const Color(0xFF8C1D18) : const Color(0xFFF9DEDC),
      onErrorContainer:
          isDark ? const Color(0xFFF9DEDC) : const Color(0xFF410E0B),
      surface: c.surface,
      onSurface: c.onSurface,
      onSurfaceVariant: c.onSurfaceMuted,
      surfaceDim: isDark ? c.background : const Color(0xFFE5E0DE),
      surfaceBright: isDark ? const Color(0xFF3A3535) : c.surface,
      surfaceContainerLowest: isDark ? c.background : c.surface,
      surfaceContainerLow:
          isDark ? const Color(0xFF1A1717) : const Color(0xFFFBFAF9),
      surfaceContainer: isDark ? const Color(0xFF221F1F) : c.background,
      surfaceContainerHigh:
          isDark ? const Color(0xFF2B2727) : const Color(0xFFF1EEED),
      surfaceContainerHighest:
          isDark ? const Color(0xFF353030) : const Color(0xFFEAE6E5),
      outline: c.outline,
      outlineVariant:
          isDark ? const Color(0xFF3A3535) : const Color(0xFFEAE5E3),
      inverseSurface: c.onSurface,
      onInverseSurface: c.surface,
      inversePrimary:
          isDark ? const Color(0xFF037791) : const Color(0xFF4FB3CB),
      shadow: Colors.black,
      scrim: Colors.black,
      // Sin tinte azul en las superficies elevadas.
      surfaceTint: Colors.transparent,
    );
  }

  static ThemeData _build(ParkeaColors parkeaColors, Brightness brightness) {
    final colorScheme = AppTheme.colorScheme(parkeaColors, brightness);
    final textTheme = parkeaTextTheme(parkeaColors);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: <ThemeExtension<ParkeaColors>>[
        parkeaColors,
      ],
      scaffoldBackgroundColor: parkeaColors.background,
      fontFamily: 'GothicA1',
      inputDecorationTheme: getParkeaInputDecorationTheme(parkeaColors),
      textTheme: textTheme,
      dividerColor: parkeaColors.outline,

      // Componentes: se rediseñan en la fase 2.
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
        titleTextStyle: textTheme.titleLarge,
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
