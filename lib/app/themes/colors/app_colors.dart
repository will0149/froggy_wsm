import 'package:flutter/material.dart';
import 'colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/24/23

ParkeaColors colors(BuildContext context) => Theme.of(context).extension<ParkeaColors>()!;

@immutable
class ParkeaColors extends ThemeExtension<ParkeaColors> {
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color onSurface;
  final Color background;
  final Color error;
  final Color onError;

  const ParkeaColors({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.error,
    required this.onError,
  });

  factory ParkeaColors.light() {
    return const ParkeaColors(
      primary: parkeaBlueAccent,
      secondary: parkeaOrange,
      surface: parkeaWhite,
      onSurface: parkeaBlack,
      background: parkeaWhite,
      error: Color(0xFFB00020),
      onError: parkeaWhite,
    );
  }

  factory ParkeaColors.dark() {
    return const ParkeaColors(
      primary: parkeaBlueAccent,
      secondary: parkeaOrange,
      surface: parkeaBlack,
      onSurface: parkeaWhite,
      background: parkeaBlack,
      error: Color(0xFFCF6679),
      onError: parkeaBlack,
    );
  }

  @override
  ParkeaColors copyWith({
    Color? primary,
    Color? secondary,
    Color? surface,
    Color? onSurface,
    Color? background,
    Color? error,
    Color? onError,
  }) {
    return ParkeaColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
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
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      background: Color.lerp(background, other.background, t) ?? background,
      error: Color.lerp(error, other.error, t) ?? error,
      onError: Color.lerp(onError, other.onError, t) ?? onError,
    );
  }
}
