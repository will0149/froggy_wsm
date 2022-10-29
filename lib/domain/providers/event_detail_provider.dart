import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dtos/event_dto.dart';
import '../usecases/get_event_by_id_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

part 'event_detail_provider.g.dart';

@riverpod
Future<EventDTO> getEventDetail(GetEventDetailRef ref, int id){
  return ref.read(eventApiProvider).getEventByID(id);
}