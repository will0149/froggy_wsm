import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkea/domain/models/event_place.dart';

void main() {
  test('coordenadas con 6 decimales como string: el API rechaza más', () {
    const place = EventPlace(LatLng(6.24420312345, -75.58121098765),
        address: 'Calle 10 # 43', city: 'Medellín', country: 'CO');

    expect(place.toApiFields(), {
      'address': 'Calle 10 # 43',
      'city': 'Medellín',
      'country': 'CO',
      'latitude': '6.244203',
      'longitude': '-75.581211',
    });
  });

  test('recorta address y city al máximo del API', () {
    final place =
        EventPlace(const LatLng(0, 0), address: 'a' * 300, city: 'c' * 120);

    final fields = place.toApiFields();
    expect((fields['address'] as String).length, 255);
    expect((fields['city'] as String).length, 100);
  });

  test('summary omite las partes vacías', () {
    expect(
        const EventPlace(LatLng(0, 0), city: 'Medellín', country: 'CO').summary,
        'Medellín, CO');
    expect(const EventPlace(LatLng(0, 0)).summary, '');
  });

  test('para quitar la ubicación: coordenadas null juntas y textos vacíos', () {
    expect(EventPlace.clearedApiFields, {
      'address': '',
      'city': '',
      'country': '',
      'latitude': null,
      'longitude': null,
    });
  });
}
