import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guardia del design system (ver `docs/propuesta-design-system.md`): las
/// pantallas leen los colores del tema (`colors(context)`,
/// `Theme.of(context).colorScheme`) o de `ParkeaOverlay`, nunca constantes
/// sueltas. Una línea que de verdad lo necesite (máscara de imagen, fondo de
/// una foto) lleva `// ds-ok: <motivo>`.
void main() {
  /// Donde sí se definen colores, y las pantallas de auth, que se mantienen
  /// como estaban (`AuthTheme`).
  const allowed = [
    'lib/app/themes/',
    'lib/app/pages/auth/',
    'lib/app/widgets/forms/auth/',
    'lib/app/widgets/scaffolds/auth_scaffold.dart',
    'lib/app/widgets/paints/',
    // Solo lo usa el splash.
    'lib/app/widgets/color_loader.dart',
  ];

  final rules = {
    'Colors.x (solo se permite Colors.transparent)':
        RegExp(r'\bColors\.(?!transparent\b)\w+'),
    // Sin punto delante: `S.of(context).parkeaAppName` es un texto.
    'constantes parkeaX (usar los tokens)':
        RegExp(r'(?<![.\w])parkea[A-Z]\w*'),
    'Color(...) literal': RegExp(r'\bColor(\.fromRGBO|\.fromARGB)?\('),
    'primaryColor/cardColor de Material 2 (usar colorScheme)':
        RegExp(r'\.(primaryColor|cardColor)\b'),
  };

  test('lib/app no usa colores fuera del tema', () {
    final violations = <String>[];
    final files = Directory('lib/app')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    for (final file in files) {
      final path = file.path.replaceAll(r'\', '/');
      if (allowed.any(path.startsWith)) continue;
      final lines = file.readAsLinesSync();
      for (final (index, line) in lines.indexed) {
        final code = line.split('//').first;
        if (line.contains('// ds-ok')) continue;
        for (final MapEntry(key: rule, value: pattern) in rules.entries) {
          if (pattern.hasMatch(code)) {
            violations.add('$path:${index + 1}: $rule\n    ${line.trim()}');
          }
        }
      }
    }
    expect(violations, isEmpty, reason: '\n${violations.join('\n')}\n');
  });

  test('la guardia detecta los casos prohibidos', () {
    // Si una regla deja de detectar, el test de arriba pasaría sin revisar.
    expect(rules.values.first.hasMatch('color: Colors.grey[600]'), isTrue);
    expect(rules.values.first.hasMatch('Colors.transparent'), isFalse);
    expect(rules.values.elementAt(1).hasMatch('color: parkeaOrange'), isTrue);
    expect(rules.values.elementAt(1).hasMatch('s.parkeaAppName'), isFalse);
    expect(rules.values.elementAt(2).hasMatch('Color(0xFF000000)'), isTrue);
    expect(rules.values.elementAt(2).hasMatch('Color.fromRGBO(0, 0, 0, 1)'),
        isTrue);
    expect(rules.values.elementAt(2).hasMatch('ParkeaColors('), isFalse);
    expect(rules.values.elementAt(3).hasMatch('theme.primaryColor'), isTrue);
  });
}
