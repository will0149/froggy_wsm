import 'package:parkea/data/dtos/ticket_dto.dart';
import 'package:parkea/data/repositories/ticket_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth/api_error_message.dart';
import 'paged_fetch.dart';
import '../../generated/l10n.dart';
import 'repositories.dart';

part 'fetch_tickets_uc.g.dart';

/// Contenido del QR del ticket, distinto del QR de acceso de un evento
/// privado (`parkea://events/join`).
String ticketQrData(String code) => 'parkea://tickets/$code';

/// Próximos o pasados, según la fecha del evento (como `?when=` del API).
enum TicketPeriod {
  upcoming,
  past;

  static TicketPeriod of(DateTime? eventDate) =>
      eventDate != null && eventDate.isAfter(DateTime.now()) ? upcoming : past;
}

/// Tickets del usuario de [period]: los próximos del más cercano al más
/// lejano y los pasados del más reciente al más antiguo.
@riverpod
class MyTicketsUC extends _$MyTicketsUC {
  @override
  Future<List<TicketDTO>> build(TicketPeriod period) async {
    final repository = ref.read(ticketRepositoryProvider);
    final tickets = await fetchAllPages(
      (page) => repository.fetchTicketsPage(page, when: period.name),
      TicketDTO.fromJson,
      errorMessage: S.current.errLoadTickets,
    );
    final epoch = DateTime(0);
    tickets.sort((a, b) =>
        (a.eventDate ?? epoch).compareTo(b.eventDate ?? epoch));
    return period == TicketPeriod.upcoming ? tickets : tickets.reversed.toList();
  }
}

/// Cuántos tickets próximos y pasados tiene el usuario (`ticket/user/count/`),
/// para el número de la pestaña Tickets.
@riverpod
Future<({int upcoming, int past})> ticketCountUC(Ref ref) async {
  final result = await ref.read(ticketRepositoryProvider).countTickets();
  final body = result['body'];
  if (result['status'] != 200 || body is! Map<String, dynamic>) {
    throw ApiException.from(result, S.current.errLoadTickets);
  }
  return (
    upcoming: (body['upcoming'] as num?)?.toInt() ?? 0,
    past: (body['past'] as num?)?.toInt() ?? 0,
  );
}

/// Inscribirse y cancelar. Al terminar recarga los tickets y su conteo.
@riverpod
class TicketActionsUC extends _$TicketActionsUC {
  TicketRepository get repository => ref.read(ticketRepositoryProvider);

  @override
  void build() {}

  void _reloadTickets() => ref
    ..invalidate(myTicketsUCProvider)
    ..invalidate(ticketCountUCProvider);

  /// Inscribe al usuario en [eventId]. Si ya estaba inscrito el API no
  /// devuelve el ticket; se encuentra al recargar la lista.
  Future<EnrollResult> enroll(int eventId, {String? otp}) async {
    final Map<String, dynamic> result;
    try {
      result = await repository.enroll(eventId, otp: otp);
    } on Exception {
      return EnrollFailed(connectionErrorMessage);
    }
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) {
      return EnrollFailed(connectionErrorMessage);
    }
    if (status != 201 && status != 204) {
      return EnrollFailed(
        apiErrorMessage(body) ?? S.current.errEnroll,
        field: apiFieldErrors(body).keys.firstOrNull,
      );
    }
    _reloadTickets();
    return const Enrolled();
  }

  /// Devuelve null si se canceló o el mensaje de error.
  Future<String?> cancel(int ticketId) async {
    try {
      final result = await repository.cancelTicket(ticketId);
      final status = result['status'];
      if (status == timeoutStatus) return connectionErrorMessage;
      if (status != 204 && status != 200) {
        return apiErrorMessage(result['body']) ?? S.current.errCancelTicket;
      }
    } on Exception {
      return connectionErrorMessage;
    }
    _reloadTickets();
    return null;
  }
}

sealed class EnrollResult {
  const EnrollResult();
}

class Enrolled extends EnrollResult {
  const Enrolled();
}

class EnrollFailed extends EnrollResult {
  final String message;

  /// Campo del error del API (`event`, `otp`…), null si es general.
  final String? field;

  const EnrollFailed(this.message, {this.field});
}
