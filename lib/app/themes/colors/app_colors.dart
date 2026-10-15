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

  /// Barra de navegación inferior y su contenido.
  final Color navBar;
  final Color onNavBar;

  /// Píldora detrás del destino activo.
  final Color navIndicator;

  /// Elementos de recompensa (contadores, logros): lo único con color vivo
  /// sobre la barra.
  final Color reward;
  final Color onReward;

  const ParkeaColors({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.onSurface,
    required this.background,
    required this.error,
    required this.onError,
    required this.navBar,
    required this.onNavBar,
    required this.navIndicator,
    required this.reward,
    required this.onReward,
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
      navBar: parkeaOrange,
      onNavBar: parkeaWhite,
      navIndicator: Color(0x3DFFFFFF),
      reward: parkeaWhite,
      onReward: parkeaDarkOrange,
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
      navBar: parkeaDarkBlueAccent,
      onNavBar: parkeaWhite,
      navIndicator: Color(0x3DFFFFFF),
      reward: parkeaOrange,
      onReward: parkeaWhite,
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
    Color? navBar,
    Color? onNavBar,
    Color? navIndicator,
    Color? reward,
    Color? onReward,
  }) {
    return ParkeaColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      background: background ?? this.background,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      navBar: navBar ?? this.navBar,
      onNavBar: onNavBar ?? this.onNavBar,
      navIndicator: navIndicator ?? this.navIndicator,
      reward: reward ?? this.reward,
      onReward: onReward ?? this.onReward,
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
      navBar: Color.lerp(navBar, other.navBar, t) ?? navBar,
      onNavBar: Color.lerp(onNavBar, other.onNavBar, t) ?? onNavBar,
      navIndicator:
          Color.lerp(navIndicator, other.navIndicator, t) ?? navIndicator,
      reward: Color.lerp(reward, other.reward, t) ?? reward,
      onReward: Color.lerp(onReward, other.onReward, t) ?? onReward,
    );
  }
}
