import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/colors/app_colors.dart';

/// Contraste WCAG entre dos colores opacos.
double contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (max(la, lb) + 0.05) / (min(la, lb) + 0.05);
}

void main() {
  for (final (name, c) in [
    ('claro', ParkeaColors.light()),
    ('oscuro', ParkeaColors.dark()),
  ]) {
    group('tokens $name', () {
      // Texto: AA pide 4.5:1.
      final text = {
        'onSurface / surface': (c.onSurface, c.surface),
        'onSurface / background': (c.onSurface, c.background),
        'onSurfaceMuted / surface': (c.onSurfaceMuted, c.surface),
        'onSurfaceMuted / background': (c.onSurfaceMuted, c.background),
        'primary / surface': (c.primary, c.surface),
        'primary / background': (c.primary, c.background),
        'onPrimary / primary': (c.onPrimary, c.primary),
        'onPrimaryContainer / primaryContainer':
            (c.onPrimaryContainer, c.primaryContainer),
        'onBrand / brand': (c.onBrand, c.brand),
        'onBrandStrong / brandStrong': (c.onBrandStrong, c.brandStrong),
        'onBrandContainer / brandContainer':
            (c.onBrandContainer, c.brandContainer),
        'error / surface': (c.error, c.surface),
        'onError / error': (c.onError, c.error),
      };
      for (final MapEntry(key: pair, value: (fg, bg)) in text.entries) {
        test('$pair ≥ 4.5', () {
          expect(contrast(fg, bg), greaterThanOrEqualTo(4.5));
        });
      }
    });
  }
}
