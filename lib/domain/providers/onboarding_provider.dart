import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../dtos/event_dto.dart';
import '../usecases/fetch_events_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/17/22
 */


final getEventsProvider = FutureProvider<List<EventDTO>>((ref) async {
  return ref.read(eventsApiProvider).getAllEvents();
});