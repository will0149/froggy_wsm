import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../data/repositories/events_repository.dart';
import 'auth/api_error_message.dart';
import 'event_feed_uc.dart';
import 'fetch_tickets_uc.dart';
import 'paged_fetch.dart';
import '../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

part 'owner_events_uc.g.dart';

/// Eventos creados por el usuario (`events/owner/`), más recientes primero.
@riverpod
class OwnerEventsUC extends _$OwnerEventsUC {
  final EventRepository repository = EventRepository();

  @override
  Future<List<EventDTO>> build() async {
    final events = await fetchAllPages(
      repository.fetchOwnerEventsPage,
      EventDTO.fromJson,
      errorMessage: S.current.errLoadOwnEvents,
    );
    // El API los ordena por creación ascendente.
    return events.reversed.toList();
  }

  /// Borra el evento con sus tickets. Devuelve null si se borró o el mensaje
  /// de error.
  Future<String?> delete(int eventId) async {
    try {
      final result = await repository.deleteEvent(eventId);
      final status = result['status'];
      if (status == timeoutStatus) return connectionErrorMessage;
      if (status != 204) {
        return apiErrorMessage(result['body']) ?? S.current.errDeleteEvent;
      }
    } on Exception {
      return connectionErrorMessage;
    }
    ref.invalidateSelf();
    ref.invalidate(eventFeedUCProvider);
    // Si el organizador estaba inscrito, su ticket se borró con el evento.
    ref.invalidate(myTicketsUCProvider);
    return null;
  }
}
