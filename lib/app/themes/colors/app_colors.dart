import 'package:flutter/material.dart';
import 'colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/24/23

ParkeaColors colors(BuildContext context) => Theme.of(context).extension<ParkeaColors>()!;

@immutable
class ParkeaColors extends ThemeExtension<ParkeaColors> {
  final Color primary;
  final Color primaryDark;
  final Color secondary;
  final Color accent;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color onBackground;
  final Color error;
  final Color onError;

  const ParkeaColors({
    required this.primary,
    required this.primaryDark,
    required this.secondary,
    required this.accent,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.onBackground,
    required this.error,
    required this.onError,
  });

  factory ParkeaColors.light() {
    return const ParkeaColors(
      primary: parkeaBlueAccent,
      primaryDark: parkeaDarkBlueAccent,
      secondary: parkeaOrange,
      accent: parkeaLightOrange,
      surface: parkeaWhite,
      onSurface: parkeaBlack,
      background: parkeaWhite,
      onBackground: parkeaBlack,
      error: Color(0xFFB00020),
      onError: parkeaWhite,
    );
  }

  factory ParkeaColors.dark() {
    return const ParkeaColors(
      primary: parkeaBlueAccent,
      primaryDark: parkeaDarkBlueAccent,
      secondary: parkeaOrange,
      accent: parkeaLightOrange,
      surface: parkeaBlack,
      onSurface: parkeaWhite,
      background: parkeaBlack,
      onBackground: parkeaWhite,
      error: Color(0xFFCF6679),
      onError: parkeaBlack,
    );
  }

  @override
  ParkeaColors copyWith({
    Color? primary,
    Color? primaryDark,
    Color? secondary,
    Color? accent,
    Color? surface,
    Color? onSurface,
    Color? background,
    Color? onBackground,
    Color? error,
    Color? onError,
  }) {
    return ParkeaColors(
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      secondary: secondary ?? this.secondary,
      accent: accent ?? this.accent,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      error: error ?? this.error,
      onError: onError ?? this.onError,
    );
  }

  @override
  ParkeaColors lerp(ThemeExtension<ParkeaColors>? other, double t) {
    if (other is! ParkeaColors) {
      return this;
    }
    return ParkeaColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t) ?? primaryDark,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      background: Color.lerp(background, other.background, t) ?? background,
      onBackground: Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
      error: Color.lerp(error, other.error, t) ?? error,
      onError: Color.lerp(onError, other.onError, t) ?? onError,
    );
  }
}