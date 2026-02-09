import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/data/dtos/event_dto.dart';

import '../../data/repositories/events_repository.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/30/22

class GetEventByIDUC {
  late final EventRepository repository = EventRepository();

  Future<EventDTO> getEventByID(int id) async {
    Map<String, dynamic> result = await repository.fetchEventsList("sdfgh");
    // print(result["body"]["events"]);
    List<dynamic> jsonResponse = result["body"]["events"];
    List<EventDTO> bodyResponse = [];
    jsonResponse.map((element) {
      bodyResponse.add(EventDTO.fromJson(element));
    }).toList();

    return bodyResponse.firstWhere((element) => element.id == id);
  }
}

final eventApiProvider = Provider<GetEventByIDUC>((ref) => GetEventByIDUC());