import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:parkea/domain/usecases/fetch_tickets_uc.dart';
import 'package:parkea/generated/l10n.dart';

import '../helpers/fake_api.dart';

void main() {
  setUpAll(setUpDomainTests);

  late FakeHttp api;

  setUp(() {
    api = FakeHttp();
    api.reply('GET', 'ticket/user/all/', 200, page([]));
  });

  Future<MyTicketsUC> loadTickets(FakeHttp api) async {
    final container = makeContainer(api);
    container.listen(myTicketsUCProvider, (_, __) {});
    await container.read(myTicketsUCProvider.future);
    return container.read(myTicketsUCProvider.notifier);
  }

  test('recorre todas las páginas y ordena por fecha del evento', () async {
    api.on('GET', 'ticket/user/all/', (request) {
      return request.uri.queryParameters['page'] == '1'
          ? envelope(
              200,
              page([
                ticketJson(1, eventJson(10, fromNow: const Duration(days: 30))),
                ticketJson(2, eventJson(11, fromNow: const Duration(days: -3))),
              ], next: 2))
          : envelope(200, page([ticketJson(3, eventJson(12))]));
    });
    final container = makeContainer(api);
    container.listen(myTicketsUCProvider, (_, __) {});

    final tickets = await container.read(myTicketsUCProvider.future);

    expect(tickets.map((t) => t.id), [2, 3, 1]);
    expect(tickets.map((t) => t.isUpcoming), [false, true, true]);
  });

  group('enroll', () {
    test('201: envía el payload envuelto en body y recarga los tickets',
        () async {
      api.reply('POST', 'ticket/enroll/', 201, ticketJson(5, eventJson(10)));
      final useCase = await loadTickets(api);

      final result = await useCase.enroll(10, otp: 'ABCD2345');
      await Future<void>.delayed(Duration.zero);

      expect(result, isA<Enrolled>());
      expect(api.sent('POST', 'ticket/enroll/').single.body, {
        'body': {'event': 10, 'otp': 'ABCD2345'},
      });
      expect(api.sent('GET', 'ticket/user/all/'), hasLength(2));
    });

    test('204 (ya inscrito) también cuenta como inscrito', () async {
      api.reply('POST', 'ticket/enroll/', 204);
      final useCase = await loadTickets(api);

      expect(await useCase.enroll(10), isA<Enrolled>());
      expect(api.sent('POST', 'ticket/enroll/').single.body, {
        'body': {'event': 10},
      });
    });

    test('código inválido: error con el campo otp', () async {
      api.reply('POST', 'ticket/enroll/', 400,
          {'otp': ['Código de acceso inválido.']});
      final useCase = await loadTickets(api);

      final result = await useCase.enroll(10, otp: 'MALO');

      expect(result, isA<EnrollFailed>());
      final failed = result as EnrollFailed;
      expect(failed.field, 'otp');
      expect(failed.message, 'Código de acceso inválido.');
    });

    test('sin cupos: el API puede mandar el mensaje como texto', () async {
      api.reply('POST', 'ticket/enroll/', 400,
          {'event': 'El evento no tiene cupos disponibles.'});
      final useCase = await loadTickets(api);

      final result = await useCase.enroll(10) as EnrollFailed;

      expect(result.message, 'El evento no tiene cupos disponibles.');
    });

    test('sin red: mensaje de conexión', () async {
      api.on('POST', 'ticket/enroll/', (_) => http.ClientException('sin red'));
      final useCase = await loadTickets(api);

      final result = await useCase.enroll(10) as EnrollFailed;

      expect(result.message, S.current.errConnection);
      expect(result.field, isNull);
    });
  });

  group('cancel', () {
    test('204: cancelado y recarga los tickets', () async {
      api.reply('DELETE', 'ticket/cancel/5/', 204);
      final useCase = await loadTickets(api);

      expect(await useCase.cancel(5), isNull);
      await Future<void>.delayed(Duration.zero);
      expect(api.sent('GET', 'ticket/user/all/'), hasLength(2));
    });

    test('error del API: devuelve su mensaje', () async {
      api.reply('DELETE', 'ticket/cancel/5/', 400,
          {'detail': 'No se puede cancelar un ticket de un evento que ya ocurrió.'});
      final useCase = await loadTickets(api);

      expect(await useCase.cancel(5),
          'No se puede cancelar un ticket de un evento que ya ocurrió.');
    });
  });
}
