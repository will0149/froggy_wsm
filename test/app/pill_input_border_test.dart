import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/pill_input_border.dart';

void main() {
  const border = PillInputBorder();
  // Cerca de la esquina: fuera de una píldora, dentro de un radio de 12.
  const nearCorner = Offset(5, 5);

  test('una línea es una píldora', () {
    final path = border.getOuterPath(const Rect.fromLTWH(0, 0, 300, 56));
    expect(path.contains(nearCorner), isFalse);
    expect(path.contains(const Offset(150, 28)), isTrue);
  });

  test('varias líneas usan el radio de 12', () {
    final path = border.getOuterPath(const Rect.fromLTWH(0, 0, 300, 120));
    expect(path.contains(nearCorner), isTrue);
  });

  test('la animación entre estados conserva el tipo de borde', () {
    const focused =
        PillInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.5));
    expect(focused.lerpFrom(border, 0.5), isA<PillInputBorder>());
    expect(border.lerpTo(focused, 0.5), isA<PillInputBorder>());
  });
}
