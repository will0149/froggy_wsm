import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dtos/event_dto.dart';
import '../usecases/get_event_by_id_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/30/22
 */

final getEventDetailProvider = FutureProvider.family<EventDTO, int>((ref, id) async {
  return ref.read(eventApiProvider).getEventByID(id);
});