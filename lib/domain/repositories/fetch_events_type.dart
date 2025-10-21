import '../dtos/event_dto.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22

abstract class FetchEventsType {
  Future<List<EventDTO>?> getAllEvents();
  Future<List<EventDTO>?> getSearchResult(String searchText);
}