import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../data/repositories/events_repository.dart';
import 'paged_fetch.dart';

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
      errorMessage: 'No se pudieron cargar tus eventos',
    );
    // El API los ordena por creación ascendente.
    return events.reversed.toList();
  }
}
