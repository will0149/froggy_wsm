import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/pages/event/create_event_page.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/domain/models/event_category.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() {
    api = FakeHttp();
    api.reply('GET', 'events/categories/', 200, [
      categoryJson('VOLUNTEERING', 'Voluntariado'),
      categoryJson('MUSIC', 'Música', creatable: false),
      categoryJson('CAMPING', 'Camping', visible: false),
    ]);
  });

  Future<void> pump(WidgetTester tester, {EventDTO? event}) async {
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

  /// Opciones del selector de categoría, en orden.
  Future<List<EventCategory?>> categoryOptions(WidgetTester tester) async {
    final dropdown = find.byType(DropdownButton<EventCategory?>);
    await tester.scrollUntilVisible(dropdown, 200,
        scrollable: find.byType(Scrollable).first);
    return [
      for (final item
          in tester.widget<DropdownButton<EventCategory?>>(dropdown).items!)
        item.value,
    ];
  }

  testWidgets('al crear solo ofrece las creables, en el orden del admin',
      (tester) async {
    await pump(tester);

    expect(await categoryOptions(tester),
        [null, EventCategory.volunteering, EventCategory.camping]);
    expect(find.text('Música'), findsNothing);
  });

  testWidgets('al editar conserva su categoría aunque ya no sea creable',
      (tester) async {
    await pump(tester,
        event: EventDTO.fromJson({...eventJson(7, category: 'MUSIC')}));

    final options = await categoryOptions(tester);
    // Seleccionada en el campo.
    expect(find.text('Música'), findsOneWidget);
    expect(options, [
      null,
      EventCategory.volunteering,
      EventCategory.music,
      EventCategory.camping,
    ]);
  });

  testWidgets('si el API de categorías falla, ofrece todas', (tester) async {
    api.reply('GET', 'events/categories/', 500);
    await pump(tester);

    expect(await categoryOptions(tester), [null, ...EventCategory.values]);
  });
}
