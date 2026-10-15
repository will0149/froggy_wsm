import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/dtos/event_dto.dart';
import '../../data/repositories/events_repository.dart';
import 'auth/api_error_message.dart';
import '../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

part 'similar_events_uc.g.dart';

/// Eventos próximos de la misma [category] y el mismo [country] que el
/// evento [eventId], sin incluirlo. Vacío si el evento no tiene ninguno de
/// los dos.
@riverpod
Future<List<EventDTO>> similarEventsUC(
    Ref ref, int eventId, String? category, String? country) async {
  if (category == null && country == null) return const [];
  // Uno más por si el propio evento está en la página.
  const limit = 10;
  final result = await EventRepository().fetchEventsPage(1,
      category: category, country: country, pageSize: limit + 1);
  final body = result['body'];
  if (result['status'] != 200 || body is! Map<String, dynamic>) {
    throw Exception(
        apiErrorMessage(body) ?? S.current.errLoadSimilar);
  }
  final results = body['results'];
  return [
    if (results is List)
      for (final json in results.whereType<Map<String, dynamic>>())
        if (json['id'] != eventId) EventDTO.fromJson(json),
  ].take(limit).toList();
}
