import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkea/device/utils/user_location.dart';
import 'package:parkea/domain/usecases/nearby_events_uc.dart';
import 'package:parkea/domain/usecases/repositories.dart';

import '../helpers/fake_api.dart';

class FakeUserLocation implements UserLocationService {
  final UserLocation location;

  const FakeUserLocation(this.location);

  @override
  Future<UserLocation> current() async => location;

  @override
  Future<void> openSettings() async {}
}

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() {
    api = FakeHttp();
    // Ciudad de Panamá, Colón, sin coordenadas y Panamá Pacífico.
    api.reply('GET', 'events/all/', 200, page([
      eventJson(1, latitude: 8.9824, longitude: -79.5199),
      eventJson(2, latitude: 9.3547, longitude: -79.9001),
      eventJson(3),
      eventJson(4, latitude: 8.9131, longitude: -79.5996),
    ]));
  });

  NearbyEventsUCProvider listen(ProviderContainer container) {
    final provider = nearbyEventsUCProvider;
    container.listen(provider, (_, __) {});
    return provider;
  }

  test('ordena por distancia al usuario y omite los que no tienen coordenadas',
      () async {
    final container = makeContainer(api, overrides: [
      userLocationServiceProvider.overrideWithValue(const FakeUserLocation((
        position: LatLng(8.9150, -79.6000),
        status: LocationStatus.granted,
      ))),
    ]);

    final state = await container.read(listen(container).future);

    expect(state.events.map((e) => e.event.id), ['4', '1', '2']);
    expect(state.events.first.distanceKm, lessThan(1));
    expect(api.requests.single.uri.queryParameters,
        containsPair('upcoming', 'true'));
    expect(api.requests.single.uri.queryParameters,
        containsPair('page_size', '50'));
  });

  test('sin ubicación conserva el orden del API y no calcula distancias',
      () async {
    final container = makeContainer(api, overrides: [
      userLocationServiceProvider.overrideWithValue(const FakeUserLocation(
          (position: null, status: LocationStatus.denied))),
    ]);

    final state = await container.read(listen(container).future);

    expect(state.location.status, LocationStatus.denied);
    expect(state.events.map((e) => e.event.id), ['1', '2', '4']);
    expect(state.events.every((e) => e.distanceKm == null), isTrue);
  });

  test('falla con el mensaje del API si no puede cargar los eventos',
      () async {
    api.reply('GET', 'events/all/', 500, {'detail': 'Error'});
    final container = makeContainer(api, overrides: [
      userLocationServiceProvider.overrideWithValue(const FakeUserLocation(
          (position: null, status: LocationStatus.denied))),
    ]);

    await expectLater(
        container.read(listen(container).future), throwsA(anything));
  });
}
