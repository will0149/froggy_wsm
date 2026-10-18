import 'package:flutter/material.dart';
import 'colors.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/24/23

ParkeaColors colors(BuildContext context) =>
    Theme.of(context).extension<ParkeaColors>()!;

/// Tokens de color (ver `docs/propuesta-design-system.md`): azul = acción,
/// naranja = marca y emoción, neutros = estructura. Las pantallas usan estos
/// tokens o el `ColorScheme`, nunca `Colors.x` ni `parkeaOrange`.
@immutable
class ParkeaColors extends ThemeExtension<ParkeaColors> {
  /// Acción: botones, links, foco, selección y tab activo.
  final Color primary;
  final Color onPrimary;

  /// Fondos suaves de acción: chip seleccionado, indicador del tab.
  final Color primaryContainer;
  final Color onPrimaryContainer;

  /// Naranja de marca: formas, ilustraciones, botón Crear, celebraciones.
  /// No lleva texto blanco (2.5:1).
  final Color brand;
  final Color onBrand;

  /// Naranja que sí lleva texto: insignias, contador del badge.
  final Color brandStrong;
  final Color onBrandStrong;

  /// Fondo de recompensas, logros y la insignia de precio.
  final Color brandContainer;
  final Color onBrandContainer;

  /// Tarjetas, hojas e inputs, sobre [background].
  final Color surface;
  final Color background;
  final Color onSurface;

  /// Texto secundario.
  final Color onSurfaceMuted;

  /// Bordes y divisores.
  final Color outline;

  final Color success;
  final Color warning;
  final Color error;
  final Color onError;

  /// Barra de navegación inferior y sus destinos inactivos (el activo usa
  /// [primary]).
  final Color navBar;
  final Color onNavBar;

  /// Píldora detrás del destino activo.
  final Color navIndicator;

  /// Elementos de recompensa con texto (contador de Tickets).
  final Color reward;
  final Color onReward;

  /// Barras de progreso: fondo y relleno; [success] cuando se completa.
  final Color progressTrack;
  final Color progress;

  /// Naranja de marca; alias de [brand] para el código existente.
  Color get secondary => brand;

  const ParkeaColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.brand,
    required this.onBrand,
    required this.brandStrong,
    required this.onBrandStrong,
    required this.brandContainer,
    required this.onBrandContainer,
    required this.surface,
    required this.background,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.outline,
    required this.success,
    required this.warning,
    required this.error,
    required this.onError,
    required this.navBar,
    required this.onNavBar,
    required this.navIndicator,
    required this.reward,
    required this.onReward,
    required this.progressTrack,
    required this.progress,
  });

  factory ParkeaColors.light() {
    return const ParkeaColors(
      // El azul del login un tono más oscuro: 4.8:1 sobre [background].
      primary: Color(0xFF037791),
      onPrimary: parkeaWhite,
      primaryContainer: Color(0xFFE6F3F6),
      onPrimaryContainer: parkeaDarkBlueAccent,
      brand: parkeaOrange,
      onBrand: parkeaBlack,
      brandStrong: Color(0xFFC2410C),
      onBrandStrong: parkeaWhite,
      brandContainer: Color(0xFFFFF4E8),
      onBrandContainer: Color(0xFF9A3412),
      surface: parkeaWhite,
      background: Color(0xFFF7F5F4),
      onSurface: parkeaBlack,
      onSurfaceMuted: Color(0xFF6B6464),
      outline: Color(0xFFD9D3D1),
      success: Color(0xFF2E7D32),
      warning: Color(0xFFB45309),
      error: Color(0xFFB3261E),
      onError: parkeaWhite,
      navBar: parkeaWhite,
      onNavBar: Color(0xFF6B6464),
      navIndicator: Color(0xFFE6F3F6),
      reward: Color(0xFFC2410C),
      onReward: parkeaWhite,
      progressTrack: Color(0xFFEDE7E3),
      progress: parkeaOrange,
    );
  }

  factory ParkeaColors.dark() {
    return const ParkeaColors(
      primary: Color(0xFF4FB3CB),
      onPrimary: Color(0xFF0B2A33),
      primaryContainer: Color(0xFF0E3D4A),
      onPrimaryContainer: Color(0xFFCDEBF2),
      brand: parkeaOrange,
      onBrand: Color(0xFF1E1B1B),
      brandStrong: Color(0xFFFB923C),
      onBrandStrong: Color(0xFF1E1B1B),
      brandContainer: Color(0xFF3D2A1A),
      onBrandContainer: Color(0xFFFED7AA),
      surface: Color(0xFF1E1B1B),
      background: Color(0xFF151313),
      onSurface: Color(0xFFF2EFEE),
      onSurfaceMuted: Color(0xFFB3ABAA),
      outline: Color(0xFF4A4545),
      success: Color(0xFF66BB6A),
      warning: Color(0xFFFBBF24),
      error: Color(0xFFF2B8B5),
      onError: Color(0xFF601410),
      navBar: Color(0xFF1E1B1B),
      onNavBar: Color(0xFFB3ABAA),
      navIndicator: Color(0xFF0E3D4A),
      reward: Color(0xFFFB923C),
      onReward: Color(0xFF1E1B1B),
      progressTrack: Color(0xFF4A4545),
      progress: parkeaOrange,
    );
  }

  /// Colores de antes del design system; solo para las pantallas de auth,
  /// que se mantienen como están (ver `AuthTheme`).
  factory ParkeaColors.legacy({required bool isDark}) {
    final base = isDark ? ParkeaColors.dark() : ParkeaColors.light();
    return base.copyWith(
      navBar: isDark ? parkeaDarkBlueAccent : parkeaOrange,
      onNavBar: parkeaWhite,
      navIndicator: const Color(0x3DFFFFFF),
      reward: isDark ? parkeaOrange : parkeaWhite,
      onReward: isDark ? parkeaWhite : parkeaDarkOrange,
      primary: parkeaBlueAccent,
      surface: isDark ? parkeaBlack : parkeaWhite,
      background: isDark ? parkeaBlack : parkeaWhite,
      onSurface: isDark ? parkeaWhite : parkeaBlack,
      error: isDark ? const Color(0xFFCF6679) : const Color(0xFFB00020),
      onError: isDark ? parkeaBlack : parkeaWhite,
    );
  }

  @override
  ParkeaColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? brand,
    Color? onBrand,
    Color? brandStrong,
    Color? onBrandStrong,
    Color? brandContainer,
    Color? onBrandContainer,
    Color? surface,
    Color? background,
    Color? onSurface,
    Color? onSurfaceMuted,
    Color? outline,
    Color? success,
    Color? warning,
    Color? error,
    Color? onError,
    Color? navBar,
    Color? onNavBar,
    Color? navIndicator,
    Color? reward,
    Color? onReward,
    Color? progressTrack,
    Color? progress,
  }) {
    return ParkeaColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      brand: brand ?? this.brand,
      onBrand: onBrand ?? this.onBrand,
      brandStrong: brandStrong ?? this.brandStrong,
      onBrandStrong: onBrandStrong ?? this.onBrandStrong,
      brandContainer: brandContainer ?? this.brandContainer,
      onBrandContainer: onBrandContainer ?? this.onBrandContainer,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
      outline: outline ?? this.outline,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      navBar: navBar ?? this.navBar,
      onNavBar: onNavBar ?? this.onNavBar,
      navIndicator: navIndicator ?? this.navIndicator,
      reward: reward ?? this.reward,
      onReward: onReward ?? this.onReward,
      progressTrack: progressTrack ?? this.progressTrack,
      progress: progress ?? this.progress,
    );
  }

  @override
  ParkeaColors lerp(ThemeExtension<ParkeaColors>? other, double t) {
    if (other is! ParkeaColors) {
      return this;
    }
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return ParkeaColors(
      primary: mix(primary, other.primary),
      onPrimary: mix(onPrimary, other.onPrimary),
      primaryContainer: mix(primaryContainer, other.primaryContainer),
      onPrimaryContainer: mix(onPrimaryContainer, other.onPrimaryContainer),
      brand: mix(brand, other.brand),
      onBrand: mix(onBrand, other.onBrand),
      brandStrong: mix(brandStrong, other.brandStrong),
      onBrandStrong: mix(onBrandStrong, other.onBrandStrong),
      brandContainer: mix(brandContainer, other.brandContainer),
      onBrandContainer: mix(onBrandContainer, other.onBrandContainer),
      surface: mix(surface, other.surface),
      background: mix(background, other.background),
      onSurface: mix(onSurface, other.onSurface),
      onSurfaceMuted: mix(onSurfaceMuted, other.onSurfaceMuted),
      outline: mix(outline, other.outline),
      success: mix(success, other.success),
      warning: mix(warning, other.warning),
      error: mix(error, other.error),
      onError: mix(onError, other.onError),
      navBar: mix(navBar, other.navBar),
      onNavBar: mix(onNavBar, other.onNavBar),
      navIndicator: mix(navIndicator, other.navIndicator),
      reward: mix(reward, other.reward),
      onReward: mix(onReward, other.onReward),
      progressTrack: mix(progressTrack, other.progressTrack),
      progress: mix(progress, other.progress),
    );
  }
}

/// Colores sobre fotos (banners, burbujas del mapa): no dependen del tema
/// porque la imagen no cambia con el modo oscuro.
abstract final class ParkeaOverlay {
  /// Texto e íconos sobre una imagen o un velo.
  static const onImage = Color(0xFFFFFFFF);

  /// Velo para que [onImage] se lea sobre cualquier foto.
  static const scrim = Color(0x8A000000);

  /// Sombra de elementos flotantes sobre el mapa o una imagen.
  static const shadow = Color(0x42000000);

  /// Etiqueta clara sobre el mapa (crédito de OSM) y su texto: los tiles
  /// del mapa son claros en los dos modos.
  static const mapLabel = Color(0xB3FFFFFF);
  static const onMapLabel = parkeaBlack;

  /// QR compartido como imagen: negro sobre blanco en los dos modos, como
  /// lo esperan los lectores.
  static const qrModules = Color(0xFF000000);
  static const qrBackground = Color(0xFFFFFFFF);

  /// Degradado azul de marca: encabezado del perfil y eventos sin imagen.
  /// Hace de foto, así que es igual en los dos modos.
  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [parkeaBlueAccent, parkeaDarkBlueAccent],
  );
}
