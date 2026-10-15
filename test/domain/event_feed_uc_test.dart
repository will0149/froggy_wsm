import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:parkea/domain/usecases/event_feed_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  /// 2 páginas: 1 → eventos 1-2 (next 2), 2 → evento 3 (sin next).
  void twoPages() => api.on('GET', 'events/all/', (request) {
        return switch (request.uri.queryParameters['page']) {
          '1' => envelope(200, page([eventJson(1), eventJson(2)], next: 2)),
          '2' => envelope(200, page([eventJson(3)])),
          _ => envelope(404, {'detail': 'Página inválida.'}),
        };
      });

  test('pide solo eventos próximos y aplica los filtros', () async {
    twoPages();
    final container = makeContainer(api);
    final provider = eventFeedUCProvider('MUSIC', 'rock',
        country: 'CO', city: 'Medellin');
    container.listen(provider, (_, __) {});

    final feed = await container.read(provider.future);

    expect(feed.events.map((e) => e.id), ['1', '2']);
    expect(feed.hasMore, isTrue);
    expect(api.requests.single.uri.queryParameters, {
      'page': '1',
      'upcoming': 'true',
      'category': 'MUSIC',
      'search': 'rock',
      'city': 'Medellin',
      'country': 'CO',
    });
  });

  test('loadMore agrega la siguiente página y termina sin next', () async {
    twoPages();
    final container = makeContainer(api);
    final provider = eventFeedUCProvider(null, null);
    container.listen(provider, (_, __) {});
    await container.read(provider.future);

    await container.read(provider.notifier).loadMore();
    final feed = container.read(provider).requireValue;

    expect(feed.events.map((e) => e.id), ['1', '2', '3']);
    expect(feed.hasMore, isFalse);

    // Sin más páginas no vuelve a pedir.
    await container.read(provider.notifier).loadMore();
    expect(api.sent('GET', 'events/all/'), hasLength(2));
  });

  test('un 404 en una página siguiente termina la lista', () async {
    api.on('GET', 'events/all/', (request) {
      return request.uri.queryParameters['page'] == '1'
          ? envelope(200, page([eventJson(1)], next: 2))
          : envelope(404, {'detail': 'Página inválida.'});
    });
    final container = makeContainer(api);
    final provider = eventFeedUCProvider(null, null);
    container.listen(provider, (_, __) {});
    await container.read(provider.future);

    await container.read(provider.notifier).loadMore();
    final feed = container.read(provider).requireValue;

    expect(feed.events, hasLength(1));
    expect(feed.hasMore, isFalse);
    expect(feed.loadMoreError, isNull);
  });

  test('si falla la siguiente página conserva la lista y el error', () async {
    api.on('GET', 'events/all/', (request) {
      return request.uri.queryParameters['page'] == '1'
          ? envelope(200, page([eventJson(1)], next: 2))
          : http.ClientException('sin red');
    });
    final container = makeContainer(api);
    final provider = eventFeedUCProvider(null, null);
    container.listen(provider, (_, __) {});
    await container.read(provider.future);

    await container.read(provider.notifier).loadMore();
    final feed = container.read(provider).requireValue;

    expect(feed.events, hasLength(1));
    expect(feed.hasMore, isTrue);
    expect(feed.isLoadingMore, isFalse);
    expect(feed.loadMoreError, S.current.errConnection);
  });

  test('sin red la primera página falla con el mensaje traducido', () async {
    api.on('GET', 'events/all/', (_) => http.ClientException('sin red'));
    final container = makeContainer(api);
    final provider = eventFeedUCProvider(null, null);
    container.listen(provider, (_, __) {});

    await expectLater(
      container.read(provider.future),
      throwsA(predicate((e) => '$e' == S.current.errConnection)),
    );
  });

  test('un error del API muestra su mensaje', () async {
    api.reply('GET', 'events/all/', 400,
        {'country': ['Asegúrese de que este campo no tenga más de 2 caracteres.']});
    final container = makeContainer(api);
    final provider = eventFeedUCProvider(null, null, country: 'COL');
    container.listen(provider, (_, __) {});

    await expectLater(
      container.read(provider.future),
      throwsA(predicate((e) =>
          '$e' == 'Asegúrese de que este campo no tenga más de 2 caracteres.')),
    );
  });
}
