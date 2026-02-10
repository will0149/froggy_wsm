import 'package:parkea/data/dtos/event_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecases/fetch_events_uc.dart';

part 'onboarding_provider.g.dart';

@riverpod
Future<List<EventDTO>> getEvents(Ref ref) async {
  return ref.watch(fetchEventsUCProvider.future);
}
