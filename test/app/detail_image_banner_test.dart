import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/themes/app_theme.dart';
import 'package:parkea/app/widgets/banners/detail_image_banner.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  Future<void> pumpBanner(WidgetTester tester, List<String> urls) =>
      tester.pumpWidget(MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('es'),
        localizationsDelegates: const [
          S.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Scaffold(body: DetailImageBanner(urls)),
      ));

  group('EventDTO.galleryUrls', () {
    EventDTO parse(Map<String, Object?> extra) => EventDTO.fromJson({
          'id': 1,
          'name': 'Evento',
          'event_date': '2026-11-01T20:00:00Z',
          ...extra,
        });

    test('usa images en orden y descarta las vacías', () {
      final event = parse({
        'banner_img': 'https://x/a.jpg',
        'images': [
          {'id': 1, 'url': 'https://x/a.jpg', 'position': 0},
          {'id': 2, 'url': '', 'position': 1},
          {'id': 3, 'url': 'https://x/c.jpg', 'position': 2},
        ],
      });
      expect(event.galleryUrls, ['https://x/a.jpg', 'https://x/c.jpg']);
    });

    test('sin images cae al banner', () {
      expect(parse({'banner_img': 'https://x/a.jpg'}).galleryUrls,
          ['https://x/a.jpg']);
      expect(parse({'images': []}).galleryUrls, isEmpty);
    });
  });

  testWidgets('sin imágenes no hay carrusel ni indicador', (tester) async {
    await pumpBanner(tester, const []);
    expect(find.byType(PageView), findsNothing);
    expect(find.bySemanticsLabel(RegExp('Imagen')), findsNothing);
  });

  testWidgets('una sola imagen no muestra el indicador', (tester) async {
    await pumpBanner(tester, const ['https://x/a.jpg']);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Imagen')), findsNothing);
  });

  testWidgets('el indicador sigue la página al deslizar', (tester) async {
    await pumpBanner(
        tester, const ['https://x/a.jpg', 'https://x/b.jpg', 'https://x/c.jpg']);
    expect(find.bySemanticsLabel('Imagen 1 de 3'), findsOneWidget);

    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Imagen 2 de 3'), findsOneWidget);
  });
}
