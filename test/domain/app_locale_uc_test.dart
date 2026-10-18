import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/domain/usecases/app_locale_uc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('sin elección usa el idioma del dispositivo', () async {
    SharedPreferences.setMockInitialValues({});
    final container = makeContainer(api);

    container.read(appLocaleUCProvider);
    await settle();

    expect(container.read(appLocaleUCProvider), isNull);
  });

  test('restaura el idioma guardado e ignora uno no soportado', () async {
    SharedPreferences.setMockInitialValues({'app_locale': 'en'});
    final english = makeContainer(api);
    english.read(appLocaleUCProvider);
    await settle();
    expect(english.read(appLocaleUCProvider), const Locale('en'));

    SharedPreferences.setMockInitialValues({'app_locale': 'fr'});
    final french = makeContainer(FakeHttp());
    french.read(appLocaleUCProvider);
    await settle();
    expect(french.read(appLocaleUCProvider), isNull);
  });

  test('select lo guarda y null vuelve al del dispositivo', () async {
    SharedPreferences.setMockInitialValues({});
    final container = makeContainer(api);
    final notifier = container.read(appLocaleUCProvider.notifier);
    await settle();

    await notifier.select(const Locale('en'));
    expect(container.read(appLocaleUCProvider), const Locale('en'));
    expect((await SharedPreferences.getInstance()).getString('app_locale'),
        'en');

    await notifier.select(null);
    expect(container.read(appLocaleUCProvider), isNull);
    expect((await SharedPreferences.getInstance()).getString('app_locale'),
        isNull);
  });
}
