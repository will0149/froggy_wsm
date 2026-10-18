import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkea/app/pages/event/location_picker_page.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/device/utils/user_location.dart';
import 'package:parkea/domain/models/event_place.dart';
import 'package:parkea/domain/usecases/repositories.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  const here = LatLng(6.2442, -75.5812);
  const parque = EventPlace(LatLng(6.2087, -75.5671),
      address: 'Parque Lleras', city: 'Medellín', country: 'CO');

  late FakeGeocoding geocoding;
  late UserLocation location;
  EventPlace? picked;

  setUp(() {
    geocoding = FakeGeocoding(
      address: (point) => EventPlace(point,
          address: 'Calle 10', city: 'Medellín', country: 'CO'),
      places: [parque],
    );
    location = (position: here, status: LocationStatus.granted);
    picked = null;
  });

  /// Un botón abre el selector y guarda en [picked] lo que devuelve.
  Future<void> pump(WidgetTester tester, {EventPlace? initial}) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        geocodingServiceProvider.overrideWithValue(geocoding),
        userLocationServiceProvider
            .overrideWithValue(FakeUserLocation(location)),
      ],
      child: MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('es'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async => picked =
                  await LocationPickerPage.open(context, initial: initial),
              child: const Text('abrir'),
            ),
          ),
        ),
      ),
    ));
    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
  }

  testWidgets('sin ubicación previa se centra en el usuario y la confirma',
      (tester) async {
    await pump(tester);

    expect(find.text('Calle 10, Medellín, CO'), findsOneWidget);

    await tester.tap(find.text('Confirmar ubicación'));
    await tester.pumpAndSettle();

    expect(picked?.point, here);
    expect(picked?.city, 'Medellín');
    expect(picked?.country, 'CO');
  });

  testWidgets('buscar un lugar y elegirlo', (tester) async {
    await pump(tester);

    await tester.enterText(find.byType(SearchBar), 'lleras');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(geocoding.searches, ['lleras']);
    await tester.tap(find.widgetWithText(ListTile, 'Parque Lleras'));
    await tester.pumpAndSettle();
    expect(find.text('Parque Lleras, Medellín, CO'), findsOneWidget);

    await tester.tap(find.text('Confirmar ubicación'));
    await tester.pumpAndSettle();

    expect(picked?.point, parque.point);
    expect(picked?.address, 'Parque Lleras');
  });

  testWidgets('búsqueda sin resultados lo dice', (tester) async {
    await pump(tester);

    await tester.enterText(find.byType(SearchBar), 'zzz');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();

    expect(find.text('No encontramos ese lugar'), findsOneWidget);
  });

  testWidgets('sin permiso, al pedir mi ubicación avisa', (tester) async {
    location = (position: null, status: LocationStatus.blocked);
    await pump(tester);

    await tester.tap(find.byTooltip('Mi ubicación'));
    await tester.pump();

    expect(find.text('No pudimos obtener tu ubicación'), findsOneWidget);
    expect(find.widgetWithText(SnackBarAction, 'Ajustes'), findsOneWidget);
  });

  testWidgets('con ubicación previa la muestra y cerrar no devuelve nada',
      (tester) async {
    await pump(tester, initial: parque);

    expect(find.text('Parque Lleras, Medellín, CO'), findsOneWidget);

    await tester.tap(find.byType(CloseButton));
    await tester.pumpAndSettle();

    expect(picked, isNull);
  });
}
