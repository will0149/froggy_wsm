import 'package:flutter/material.dart';
import 'package:parkea/app/themes/dimens.dart';
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

  static ThemeData _build(ParkeaColors c, Brightness brightness) {
    final colorScheme = AppTheme.colorScheme(c, brightness);
    final textTheme = parkeaTextTheme(c);
    final buttonText = textTheme.labelLarge!.copyWith(fontSize: 15);
    const buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(ParkeaRadius.md)),
    );
    const buttonSize = Size(64, 48);
    const buttonPadding = EdgeInsets.symmetric(horizontal: ParkeaSpacing.xl);
    // Botón principal: Filled y Elevated se ven igual (hay pantallas que
    // todavía usan ElevatedButton).
    final primaryButton = FilledButton.styleFrom(
      backgroundColor: c.primary,
      foregroundColor: c.onPrimary,
      disabledBackgroundColor: c.onSurface.withValues(alpha: 0.12),
      disabledForegroundColor: c.onSurface.withValues(alpha: 0.38),
      minimumSize: buttonSize,
      padding: buttonPadding,
      shape: buttonShape,
      textStyle: buttonText,
      elevation: 0,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      extensions: <ThemeExtension<ParkeaColors>>[c],
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      fontFamily: parkeaFontFamily,
      textTheme: textTheme,
      dividerTheme: DividerThemeData(color: c.outline, thickness: 1, space: 1),
      inputDecorationTheme: parkeaInputDecorationTheme(c, textTheme),
      filledButtonTheme: FilledButtonThemeData(style: primaryButton),
      elevatedButtonTheme: ElevatedButtonThemeData(style: primaryButton),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: c.primary,
          side: BorderSide(color: c.primary, width: 1.5),
          minimumSize: buttonSize,
          padding: buttonPadding,
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: c.primary,
          padding: const EdgeInsets.symmetric(
              horizontal: ParkeaSpacing.md, vertical: ParkeaSpacing.sm),
          shape: buttonShape,
          textStyle: buttonText,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(foregroundColor: c.onSurface),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.surface,
        foregroundColor: c.primary,
        elevation: 2,
        highlightElevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(ParkeaRadius.lg)),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? c.onPrimary : c.outline),
        trackColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? c.primary : c.background),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? Colors.transparent
                : c.outline),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surface,
        selectedColor: c.primaryContainer,
        disabledColor: c.background,
        checkmarkColor: c.onPrimaryContainer,
        labelStyle: textTheme.labelLarge,
        secondaryLabelStyle:
            textTheme.labelLarge?.copyWith(color: c.onPrimaryContainer),
        iconTheme: IconThemeData(color: c.primary, size: 18),
        padding: const EdgeInsets.symmetric(
            horizontal: ParkeaSpacing.sm, vertical: ParkeaSpacing.sm),
        side: WidgetStateBorderSide.resolveWith((states) => BorderSide(
            color: states.contains(WidgetState.selected)
                ? c.primaryContainer
                : c.outline)),
        shape: const StadiumBorder(),
        showCheckmark: false,
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ParkeaRadius.lg),
          side: BorderSide(color: c.outline),
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: c.primary,
        textColor: c.onSurface,
        subtitleTextStyle: textTheme.bodySmall,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        iconTheme: IconThemeData(color: c.onSurface),
        actionsIconTheme: IconThemeData(color: c.onSurface),
        titleTextStyle: textTheme.titleLarge,
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: c.primary,
        unselectedLabelColor: c.onSurfaceMuted,
        indicatorColor: c.primary,
        dividerColor: c.outline,
        labelStyle: textTheme.titleSmall,
        unselectedLabelStyle: textTheme.titleSmall,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.navBar,
        indicatorColor: c.navIndicator,
        surfaceTintColor: Colors.transparent,
        height: 68,
        elevation: 0,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) => IconThemeData(
              color: states.contains(WidgetState.selected)
                  ? c.onPrimaryContainer
                  : c.onNavBar,
              size: 24,
            )),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            color: selected ? c.primary : c.onNavBar,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
      ),
      badgeTheme: BadgeThemeData(
        backgroundColor: c.reward,
        textColor: c.onReward,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle:
            textTheme.bodyMedium?.copyWith(color: colorScheme.onInverseSurface),
        actionTextColor: colorScheme.inversePrimary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(ParkeaRadius.md)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(ParkeaRadius.xl)),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        dragHandleColor: c.outline,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(ParkeaRadius.xl)),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: c.primary,
        linearTrackColor: c.progressTrack,
      ),
      searchBarTheme: SearchBarThemeData(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(c.surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        side: WidgetStateProperty.resolveWith((states) => BorderSide(
              color:
                  states.contains(WidgetState.focused) ? c.primary : c.outline,
              width: states.contains(WidgetState.focused) ? 2.5 : 1.5,
            )),
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        hintStyle: WidgetStatePropertyAll(
            textTheme.bodyLarge?.copyWith(color: c.onSurfaceMuted)),
        textStyle: WidgetStatePropertyAll(textTheme.bodyLarge),
        padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: ParkeaSpacing.lg)),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: c.surface,
        surfaceTintColor: Colors.transparent,
      ),
      timePickerTheme: TimePickerThemeData(backgroundColor: c.surface),
    );
  }
}
