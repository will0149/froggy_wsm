import 'package:parkea/data/dtos/event_dto.dart';
import 'package:parkea/data/repositories/events_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/30/22
part 'event_detail_provider.g.dart';

@riverpod
Future<EventDTO> getEventDetail(Ref ref, int id) async {
  final repository = EventRepository();
  final result = await repository.eventDetails(id.toString());
  return EventDTO.fromJson(result["body"]);
}