import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../data/repositories/events_repository.dart';
import '../../generated/l10n.dart';
import 'auth/api_error_message.dart';
import 'paged_fetch.dart';
import 'repositories.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/18/26

part 'saved_events_uc.g.dart';

/// Eventos guardados del usuario (`events/saved/`). Es la fuente del
/// corazón del detalle: [toggle] cambia la lista enseguida y la restaura
/// si el API falla.
@riverpod
class SavedEventsUC extends _$SavedEventsUC {
  EventRepository get repository => ref.read(eventRepositoryProvider);

  @override
  Future<List<EventDTO>> build() => fetchAllPages(
        repository.fetchSavedEventsPage,
        EventDTO.fromJson,
        errorMessage: S.current.errLoadSavedEvents,
      );

  /// Guarda [event] o lo quita si ya estaba. Devuelve null si se hizo o el
  /// mensaje de error.
  Future<String?> toggle(EventDTO event) async {
    final List<EventDTO> previous;
    try {
      previous = await future;
    } on Exception catch (error) {
      return error is ApiException ? error.message : connectionErrorMessage;
    }
    final id = int.parse(event.id!);
    final wasSaved = previous.any((saved) => saved.id == event.id);
    state = AsyncData(wasSaved
        ? previous.where((saved) => saved.id != event.id).toList()
        : [event, ...previous]);

    final Map<String, dynamic> result;
    try {
      result = wasSaved
          ? await repository.unsaveEvent(id)
          : await repository.saveEvent(id);
    } on Exception {
      state = AsyncData(previous);
      return connectionErrorMessage;
    }
    final status = result['status'];
    if (status == 200 || status == 201 || status == 204) return null;
    state = AsyncData(previous);
    if (status == timeoutStatus) return connectionErrorMessage;
    return apiErrorMessage(result['body']) ??
        (wasSaved ? S.current.errUnsaveEvent : S.current.errSaveEvent);
  }
}
