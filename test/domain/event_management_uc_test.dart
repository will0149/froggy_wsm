import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/domain/models/gallery_image.dart';
import 'package:parkea/domain/usecases/create_event_uc.dart';
import 'package:parkea/domain/usecases/owner_events_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  group('crear', () {
    test('201 y sube las imágenes en orden', () async {
      api.reply('POST', 'events/create/', 201, eventJson(7));
      var nextId = 30;
      api.on('POST', 'events/7/images/',
          (_) => envelope(201, {'id': nextId++, 'url': 'u', 'position': 0}));
      final container = makeContainer(api);

      final result = await container
          .read(createEventUCProvider.notifier)
          .create({'name': 'Nuevo', 'event_date': '2026-12-01T20:00:00Z'},
              images: const [NewImage('/tmp/a.jpg'), NewImage('/tmp/b.jpg')]);

      expect(result.eventId, 7);
      expect(result.imagesFailed, isFalse);
      expect(api.sent('POST', 'events/create/').single.body,
          {'name': 'Nuevo', 'event_date': '2026-12-01T20:00:00Z'});
      expect(api.sent('POST', 'events/7/images/').map((r) => r.body), [
        {'image': '/tmp/a.jpg'},
        {'image': '/tmp/b.jpg'},
      ]);
      // Ya quedaron en el orden elegido.
      expect(api.sent('PUT', 'events/7/images/order/'), isEmpty);
    });

    test('si una imagen falla el evento queda creado', () async {
      api.reply('POST', 'events/create/', 201, eventJson(7));
      api.reply('POST', 'events/7/images/', 400,
          {'image': ['La imagen no puede superar los 2 MB.']});
      final container = makeContainer(api);

      final result = await container
          .read(createEventUCProvider.notifier)
          .create({'name': 'Nuevo'}, images: const [NewImage('/tmp/a.jpg')]);

      expect(result.eventId, 7);
      expect(result.imagesFailed, isTrue);
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

  group('galería al editar', () {
    setUp(() {
      api.reply('PATCH', 'events/update/7/', 200, eventJson(7));
      api.reply('DELETE', 'events/7/images/2/', 204);
      api.reply('POST', 'events/7/images/', 201,
          {'id': 9, 'url': 'u', 'position': 2});
      api.reply('PUT', 'events/7/images/order/', 200, []);
    });

    Future<CreateEventResult> save(List<GalleryImage>? gallery) =>
        makeContainer(api).read(createEventUCProvider.notifier).updateEvent(
            7, {'name': 'X'},
            gallery: gallery, originalImageIds: const [1, 2, 3]);

    test('sin cambios no toca las imágenes', () async {
      await save(const [
        StoredImage(id: 1, url: 'a'),
        StoredImage(id: 2, url: 'b'),
        StoredImage(id: 3, url: 'c'),
      ]);
      await save(null);
      expect(api.requests.map((r) => r.method), ['PATCH', 'PATCH']);
    });

    test('quita, agrega y reordena con la nueva de portada', () async {
      final result = await save(const [
        NewImage('/tmp/n.jpg'),
        StoredImage(id: 3, url: 'c'),
        StoredImage(id: 1, url: 'a'),
      ]);

      expect(result.imagesFailed, isFalse);
      expect(api.sent('DELETE', 'events/7/images/2/'), hasLength(1));
      expect(api.sent('PUT', 'events/7/images/order/').single.body, {
        'ids': [9, 3, 1],
      });
      // Borra antes de subir para no pasar del máximo.
      expect(api.requests.map((r) => r.method),
          ['PATCH', 'DELETE', 'POST', 'PUT']);
    });

    test('la que no se pudo borrar sigue en el reorden', () async {
      api.reply('DELETE', 'events/7/images/2/', 500);
      final result = await save(const [
        StoredImage(id: 3, url: 'c'),
        StoredImage(id: 1, url: 'a'),
      ]);

      expect(result.imagesFailed, isTrue);
      expect(api.sent('PUT', 'events/7/images/order/').single.body, {
        'ids': [3, 1, 2],
      });
    });
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
