import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import 'dimens.dart';

// Made for parkea.
// By User: josedominguez
// Date: 10/16/26

/// Borde de input del design system: píldora en los campos de una línea
/// (como el login) y [multilineRadius] en los de varias líneas, donde la
/// píldora se deforma. Se define una vez en el tema, sin que cada campo
/// tenga que elegir.
class PillInputBorder extends OutlineInputBorder {
  /// Más alto que esto ya no es un campo de una línea.
  static const _singleLineMaxHeight = 64.0;

  final double multilineRadius;

  const PillInputBorder({
    super.borderSide,
    super.gapPadding,
    this.multilineRadius = ParkeaRadius.md,
  });

  OutlineInputBorder _resolve(Rect rect) => OutlineInputBorder(
        borderSide: borderSide,
        gapPadding: gapPadding,
        borderRadius: BorderRadius.circular(
          rect.height <= _singleLineMaxHeight
              ? rect.height / 2
              : multilineRadius,
        ),
      );

  @override
  PillInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
  }) =>
      PillInputBorder(
        borderSide: borderSide ?? this.borderSide,
        gapPadding: gapPadding ?? this.gapPadding,
        multilineRadius: multilineRadius,
      );

  @override
  PillInputBorder scale(double t) => PillInputBorder(
        borderSide: borderSide.scale(t),
        gapPadding: gapPadding * t,
        multilineRadius: multilineRadius * t,
      );

  // Sin esto, la animación entre estados (reposo → foco) pasaría por un
  // OutlineInputBorder de esquinas rectas.
  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) => a is PillInputBorder
      ? PillInputBorder(
          borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
          gapPadding: lerpDouble(a.gapPadding, gapPadding, t)!,
          multilineRadius: lerpDouble(a.multilineRadius, multilineRadius, t)!,
        )
      : super.lerpFrom(a, t);

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) => b is PillInputBorder
      ? PillInputBorder(
          borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
          gapPadding: lerpDouble(gapPadding, b.gapPadding, t)!,
          multilineRadius: lerpDouble(multilineRadius, b.multilineRadius, t)!,
        )
      : super.lerpTo(b, t);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      _resolve(rect).getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      _resolve(rect).getOuterPath(rect, textDirection: textDirection);

  // El fondo (`filled`) se pinta con esto; sin delegarlo usaría el radio
  // por defecto de OutlineInputBorder (4) y asomaría bajo la píldora.
  @override
  void paintInterior(Canvas canvas, Rect rect, Paint paint,
          {TextDirection? textDirection}) =>
      _resolve(rect)
          .paintInterior(canvas, rect, paint, textDirection: textDirection);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) =>
      _resolve(rect).paint(
        canvas,
        rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection,
      );

  @override
  bool operator ==(Object other) =>
      other is PillInputBorder &&
      other.borderSide == borderSide &&
      other.gapPadding == gapPadding &&
      other.multilineRadius == multilineRadius;

  @override
  int get hashCode => Object.hash(borderSide, gapPadding, multilineRadius);
}
