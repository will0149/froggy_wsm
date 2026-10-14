import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/app/utils/event_format.dart';
import 'package:parkea/data/dtos/event_dto.dart';

void main() {
  test('formato del API: id int, price y currency', () {
    final event = EventDTO.fromJson({
      'id': 4,
      'owner': 'admin',
      'name': 'Summer Music Festival 2025',
      'event_date': '2025-07-15T18:00:00Z',
      'cost_type': 'PAID',
      'category': 'MUSIC',
      'price': '45.0000',
      'currency': 'EUR',
      'place': 'Central Park',
      'capacity': 20,
      'available_spots': 3,
    });

    expect(event.id, '4');
    expect(event.eventType, 'PAID');
    expect(event.category, 'MUSIC');
    expect(event.amount?.currency, 'EUR');
    expect(event.location?.place, 'Central Park');
    expect(event.availableSpots, 3);
    expect(event.formattedPrice('en'), '€45.00');
  });

  test('formato del mock: amount y location anidados', () {
    final event = EventDTO.fromJson({
      'id': '1',
      'name': 'Mock',
      'cost_type': 'FREE',
      'amount': {'price': '10.00', 'currency': 'USD'},
      'location': {'city': 'Panama', 'place': 'Amador'},
    });

    expect(event.eventType, 'FREE');
    expect(event.formattedPrice('en'), '\$10.00');
    expect(event.location?.place, 'Amador');
  });
}
