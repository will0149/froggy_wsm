import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/pages/auth/welcome_slide_page.dart';
import 'package:parkea/app/themes/auth_theme.dart';
import 'package:parkea/device/utils/is_first_run.dart';
import 'package:parkea/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  test('la bienvenida solo se marca como vista al completarla', () async {
    SharedPreferences.setMockInitialValues({});
    expect(await IsFirstRun().isFirstRun(), isTrue);
    final prefs = await SharedPreferences.getInstance();
    // Mostrarla no la marca: si se cierra la app, vuelve a salir.
    expect(prefs.getBool('is_first_run'), isNull);

    await IsFirstRun().complete();
    expect(await IsFirstRun().isFirstRun(), isFalse);
    expect(prefs.getBool('is_first_run'), isFalse);
  });

  Future<void> pumpWelcome(WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const AuthTheme(child: WelcomeSlidePage()),
      ),
    ));
    await tester.pump(const Duration(seconds: 1));
  }

  testWidgets('Siguiente avanza y el último paso ofrece cuenta', (tester) async {
    await pumpWelcome(tester);
    expect(find.bySemanticsLabel('Paso 1 de 3'), findsOneWidget);
    expect(find.text('Saltar'), findsOneWidget);

    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Paso 2 de 3'), findsOneWidget);

    await tester.tap(find.text('Siguiente'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Paso 3 de 3'), findsOneWidget);
    expect(find.text('Crear cuenta'), findsOneWidget);
    expect(find.text('Ya tengo cuenta'), findsOneWidget);
    expect(find.text('Siguiente'), findsNothing);
  });

  testWidgets('Saltar lleva al último paso', (tester) async {
    await pumpWelcome(tester);
    await tester.tap(find.text('Saltar'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Paso 3 de 3'), findsOneWidget);
    expect(find.text('Crear cuenta'), findsOneWidget);
  });
}
