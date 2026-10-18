import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:parkea/domain/usecases/fetch_events_uc.dart';
import 'package:parkea/domain/usecases/private_event_access_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  group('parseAccessCode', () {
    test('lee el código del QR', () {
      expect(parseAccessCode(accessCodeQrData('Ab12Cd')), 'Ab12Cd');
    });

    test('acepta el código escrito, sin espacios y con sus mayúsculas', () {
      expect(parseAccessCode('  Ab12 Cd \n'), 'Ab12Cd');
    });

    test('null si no hay código', () {
      expect(parseAccessCode('   '), isNull);
    });
  });

  group('unlock', () {
    test('200 devuelve el evento y el detalle usa el código', () async {
      api.reply(
          'GET', 'events/access/', 200, eventJson(9, costType: 'PRIVATE'));
      api.reply(
          'GET', 'event/details/', 200, eventJson(9, costType: 'PRIVATE'));
      final container = makeContainer(api);

      final result = await container
          .read(privateEventAccessUCProvider.notifier)
          .unlock('Ab12Cd');

      expect(result, isA<AccessGranted>());
      expect(api.sent('GET', 'events/access/').single.uri.queryParameters,
          {'code': 'Ab12Cd'});
      expect(container.read(privateEventAccessUCProvider), {9: 'Ab12Cd'});

      await container.read(fetchEventDetailUCProvider(9).future);
      expect(api.sent('GET', 'event/details/').single.uri.queryParameters,
          {'id': '9', 'code': 'Ab12Cd'});
    });

    test('404 es un código inválido y no se guarda', () async {
      api.reply('GET', 'events/access/', 404, {'detail': 'Not found.'});
      final container = makeContainer(api);

      final result = await container
          .read(privateEventAccessUCProvider.notifier)
          .unlock('nope');

      expect(
          result,
          isA<AccessDenied>().having(
              (r) => r.message, 'message', S.current.invalidAccessCode));
      expect(container.read(privateEventAccessUCProvider), isEmpty);
    });

    test('429 pide esperar', () async {
      api.reply('GET', 'events/access/', 429, {'detail': 'throttled'});
      final container = makeContainer(api);

      final result = await container
          .read(privateEventAccessUCProvider.notifier)
          .unlock('Ab12Cd');

      expect(
          result,
          isA<AccessDenied>()
              .having((r) => r.message, 'message', S.current.tooManyAttempts));
    });

    test('sin red avisa del error de conexión', () async {
      api.on('GET', 'events/access/', (_) => http.ClientException('sin red'));
      final container = makeContainer(api);

      final result = await container
          .read(privateEventAccessUCProvider.notifier)
          .unlock('Ab12Cd');

      expect(
          result,
          isA<AccessDenied>()
              .having((r) => r.message, 'message', S.current.errConnection));
    });
  });
}
