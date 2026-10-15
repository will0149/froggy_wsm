import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth/api_error_message.dart';
import '../../generated/l10n.dart';
import 'repositories.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/14/26

part 'event_locations_uc.g.dart';

/// Ciudad de un país con eventos próximos (`events/locations/`). [city] vacía
/// agrupa los eventos del país sin ciudad.
class EventLocation {
  final String country;
  final String city;
  final int count;

  const EventLocation(
      {required this.country, required this.city, required this.count});
}

/// Ubicaciones para filtrar el feed, agrupadas por país (en el orden del
/// API: por país y luego por cantidad de eventos).
@riverpod
Future<Map<String, List<EventLocation>>> eventLocationsUC(Ref ref) async {
  final result = await ref.read(eventRepositoryProvider).fetchEventLocations();
  final body = result['body'];
  if (result['status'] != 200 || body is! List) {
    throw ApiException.from(result, S.current.locationsLoadFailed);
  }
  final byCountry = <String, List<EventLocation>>{};
  for (final item in body.whereType<Map<String, dynamic>>()) {
    if (item case {'country': String country, 'count': int count}
        when country.isNotEmpty) {
      byCountry.putIfAbsent(country, () => []).add(EventLocation(
            country: country,
            city: item['city'] as String? ?? '',
            count: count,
          ));
    }
  }
  return byCountry;
}
