import 'package:flutter_test/flutter_test.dart';
import 'package:parkea/data/dtos/attendee_dto.dart';
import 'package:parkea/domain/usecases/auth/api_error_message.dart';
import 'package:parkea/domain/usecases/event_attendance_uc.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() => api = FakeHttp());

  test('pide los tickets del evento y los ordena del más reciente', () async {
    api.reply(
        'GET',
        'ticket/event/owner/',
        200,
        page([
          attendeeJson(1, 12,
              username: 'jane_smith',
              firstName: 'Jane',
              lastName: 'Smith',
              avatar: '/images/profiles/jane.jpg',
              enrolled: '2026-10-10T10:00:00Z'),
          attendeeJson(2, 12,
              username: 'bob', enrolled: '2026-10-12T10:00:00Z'),
        ]));
    final container = makeContainer(api);

    final attendees = await container.read(eventAttendeesUCProvider(12).future);

    expect(api.sent('GET', 'ticket/event/owner/').single.uri.queryParameters,
        {'event': '12', 'page': '1'});
    expect(attendees.map((a) => a.username), ['bob', 'jane_smith']);
    final [bob, jane] = attendees;
    expect(bob.displayName, 'bob');
    expect(bob.initial, 'B');
    expect(bob.avatarUrl, isNull);
    expect(jane.displayName, 'Jane Smith');
    expect(jane.avatarUrl, endsWith('/images/profiles/jane.jpg'));
    expect(Uri.parse(jane.avatarUrl!).isAbsolute, isTrue);
  });

  test('descarta tickets de otros eventos (con el evento anidado) y cancelados',
      () async {
    api.reply(
        'GET',
        'ticket/event/owner/',
        200,
        page([
          {...attendeeJson(1, 12), 'event': eventJson(12)},
          {...attendeeJson(2, 13), 'event': eventJson(13)},
          attendeeJson(3, 12, status: 'CANCELLED'),
        ]));
    final container = makeContainer(api);

    final attendees = await container.read(eventAttendeesUCProvider(12).future);

    expect(attendees.map((a) => a.ticketId), [1]);
  });

  test('403 (evento ajeno): lanza el mensaje del API', () async {
    api.reply('GET', 'ticket/event/owner/', 403,
        {'detail': 'No eres el organizador de este evento.'});
    final container = makeContainer(api);

    await expectLater(
      container.read(eventAttendeesUCProvider(12).future),
      throwsA(isA<ApiException>().having((e) => e.message, 'message',
          'No eres el organizador de este evento.')),
    );
  });

  group('matches', () {
    final jose = AttendeeDTO.fromJson(attendeeJson(1, 12,
        username: 'jlopez', firstName: 'José', lastName: 'López'));

    test('por nombre, apellido o username, sin mayúsculas ni tildes', () {
      expect(jose.matches('jose'), isTrue);
      expect(jose.matches('LOPEZ'), isTrue);
      expect(jose.matches('josé lóp'), isTrue);
      expect(jose.matches('jlop'), isTrue);
      expect(jose.matches('maria'), isFalse);
    });

    test('vacío o solo espacios coincide con todos', () {
      expect(jose.matches(''), isTrue);
      expect(jose.matches('   '), isTrue);
    });
  });
}
