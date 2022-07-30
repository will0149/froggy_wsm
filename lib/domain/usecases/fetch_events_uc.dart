import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/data/repositories/events_repository.dart';
import 'package:parkea/domain/dtos/event_dto.dart';

import '../repositories/fetch_events_type.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/01/22
 */

class FetchEventsUC implements FetchEventsType {
  late final EventRepository repository;

  FetchEventsUC() {
    repository = EventRepository();
  }

  @override
  Future<List<EventDTO>> getAllEvents() async {
    Map<String, dynamic> result = await repository.fetchEventsList();
    // print(result["body"]["events"]);
    List<dynamic> jsonResponse = result["body"]["events"];
    List<EventDTO> bodyResponse = [];
    jsonResponse.map((element) {
      bodyResponse.add(EventDTO.fromJson(element));
    }).toList();
    return bodyResponse;
  }
}

final eventsApiProvider = Provider<FetchEventsUC>((ref) => FetchEventsUC(),);