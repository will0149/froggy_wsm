import 'package:parkea/data/repositories/events_repository.dart';
import 'package:parkea/data/dtos/event_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_events_uc.g.dart';

@riverpod
class FetchEventsUC extends _$FetchEventsUC {
  late final EventRepository repository;

  @override
  Future<List<EventDTO>> build() async {
    repository = EventRepository();
    return _fetchAllEvents();
  }

  Future<List<EventDTO>> _fetchAllEvents() async {
    Map<String, dynamic> result = await repository.fetchEventsList("sdds");
    List<dynamic> jsonResponse = result["body"];
    return jsonResponse.map((e) => EventDTO.fromJson(e)).toList();
  }

  Future<void> search(String searchText) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      Map<String, dynamic> result = await repository.fetchSearchResult(searchText);
      List<dynamic> jsonResponse = result["body"];
      return jsonResponse.map((e) => EventDTO.fromJson(e)).toList();
    });
  }
}
