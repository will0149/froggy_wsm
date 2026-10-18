import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:parkea/app/utils/event_share.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(() async {
    await setUpDomainTests();
    await initializeDateFormatting('es');
  });

  test('incluye nombre, lugar, precio y el enlace al evento', () {
    final event = EventDTO.fromJson({
      ...eventJson(7, name: 'Concierto', city: 'Medellin'),
      'place': 'Parque Lleras',
    });

    final text = eventShareText(event, S.current, 'es');

    expect(text, startsWith('Concierto\n📅 '));
    expect(text, contains('📍 Parque Lleras, Medellin'));
    expect(text, contains('🎟️ Gratis'));
    expect(text, endsWith('Míralo en Parkea: parkea://events/7'));
  });

  test('sin fecha ni lugar los omite', () {
    final event = EventDTO.fromJson({
      ...eventJson(3, city: ''),
      'event_date': null,
      'place': null,
    });

    expect(eventShareText(event, S.current, 'es').split('\n'), [
      'Evento',
      '🎟️ Gratis',
      '',
      'Míralo en Parkea: parkea://events/3',
    ]);
  });
}
