import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/app/widgets/gamification/event_completeness_card.dart';
import 'package:parkea/app/widgets/gamification/owner_attendance_card.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/device/utils/milestone_store.dart';
import 'package:parkea/domain/gamification/event_completeness.dart';
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

  /// Las celebraciones se prueban sin animaciones (sin Lottie).
  Future<void> pump(WidgetTester tester, Widget child) async {
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
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: true),
          child: child!,
        ),
        home: Scaffold(body: SingleChildScrollView(child: child)),
      ),
    ));
    await tester.pumpAndSettle();
  }

  group('evento completo', () {
    testWidgets('muestra el porcentaje y qué falta', (tester) async {
      await pump(
        tester,
        EventCompletenessCard(
          completeness: EventCompleteness.of(
            hasBanner: false,
            shortDescription: 'Corta',
            description: 'Larga',
            place: 'Lugar',
            category: 'MUSIC',
          ),
        ),
      );

      expect(find.text('Tu evento está al 80 %'), findsOneWidget);
      expect(find.textContaining('Agrega una imagen'), findsOneWidget);
      // La tarjeta une su semántica: el título se lee una sola vez.
      final semantics = tester.getSemantics(find.byType(Card));
      expect(
          RegExp('Tu evento está al 80 %').allMatches(semantics.label),
          hasLength(1));
      expect(semantics.value, '80 %');
    });

    testWidgets('completo: sin sugerencia', (tester) async {
      await pump(
        tester,
        EventCompletenessCard(
          completeness: EventCompleteness.of(
            hasBanner: true,
            shortDescription: 'Corta',
            description: 'Larga',
            place: 'Lugar',
            category: 'MUSIC',
          ),
        ),
      );

      expect(find.text('¡Tu evento está completo!'), findsOneWidget);
      expect(find.textContaining('Agrega'), findsNothing);
    });
  });

  group('inscritos del organizador', () {
    testWidgets('con cupo: "12 de 20 inscritos"', (tester) async {
      await pump(
        tester,
        OwnerAttendanceCard(
          event: EventDTO.fromJson(
              eventJson(10, capacity: 20, availableSpots: 8)),
        ),
      );

      expect(find.text('12 de 20 inscritos'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('sin cupo: el número viene de tickets/count/', (tester) async {
      api.reply('GET', 'tickets/count/10/', 200,
          {'event_id': 10, 'ticket_count': 3});
      await pump(
        tester,
        OwnerAttendanceCard(
          event: EventDTO.fromJson(
              eventJson(10, capacity: null, availableSpots: null)),
        ),
      );

      expect(find.text('3 inscritos'), findsOneWidget);
      expect(find.text('Sin límite de cupo'), findsOneWidget);
    });

    testWidgets('lleno: celebra solo la primera vez', (tester) async {
      final full = EventDTO.fromJson(
          eventJson(10, name: 'Taller', capacity: 20, availableSpots: 0));

      await pump(tester, OwnerAttendanceCard(event: full));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(
          find.text('Los 20 cupos de «Taller» ya están ocupados.'),
          findsOneWidget);
      await tester.tap(find.text('¡Genial!'));
      await tester.pumpAndSettle();

      // Al volver a abrir el evento ya no se celebra.
      await pump(tester, const SizedBox());
      await pump(tester, OwnerAttendanceCard(event: full));
      expect(find.text('¡Evento lleno!'), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  test('el mensaje de evento lleno distingue un solo cupo', () {
    expect(S.current.eventFullMessage(1, 'Cata'),
        'El único cupo de «Cata» ya está ocupado.');
    expect(S.current.eventFullMessage(20, 'Cata'),
        'Los 20 cupos de «Cata» ya están ocupados.');
  });

  test('MilestoneStore celebra cada hito una sola vez', () async {
    expect(await MilestoneStore.claim('event_full_1'), isTrue);
    expect(await MilestoneStore.claim('event_full_1'), isFalse);
    expect(await MilestoneStore.claim('event_full_2'), isTrue);
  });
}
