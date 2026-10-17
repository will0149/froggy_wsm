import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/app/widgets/event/enroll_button.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/data/entities/user/user_profile_dto.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

/// Sesión iniciada como `yo`, sin tocar el almacenamiento ni el API.
class _SignedIn extends RestAuthUC {
  @override
  Future<AuthState> build() async =>
      AuthState.authenticated(UserProfileDTO(username: 'yo'));
}

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() {
    api = FakeHttp();
    api.reply('GET', 'ticket/user/all/', 200, page([]));
  });

  Future<void> pumpButton(WidgetTester tester, Map<String, Object?> event) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        ...repositoryOverrides(api),
        restAuthUCProvider.overrideWith(_SignedIn.new),
      ],
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
        home: Scaffold(
          body: Center(child: EnrollButton(event: EventDTO.fromJson(event))),
        ),
      ),
    ));
    await tester.pumpAndSettle();
  }

  bool isEnabled(WidgetTester tester) =>
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed !=
      null;

  testWidgets('evento gratis: se inscribe con un toque', (tester) async {
    api.reply('POST', 'ticket/enroll/', 201, ticketJson(5, eventJson(10)));
    await pumpButton(tester, eventJson(10));

    expect(find.text('Inscribirme · Gratis'), findsOneWidget);
    expect(isEnabled(tester), isTrue);

    // Después de inscribirse la lista de tickets ya lo incluye.
    api.reply('GET', 'ticket/user/all/', 200,
        page([ticketJson(5, eventJson(10))]));
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    expect(api.sent('POST', 'ticket/enroll/').single.body, {
      'body': {'event': 10},
    });
    expect(find.text('¡Listo! Ya estás inscrito'), findsOneWidget);
    expect(find.text('Ver mi ticket'), findsOneWidget);
  });

  testWidgets('con ticket: "Ver mi ticket"', (tester) async {
    api.reply('GET', 'ticket/user/all/', 200,
        page([ticketJson(5, eventJson(10))]));
    await pumpButton(tester, eventJson(10));

    expect(find.text('Ver mi ticket'), findsOneWidget);
    expect(isEnabled(tester), isTrue);
  });

  testWidgets('deshabilitado con el motivo', (tester) async {
    final cases = {
      'Evento finalizado':
          eventJson(10, fromNow: const Duration(days: -1)),
      'Es tu evento': eventJson(10, owner: 'yo'),
      'Solo por invitación': eventJson(10, costType: 'INVITATION'),
      'Agotado': eventJson(10, availableSpots: 0),
    };
    for (final MapEntry(key: label, value: event) in cases.entries) {
      await pumpButton(tester, event);
      expect(find.text(label), findsOneWidget, reason: label);
      expect(isEnabled(tester), isFalse, reason: label);
    }

    await pumpButton(tester, eventJson(10, costType: 'PAID'));
    expect(find.textContaining('Pago próximamente'), findsOneWidget);
    expect(isEnabled(tester), isFalse);
  });

  testWidgets('evento privado: un código inválido se muestra en el campo',
      (tester) async {
    api.on('POST', 'ticket/enroll/', (request) {
      final otp = ((request.body as Map)['body'] as Map)['otp'];
      return otp == 'DEMO2345'
          ? envelope(201, ticketJson(5, eventJson(10, costType: 'PRIVATE')))
          : envelope(400, {'otp': ['Código de acceso inválido.']});
    });
    await pumpButton(tester, eventJson(10, costType: 'PRIVATE'));

    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    // El botón de la página y el del diálogo dicen lo mismo.
    final dialogEnroll = find.descendant(
      of: find.byType(AlertDialog),
      matching: find.widgetWithText(FilledButton, 'Inscribirme'),
    );
    await tester.enterText(find.byType(TextField), 'MALO');
    await tester.tap(dialogEnroll);
    await tester.pumpAndSettle();

    // El diálogo sigue abierto con el error en el campo.
    expect(find.text('Código de acceso inválido'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'DEMO2345');
    await tester.tap(dialogEnroll);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('¡Listo! Ya estás inscrito'), findsOneWidget);
  });
}
