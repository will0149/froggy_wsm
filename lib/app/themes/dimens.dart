// Made for parkea.
// By User: josedominguez
// Date: 10/16/26

/// Radios del design system (ver `docs/propuesta-design-system.md`).
abstract final class ParkeaRadius {
  /// Badges e insignias.
  static const double sm = 8;

  /// Botones e inputs de varias líneas.
  static const double md = 12;

  /// Tarjetas y hojas.
  static const double lg = 16;

  /// Encabezados, diálogos y hojas inferiores.
  static const double xl = 24;

  /// Píldoras: inputs de una línea y chips.
  static const double full = 999;
}

/// Espacios en múltiplos de 4.
abstract final class ParkeaSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Margen lateral de las pantallas.
  static const double screen = lg;
}
