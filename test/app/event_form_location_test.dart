import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/pages/event/create_event_page.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() {
    api = FakeHttp();
    api.reply('GET', 'events/categories/', 200, [
      categoryJson('MUSIC', 'Música'),
    ]);
  });

  Future<void> pump(WidgetTester tester, EventDTO event) async {
    await tester.pumpWidget(ProviderScope(
      overrides: repositoryOverrides(api),
      retry: (_, __) => null,
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
        home: CreateEventPage(event: event),
      ),
    ));
    await tester.pumpAndSettle();
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(finder, 200,
          scrollable: find.byType(Scrollable).first);

  /// Evento con ubicación completa, como lo devuelve el API.
  EventDTO located() => EventDTO.fromJson({
        ...eventJson(7, latitude: 6.2442, longitude: -75.5812),
        'address': 'Calle 10',
      });

  testWidgets('al editar muestra la ubicación guardada', (tester) async {
    await pump(tester, located());
    await scrollTo(tester, find.text('Calle 10, Medellin, CO'));

    expect(find.text('Calle 10, Medellin, CO'), findsOneWidget);
    expect(find.text('Cambiar'), findsOneWidget);
  });

  testWidgets(
      'quitarla envía coordenadas null y textos vacíos; '
      'el error del API sale bajo el campo', (tester) async {
    api.reply('PATCH', 'events/update/7/', 400, {
      'latitude': ['latitude y longitude se envían juntas, o ninguna.']
    });
    await pump(tester, located());

    await scrollTo(tester, find.byTooltip('Quitar ubicación'));
    await tester.tap(find.byTooltip('Quitar ubicación'));
    await tester.pump();
    expect(find.text('Sin ubicación: el evento no saldrá en el mapa'),
        findsOneWidget);

    await scrollTo(tester, find.text('Guardar cambios'));
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    final body = api.sent('PATCH', 'events/update/7/').single.body as Map;
    expect(
        Map.of(body['body'] as Map? ?? body)
          ..removeWhere((key, _) => ![
                'address',
                'city',
                'country',
                'latitude',
                'longitude'
              ].contains(key)),
        {
          'address': '',
          'city': '',
          'country': '',
          'latitude': null,
          'longitude': null,
        });

    await scrollTo(
        tester, find.text('latitude y longitude se envían juntas, o ninguna.'));
    expect(find.text('latitude y longitude se envían juntas, o ninguna.'),
        findsOneWidget);
  });

  testWidgets('si no se toca la ubicación no se envía', (tester) async {
    api.reply('PATCH', 'events/update/7/', 400, {
      'name': ['x']
    });
    await pump(tester, located());

    await scrollTo(tester, find.text('Guardar cambios'));
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    final sent = api.sent('PATCH', 'events/update/7/').single.body as Map;
    final body = sent['body'] as Map? ?? sent;
    expect(body.containsKey('latitude'), isFalse);
    expect(body.containsKey('address'), isFalse);
  });
}
