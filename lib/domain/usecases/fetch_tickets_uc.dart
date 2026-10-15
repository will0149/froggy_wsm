import 'package:parkea/data/dtos/ticket_dto.dart';
import 'package:parkea/data/repositories/ticket_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth/api_error_message.dart';
import 'paged_fetch.dart';
import '../../generated/l10n.dart';
import 'repositories.dart';

part 'fetch_tickets_uc.g.dart';

/// Tickets del usuario. El API no filtra próximos/pasados: se separan aquí
/// por la fecha del evento.
@riverpod
class MyTicketsUC extends _$MyTicketsUC {
  TicketRepository get repository => ref.read(ticketRepositoryProvider);

  @override
  Future<List<TicketDTO>> build() async {
    final tickets = await fetchAllPages(
      repository.fetchTicketsPage,
      TicketDTO.fromJson,
      errorMessage: S.current.errLoadTickets,
    );
    // Más cercanos primero.
    return tickets
      ..sort((a, b) =>
          (a.eventDate ?? DateTime(0)).compareTo(b.eventDate ?? DateTime(0)));
  }

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
    ref.invalidateSelf();
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
    ref.invalidateSelf();
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
