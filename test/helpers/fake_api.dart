import 'dart:convert';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:parkea/data/repositories/events_repository.dart';
import 'package:parkea/data/repositories/promotions_repository.dart';
import 'package:parkea/data/repositories/ticket_repository.dart';
import 'package:parkea/data/repositories/utils/api_client.dart';
import 'package:parkea/data/repositories/utils/build_header_utils.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/device/utils/geocoding_service.dart';
import 'package:parkea/device/utils/user_location.dart';
import 'package:parkea/domain/models/event_place.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkea/domain/usecases/repositories.dart';
import 'package:parkea/generated/l10n.dart';

/// Petición recibida por [FakeHttp].
typedef FakeRequest = ({String method, Uri uri, Object? body});

/// Responde a una petición con el envelope del API `{status, body}` o lanza
/// una excepción (p. ej. `http.ClientException` para simular sin red).
typedef FakeHandler = Object Function(FakeRequest request);

/// Envelope del API: siempre HTTP 200 con el código real en `status`.
Map<String, Object?> envelope(int status, [Object? body]) =>
    {'status': status, 'body': body};

/// Capa HTTP falsa: responde según el método y el path relativo a
/// `/api/v1/` (p. ej. `GET events/all/`) y guarda las peticiones.
class FakeHttp implements HttpCommonUtils {
  final requests = <FakeRequest>[];
  final _routes = <String, FakeHandler>{};

  void on(String method, String path, FakeHandler handler) =>
      _routes['$method $path'] = handler;

  /// Atajo para una respuesta fija.
  void reply(String method, String path, int status, [Object? body]) =>
      on(method, path, (_) => envelope(status, body));

  /// Peticiones a [path] con [method].
  List<FakeRequest> sent(String method, String path) => [
        for (final request in requests)
          if (request.method == method && _path(request.uri) == path) request,
      ];

  static String _path(Uri uri) =>
      uri.path.replaceFirst(RegExp(r'^/api/v1/'), '');

  Future<http.Response> _send(String method, Uri uri, Object? body) async {
    final request = (method: method, uri: uri, body: body);
    requests.add(request);
    final handler = _routes['$method ${_path(uri)}'];
    if (handler == null) {
      throw StateError('FakeHttp: sin respuesta para $method ${_path(uri)}');
    }
    final response = handler(request);
    if (response is Exception) throw response;
    return http.Response(jsonEncode(response), 200,
        headers: {'content-type': 'application/json; charset=utf-8'});
  }

  static Object? _decode(String? body) =>
      body == null ? null : jsonDecode(body);

  @override
  Future<http.Response> get(
          {required Uri uri, required Map<String, String> headers}) =>
      _send('GET', uri, null);

  @override
  Future<http.Response> post(
          {required Uri uri,
          String? body,
          required Map<String, String> headers}) =>
      _send('POST', uri, _decode(body));

  @override
  Future<http.Response> patch(
          {required Uri uri,
          String? body,
          required Map<String, String> headers}) =>
      _send('PATCH', uri, _decode(body));

  @override
  Future<http.Response> delete(
          {required Uri uri, required Map<String, String> headers}) =>
      _send('DELETE', uri, null);

  @override
  Future<http.Response> putMultipart(
          {required Uri uri,
          required Map<String, String> headers,
          required String field,
          required String filePath}) =>
      _send('PUT', uri, {field: filePath});
}

class FakeHeaders implements BuildHeadersUtils {
  @override
  Future<Map<String, String>> headers() async =>
      {'Content-Type': 'application/json', 'Authorization': 'Bearer test'};

  @override
  Future<String?> getToken() async => 'test';

  @override
  Future<String?> getRefreshToken() async => 'refresh';

  @override
  Future<void> saveTokens(
      {required String access, required String refresh}) async {}

  @override
  Future<bool> validateStorage() async => true;

  @override
  Future<void> dropTemporalMemory() async {}
}

ApiClient fakeApiClient(FakeHttp http,
        {Future<bool> Function()? refreshToken}) =>
    ApiClient(
      headersUtils: FakeHeaders(),
      httpCommonUtils: http,
      refreshToken: refreshToken ?? () async => false,
    );

/// Overrides de los repositorios para que usen [http].
List<Override> repositoryOverrides(FakeHttp http) {
  final client = fakeApiClient(http);
  return [
    eventRepositoryProvider
        .overrideWithValue(EventRepository(apiClient: client)),
    ticketRepositoryProvider
        .overrideWithValue(TicketRepository(apiClient: client)),
    promotionsRepositoryProvider
        .overrideWithValue(PromotionsRepository(apiClient: client)),
  ];
}

/// Contenedor con los repositorios falsos y sin reintentos automáticos,
/// como en la app.
ProviderContainer makeContainer(FakeHttp http,
    {List<Override> overrides = const []}) {
  final container = ProviderContainer(
    overrides: [...repositoryOverrides(http), ...overrides],
    retry: (_, __) => null,
  );
  addTearDown(container.dispose);
  return container;
}

/// Los use cases leen sus mensajes con `S.current` (en español) y el
/// logger se silencia para que no tape la salida de los tests.
Future<void> setUpDomainTests() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  Logger.level = Level.off;
  await S.load(const Locale('es'));
}

/// Evento con el formato de `events/all/`.
Map<String, Object?> eventJson(
  int id, {
  String name = 'Evento',
  String costType = 'FREE',
  String? category = 'MUSIC',
  String country = 'CO',
  String city = 'Medellin',
  String owner = 'organizador',
  Duration fromNow = const Duration(days: 7),
  int? capacity = 20,
  int? availableSpots = 20,
  double? latitude,
  double? longitude,
}) =>
    {
      'id': id,
      'owner': owner,
      'banner_img': null,
      'name': name,
      'description': 'Descripción',
      'short_description': 'Corta',
      'event_date': DateTime.now().add(fromNow).toUtc().toIso8601String(),
      'cost_type': costType,
      'category': category,
      'price': costType == 'PAID' ? '15.0000' : '0.0000',
      'currency': 'USD',
      'place': 'Lugar',
      'address': 'Calle 1',
      'city': city,
      'country': country,
      // El API manda las coordenadas como strings decimales.
      'latitude': latitude?.toString(),
      'longitude': longitude?.toString(),
      'capacity': capacity,
      'available_spots': availableSpots,
    };

/// Página de un listado paginado del API.
Map<String, Object?> page(List<Object?> results, {int? next}) => {
      'count': results.length,
      'next': next == null
          ? null
          : 'http://10.0.2.2:8080/api/v1/events/all/?page=$next',
      'previous': null,
      'results': results,
    };

/// Ticket con el formato de `ticket/user/all/`.
Map<String, Object?> ticketJson(int id, Map<String, Object?> event) => {
      'id': id,
      'event': event,
      'customer': {'username': 'yo', 'first_name': '', 'last_name': ''},
      'date_purchased': '2026-10-14T02:20:09Z',
    };

/// Ticket con el formato de `ticket/event/owner/?event=<id>`.
Map<String, Object?> attendeeJson(
  int id,
  int eventId, {
  String username = 'inscrito',
  String firstName = '',
  String lastName = '',
  String? avatar,
  String status = 'ACTIVE',
  String enrolled = '2026-10-14T02:20:09Z',
}) =>
    {
      'id': id,
      'customer': {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'avatar': avatar,
      },
      'event': eventId,
      'status': status,
      'date_purchased': enrolled,
    };

/// Categoría con el formato de `events/categories/`.
Map<String, Object?> categoryJson(String code, String name,
        {bool visible = true, bool creatable = true}) =>
    {'code': code, 'name': name, 'visible': visible, 'creatable': creatable};

/// Ubicación fija del dispositivo.
class FakeUserLocation implements UserLocationService {
  final UserLocation location;

  const FakeUserLocation(this.location);

  @override
  Future<UserLocation> current() async => location;

  @override
  Future<void> openSettings() async {}
}

/// Geocodificador sin red: [reverse] devuelve [address] para cualquier
/// punto y [search] los lugares de [places] cuyo texto contiene la búsqueda.
class FakeGeocoding implements GeocodingService {
  final EventPlace Function(LatLng point) address;
  final List<EventPlace> places;
  final searches = <String>[];

  FakeGeocoding(
      {EventPlace Function(LatLng point)? address, this.places = const []})
      : address = address ?? EventPlace.new;

  @override
  Future<EventPlace> reverse(LatLng point) async => address(point);

  @override
  Future<List<EventPlace>> search(String query, {int limit = 5}) async {
    searches.add(query);
    return [
      for (final place in places)
        if (place.summary.toLowerCase().contains(query.toLowerCase())) place,
    ].take(limit).toList();
  }
}
