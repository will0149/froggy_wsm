import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/app/widgets/event/event_attendees_card.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  Future<void> pump(WidgetTester tester) async {
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
        home: const Scaffold(
          body: SingleChildScrollView(child: EventAttendeesCard(eventId: 12)),
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  testWidgets('muestra nombre, @username e inicial sin avatar', (tester) async {
    api.reply(
        'GET',
        'ticket/event/owner/',
        200,
        page([
          attendeeJson(1, 12,
              username: 'jane', firstName: 'Jane', lastName: 'Smith'),
          attendeeJson(2, 12, username: 'bob'),
        ]));
    await pump(tester);

    expect(find.text('Lista de inscritos'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('@jane'), findsOneWidget);
    expect(find.text('J'), findsOneWidget);
    // Sin nombre, el username hace de nombre y no se repite.
    expect(find.text('bob'), findsOneWidget);
    expect(find.text('@bob'), findsNothing);
    expect(find.textContaining('Ver todos'), findsNothing);
  });

  testWidgets('con más de 5 muestra 5 y el resto en la hoja', (tester) async {
    api.reply(
        'GET',
        'ticket/event/owner/',
        200,
        page([
          for (var i = 1; i <= 7; i++)
            attendeeJson(i, 12,
                username: 'user$i', enrolled: '2026-10-0${i}T10:00:00Z'),
        ]));
    await pump(tester);

    expect(find.byType(AttendeeTile), findsNWidgets(5));
    expect(find.text('user1'), findsNothing);

    await tester.tap(find.text('Ver todos (7)'));
    await tester.pumpAndSettle();

    expect(find.text('7 inscritos'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('user1'), 100,
        scrollable: find.descendant(
            of: find.byType(BottomSheet), matching: find.byType(Scrollable)));
    expect(find.text('user1'), findsOneWidget);
  });

  testWidgets('sin inscritos no se muestra', (tester) async {
    api.reply('GET', 'ticket/event/owner/', 200, page([]));
    await pump(tester);

    expect(find.byType(Card), findsNothing);
  });

  testWidgets('error: permite reintentar', (tester) async {
    api.reply('GET', 'ticket/event/owner/', 500);
    await pump(tester);

    expect(find.text('No se pudieron cargar los inscritos'), findsOneWidget);

    api.reply('GET', 'ticket/event/owner/', 200,
        page([attendeeJson(1, 12, username: 'bob')]));
    await tester.tap(find.text('Reintentar'));
    await tester.pumpAndSettle();

    expect(find.text('bob'), findsOneWidget);
  });
}
