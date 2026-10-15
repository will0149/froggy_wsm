import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/domain/usecases/create_event_uc.dart';
import 'package:parkea/domain/usecases/owner_events_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  group('crear', () {
    test('201 y sube el banner al evento creado', () async {
      api.reply('POST', 'events/create/', 201, eventJson(7));
      api.reply('PUT', 'events/update/image/7/', 200, eventJson(7));
      final container = makeContainer(api);

      final result = await container
          .read(createEventUCProvider.notifier)
          .create({'name': 'Nuevo', 'event_date': '2026-12-01T20:00:00Z'},
              bannerPath: '/tmp/banner.jpg');

      expect(result.eventId, 7);
      expect(result.bannerFailed, isFalse);
      expect(api.sent('POST', 'events/create/').single.body,
          {'name': 'Nuevo', 'event_date': '2026-12-01T20:00:00Z'});
      expect(api.sent('PUT', 'events/update/image/7/').single.body,
          {'banner_img': '/tmp/banner.jpg'});
    });

    test('si el banner falla el evento queda creado', () async {
      api.reply('POST', 'events/create/', 201, eventJson(7));
      api.reply('PUT', 'events/update/image/7/', 400,
          {'banner_img': ['Formato no soportado.']});
      final container = makeContainer(api);

      final result = await container
          .read(createEventUCProvider.notifier)
          .create({'name': 'Nuevo'}, bannerPath: '/tmp/banner.bmp');

      expect(result.eventId, 7);
      expect(result.bannerFailed, isTrue);
    });

    test('errores por campo del API', () async {
      api.reply('POST', 'events/create/', 400, {
        'event_date': ['La fecha del evento debe ser futura.'],
      });
      final container = makeContainer(api);

      final result = await container
          .read(createEventUCProvider.notifier)
          .create({'name': 'Nuevo', 'event_date': '2020-01-01T00:00:00Z'});

      expect(result.eventId, isNull);
      expect(result.error, S.current.errCheckFields);
      expect(result.fieldErrors, {
        'event_date': ['La fecha del evento debe ser futura.'],
      });
    });
  });

  test('editar hace PATCH solo con los campos enviados', () async {
    api.reply('PATCH', 'events/update/7/', 200, eventJson(7, name: 'Editado'));
    final container = makeContainer(api);

    final result = await container
        .read(createEventUCProvider.notifier)
        .updateEvent(7, {'name': 'Editado', 'capacity': 30});

    expect(result.eventId, 7);
    expect(api.sent('PATCH', 'events/update/7/').single.body,
        {'name': 'Editado', 'capacity': 30});
  });

  group('borrar', () {
    test('204: borrado y recarga mis eventos', () async {
      api.reply('GET', 'events/owner/', 200, page([eventJson(7)]));
      api.reply('DELETE', 'events/delete/7/', 204);
      final container = makeContainer(api);
      container.listen(ownerEventsUCProvider, (_, __) {});
      await container.read(ownerEventsUCProvider.future);

      final error =
          await container.read(ownerEventsUCProvider.notifier).delete(7);
      await Future<void>.delayed(Duration.zero);

      expect(error, isNull);
      expect(api.sent('GET', 'events/owner/'), hasLength(2));
    });

    test('evento ajeno: 404 con el mensaje del API', () async {
      api.reply('GET', 'events/owner/', 200, page([]));
      api.reply('DELETE', 'events/delete/9/', 404,
          {'detail': 'No encontrado.'});
      final container = makeContainer(api);
      container.listen(ownerEventsUCProvider, (_, __) {});
      await container.read(ownerEventsUCProvider.future);

      expect(await container.read(ownerEventsUCProvider.notifier).delete(9),
          'No encontrado.');
    });
  });
}
