import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:parkea/domain/models/event_category.dart';
import 'package:parkea/domain/usecases/event_categories_uc.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  test('respeta el orden del admin y los flags; omite códigos desconocidos',
      () async {
    api.reply('GET', 'events/categories/', 200, [
      categoryJson('VOLUNTEERING', 'Voluntariado'),
      categoryJson('MUSIC', 'Música', creatable: false),
      categoryJson('CAMPING', 'Camping', visible: false),
      categoryJson('NUEVA', 'Nueva'),
    ]);
    final container = makeContainer(api);

    final categories = await container.read(eventCategoriesUCProvider.future);

    expect(categories!.map((c) => c.category), [
      EventCategory.volunteering,
      EventCategory.music,
      EventCategory.camping,
    ]);
    expect(
        categories.map((c) => c.name), ['Voluntariado', 'Música', 'Camping']);
    expect(categories.map((c) => c.visible), [true, true, false]);
    expect(categories.map((c) => c.creatable), [true, false, true]);
  });

  test('error del API: null, para usar todas las categorías', () async {
    api.reply('GET', 'events/categories/', 500);
    final container = makeContainer(api);

    expect(await container.read(eventCategoriesUCProvider.future), isNull);
  });

  test('sin red: null', () async {
    api.on('GET', 'events/categories/', (_) => http.ClientException('sin red'));
    final container = makeContainer(api);

    expect(await container.read(eventCategoriesUCProvider.future), isNull);
  });
}
