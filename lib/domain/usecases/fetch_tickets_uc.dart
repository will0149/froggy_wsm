import 'package:parkea/data/dtos/ticket_dto.dart';
import 'package:parkea/data/repositories/ticket_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth/api_error_message.dart';
import 'paged_fetch.dart';

part 'fetch_tickets_uc.g.dart';

/// Tickets del usuario. El API no filtra próximos/pasados: se separan aquí
/// por la fecha del evento.
@riverpod
class MyTicketsUC extends _$MyTicketsUC {
  late final TicketRepository repository = TicketRepository();

  @override
  Future<List<TicketDTO>> build() async {
    final tickets = await fetchAllPages(
      repository.fetchTicketsPage,
      TicketDTO.fromJson,
      errorMessage: 'No se pudieron cargar los tickets',
    );
    // Más cercanos primero.
    return tickets
      ..sort((a, b) => (a.eventDate ?? DateTime(0))
          .compareTo(b.eventDate ?? DateTime(0)));
  }

  /// Devuelve null si se canceló o el mensaje de error.
  Future<String?> cancel(int ticketId) async {
    try {
      final result = await repository.cancelTicket(ticketId);
      final status = result['status'];
      if (status == timeoutStatus) return connectionErrorMessage;
      if (status != 204 && status != 200) {
        return apiErrorMessage(result['body']) ??
            'No se pudo cancelar el ticket';
      }
    } on Exception {
      return connectionErrorMessage;
    }
    ref.invalidateSelf();
    return null;
  }
}
