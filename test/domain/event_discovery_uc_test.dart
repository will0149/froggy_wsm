import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/domain/usecases/event_locations_uc.dart';
import 'package:parkea/domain/usecases/similar_events_uc.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  group('eventos similares', () {
    test('misma categoría y país, sin el evento actual', () async {
      api.reply('GET', 'events/all/', 200,
          page([eventJson(1), eventJson(2), eventJson(3)]));
      final container = makeContainer(api);
      final provider = similarEventsUCProvider(2, 'MUSIC', 'CO');
      container.listen(provider, (_, __) {});

      final similar = await container.read(provider.future);

      expect(similar.map((e) => e.id), ['1', '3']);
      expect(api.requests.single.uri.queryParameters, {
        'page': '1',
        'page_size': '11',
        'upcoming': 'true',
        'category': 'MUSIC',
        'country': 'CO',
      });
    });

    test('máximo 10 aunque el evento actual no esté en la página', () async {
      api.reply('GET', 'events/all/', 200,
          page([for (var id = 1; id <= 11; id++) eventJson(id)]));
      final container = makeContainer(api);
      final provider = similarEventsUCProvider(99, 'MUSIC', 'CO');
      container.listen(provider, (_, __) {});

      expect(await container.read(provider.future), hasLength(10));
    });

    test('sin categoría ni país no pide nada', () async {
      final container = makeContainer(api);
      final provider = similarEventsUCProvider(2, null, null);
      container.listen(provider, (_, __) {});

      expect(await container.read(provider.future), isEmpty);
      expect(api.requests, isEmpty);
    });
  });

  test('ubicaciones agrupadas por país, sin las que no tienen país', () async {
    api.reply('GET', 'events/locations/', 200, [
      {'country': 'AR', 'city': 'Cordoba', 'count': 7},
      {'country': 'CO', 'city': 'Medellin', 'count': 9},
      {'country': 'CO', 'city': 'Bogota', 'count': 7},
      {'country': 'MX', 'city': '', 'count': 1},
      {'country': '', 'city': 'Sin pais', 'count': 2},
    ]);
    final container = makeContainer(api);
    container.listen(eventLocationsUCProvider, (_, __) {});

    final locations = await container.read(eventLocationsUCProvider.future);

    expect(locations.keys, ['AR', 'CO', 'MX']);
    expect(locations['CO']!.map((l) => (l.city, l.count)),
        [('Medellin', 9), ('Bogota', 7)]);
    expect(locations['MX']!.single.city, '');
  });
}
