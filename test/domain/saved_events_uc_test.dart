import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/domain/usecases/saved_events_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  List<String?> savedIds(container) => [
        for (final event in container.read(savedEventsUCProvider).value!)
          event.id
      ];

  test('carga los guardados', () async {
    api.reply('GET', 'events/saved/', 200, page([eventJson(1), eventJson(2)]));
    final container = makeContainer(api);

    final saved = await container.read(savedEventsUCProvider.future);

    expect(saved.map((e) => e.id), ['1', '2']);
  });

  test('guardar lo agrega al principio con POST', () async {
    api.reply('GET', 'events/saved/', 200, page([eventJson(1)]));
    api.reply('POST', 'events/saved/5/', 201, {'event_id': 5, 'is_saved': true});
    final container = makeContainer(api);

    final error = await container
        .read(savedEventsUCProvider.notifier)
        .toggle(EventDTO.fromJson(eventJson(5)));

    expect(error, isNull);
    expect(savedIds(container), ['5', '1']);
    expect(api.sent('POST', 'events/saved/5/'), hasLength(1));
  });

  test('si ya estaba guardado lo quita con DELETE', () async {
    api.reply('GET', 'events/saved/', 200, page([eventJson(1), eventJson(5)]));
    api.reply('DELETE', 'events/saved/5/', 204);
    final container = makeContainer(api);

    final error = await container
        .read(savedEventsUCProvider.notifier)
        .toggle(EventDTO.fromJson(eventJson(5)));

    expect(error, isNull);
    expect(savedIds(container), ['1']);
  });

  test('si el API falla restaura la lista y devuelve el error', () async {
    api.reply('GET', 'events/saved/', 200, page([eventJson(1)]));
    api.reply('POST', 'events/saved/5/', 404, {'detail': 'No encontrado.'});
    final container = makeContainer(api);

    final error = await container
        .read(savedEventsUCProvider.notifier)
        .toggle(EventDTO.fromJson(eventJson(5)));

    expect(error, 'No encontrado.');
    expect(savedIds(container), ['1']);
  });

  test('sin red restaura la lista con el error de conexión', () async {
    api.reply('GET', 'events/saved/', 200, page([eventJson(1)]));
    api.on('DELETE', 'events/saved/1/',
        (_) => http.ClientException('sin red'));
    final container = makeContainer(api);

    final error = await container
        .read(savedEventsUCProvider.notifier)
        .toggle(EventDTO.fromJson(eventJson(1)));

    expect(error, S.current.errConnection);
    expect(savedIds(container), ['1']);
  });

  test('si la lista no carga no llama al API', () async {
    api.reply('GET', 'events/saved/', 500, {'detail': 'Error'});
    final container = makeContainer(api);

    final error = await container
        .read(savedEventsUCProvider.notifier)
        .toggle(EventDTO.fromJson(eventJson(5)));

    expect(error, 'Error');
    expect(api.sent('POST', 'events/saved/5/'), isEmpty);
  });
}
