import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/app/widgets/event/owner_event_actions.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/domain/usecases/owner_events_uc.dart';
import 'package:parkea/generated/l10n.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../helpers/fake_api.dart';

final _event = EventDTO.fromJson(
    {...eventJson(10, costType: 'PRIVATE'), 'otp': 'PA57AFSN'});

/// Eventos del organizador sin pasar por el API.
class _Owned extends OwnerEventsUC {
  @override
  Future<List<EventDTO>> build() async => [_event];
}

void main() {
  setUpAll(setUpDomainTests);

  testWidgets('muestra el QR del código sin errores de layout', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [ownerEventsUCProvider.overrideWith(_Owned.new)],
      child: MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('es'),
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(body: AccessCodeCard(event: _event)),
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Mostrar QR'));
    await tester.pumpAndSettle();

    expect(find.byType(QrImageView), findsOneWidget);
    expect(find.text('PA57AFSN'), findsNWidgets(2));
  });
}
