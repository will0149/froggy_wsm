import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:parkea/data/api_path_enums.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  final uri = ApiPathsEnums.promotions.uri;

  test('token expirado: renueva una vez y reintenta', () async {
    final api = FakeHttp();
    var calls = 0;
    api.on('GET', 'promotions/', (_) {
      calls++;
      return calls == 1
          ? envelope(401, {'code': 'token_not_valid', 'detail': 'expirado'})
          : envelope(200, []);
    });
    var refreshes = 0;
    final client = fakeApiClient(api, refreshToken: () async {
      refreshes++;
      return true;
    });

    final result = await client.getAuthorized(uri);

    expect(result['status'], 200);
    expect(refreshes, 1);
    expect(calls, 2);
  });

  test('si el refresh falla devuelve el 401 sin reintentar', () async {
    final api = FakeHttp()
      ..reply('GET', 'promotions/', 401,
          {'code': 'token_not_valid', 'detail': 'expirado'});
    final client = fakeApiClient(api, refreshToken: () async => false);

    final result = await client.getAuthorized(uri);

    expect(result['status'], 401);
    expect(api.requests, hasLength(1));
  });

  test('sin red responde como un timeout (408)', () async {
    final api = FakeHttp()
      ..on('GET', 'promotions/', (_) => http.ClientException('sin red'));
    final client = fakeApiClient(api);

    final result = await client.getAuthorized(uri);

    expect(result, {'status': 408, 'body': null});
  });
}
