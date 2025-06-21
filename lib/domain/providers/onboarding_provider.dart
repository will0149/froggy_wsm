import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dtos/event_dto.dart';
import '../usecases/fetch_events_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/17/22
 */
part 'onboarding_provider.g.dart';

@riverpod
Future<List<EventDTO>> getEvents(Ref ref) async {
  return ref.read(eventsApiProvider).getAllEvents();
}
