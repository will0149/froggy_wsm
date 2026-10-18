import 'package:flutter/material.dart';

import 'colors/app_colors.dart';
import 'dimens.dart';
import 'pill_input_border.dart';
import 'text_theme.dart';

/// Inputs de las pantallas de auth (`AuthTheme`), como eran antes del design
/// system.
InputDecorationTheme getParkeaInputDecorationTheme(ParkeaColors parkeaColors) {
  return InputDecorationTheme(
    labelStyle:
        TextStyle(fontFamily: parkeaFontFamily, color: parkeaColors.primary),
    hintStyle:
        TextStyle(fontFamily: parkeaFontFamily, color: parkeaColors.primary),
    suffixStyle:
        TextStyle(fontFamily: parkeaFontFamily, color: parkeaColors.primary),
    helperStyle:
        TextStyle(fontFamily: parkeaFontFamily, color: parkeaColors.primary),
    prefixStyle:
        TextStyle(fontFamily: parkeaFontFamily, color: parkeaColors.primary),
    floatingLabelStyle:
        TextStyle(fontFamily: parkeaFontFamily, color: parkeaColors.primary),
    filled: true,
    fillColor: parkeaColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: parkeaColors.primary,
        width: 4,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: parkeaColors.primary,
        width: 2.5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      gapPadding: 0.0,
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: parkeaColors.primary,
        width: 2.5,
      ),
    ),
  );
}

/// Inputs del design system: la píldora del login (varias líneas con radio
/// 12), borde fino en reposo y azul grueso con foco. La etiqueta es azul
/// solo con foco.
InputDecorationTheme parkeaInputDecorationTheme(
    ParkeaColors c, TextTheme textTheme) {
  PillInputBorder border(Color color, double width) =>
      PillInputBorder(borderSide: BorderSide(color: color, width: width));
  return InputDecorationTheme(
    filled: true,
    fillColor: c.surface,
    contentPadding: const EdgeInsets.symmetric(
        horizontal: ParkeaSpacing.xl, vertical: ParkeaSpacing.lg),
    labelStyle: textTheme.bodyLarge?.copyWith(color: c.onSurfaceMuted),
    floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) => TextStyle(
          fontFamily: parkeaFontFamily,
          color: states.contains(WidgetState.error)
              ? c.error
              : states.contains(WidgetState.focused)
                  ? c.primary
                  : c.onSurfaceMuted,
        )),
    hintStyle: textTheme.bodyLarge?.copyWith(color: c.onSurfaceMuted),
    helperStyle: textTheme.bodySmall,
    errorStyle: textTheme.bodySmall?.copyWith(color: c.error),
    prefixIconColor: WidgetStateColor.resolveWith((states) =>
        states.contains(WidgetState.focused) ? c.primary : c.onSurfaceMuted),
    suffixIconColor: c.onSurfaceMuted,
    border: border(c.outline, 1.5),
    enabledBorder: border(c.outline, 1.5),
    focusedBorder: border(c.primary, 2.5),
    errorBorder: border(c.error, 1.5),
    focusedErrorBorder: border(c.error, 2.5),
    disabledBorder: border(c.outline.withValues(alpha: 0.5), 1.5),
  );
}
