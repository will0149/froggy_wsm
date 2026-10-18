import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/pages/event/event_attendees_page.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/app/widgets/event/attendee_tile.dart';
import 'package:parkea/app/widgets/gamification/owner_attendance_card.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() {
    api = FakeHttp();
    SharedPreferences.setMockInitialValues({});
  });

  /// [home] en `/` y la lista de inscritos en su ruta real.
  Future<void> pump(WidgetTester tester, Widget home) async {
    final router = GoRouter(routes: [
      GoRoute(path: '/', builder: (_, __) => Scaffold(body: home)),
      GoRoute(
        name: EventAttendeesPage.routeName,
        path: EventAttendeesPage.routeLocation,
        builder: (_, state) =>
            EventAttendeesPage(eventId: int.parse(state.pathParameters['id']!)),
      ),
    ]);
    await tester.pumpWidget(ProviderScope(
      overrides: repositoryOverrides(api),
      retry: (_, __) => null,
      child: MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.light,
        locale: const Locale('es'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('al tocar el contador abre la lista de inscritos',
      (tester) async {
    api.reply('GET', 'ticket/event/owner/', 200,
        page([attendeeJson(1, 12, username: 'bob')]));
    await pump(
      tester,
      OwnerAttendanceCard(
        event: EventDTO.fromJson({
          ...eventJson(12, capacity: 20, availableSpots: 19),
        }),
      ),
    );

    // El detalle no pide la lista hasta que se abre.
    expect(api.sent('GET', 'ticket/event/owner/'), isEmpty);

    await tester.tap(find.text('1 de 20 inscritos'));
    await tester.pumpAndSettle();

    expect(find.byType(EventAttendeesPage), findsOneWidget);
    expect(find.text('Personas inscritas'), findsOneWidget);
    expect(find.bySemanticsLabel('1 inscrito'), findsOneWidget);
    expect(find.text('bob'), findsOneWidget);
    expect(api.sent('GET', 'ticket/event/owner/').single.uri.queryParameters,
        {'event': '12', 'page': '1'});
  });

  testWidgets('muestra todos con nombre, @username e inicial', (tester) async {
    api.reply(
        'GET',
        'ticket/event/owner/',
        200,
        page([
          attendeeJson(1, 12,
              username: 'jane', firstName: 'Jane', lastName: 'Smith'),
          for (var i = 2; i <= 8; i++) attendeeJson(i, 12, username: 'user$i'),
        ]));
    await pump(tester, const EventAttendeesPage(eventId: 12));

    expect(
        find.descendant(of: find.byType(CountBubble), matching: find.text('8')),
        findsOneWidget);
    expect(find.descendant(of: find.byType(Card), matching: find.text('user2')),
        findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('@jane'), findsOneWidget);
    expect(find.text('J'), findsOneWidget);
    // Sin nombre, el username hace de nombre y no se repite.
    expect(find.text('user2'), findsOneWidget);
    expect(find.text('@user2'), findsNothing);
    expect(find.byType(AttendeeTile), findsWidgets);
  });

  testWidgets('sin inscritos lo dice', (tester) async {
    api.reply('GET', 'ticket/event/owner/', 200, page([]));
    await pump(tester, const EventAttendeesPage(eventId: 12));

    expect(find.text('Nadie inscrito todavía'), findsWidgets);
    expect(find.byType(AttendeeTile), findsNothing);
  });

  testWidgets('error: muestra el mensaje y permite reintentar', (tester) async {
    api.reply('GET', 'ticket/event/owner/', 403,
        {'detail': 'No eres el organizador de este evento.'});
    await pump(tester, const EventAttendeesPage(eventId: 12));

    expect(find.text('No eres el organizador de este evento.'), findsOneWidget);

    api.reply('GET', 'ticket/event/owner/', 200,
        page([attendeeJson(1, 12, username: 'bob')]));
    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(find.text('bob'), findsOneWidget);
  });
}
