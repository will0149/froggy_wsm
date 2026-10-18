import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/models/event_place.dart';
import 'logger_config.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/17/26

/// Dirección ↔ coordenadas con el geocodificador del sistema (Google en
/// Android, Apple en iOS): gratis y sin clave. En los tests se reemplaza
/// con `overrideWithValue`.
class GeocodingService {
  const GeocodingService();

  static final _geocoding = Geocoding();

  /// Lo que hay en [point]; solo el punto si el geocodificador no responde.
  Future<EventPlace> reverse(LatLng point) async {
    try {
      final placemarks = await _geocoding.placemarkFromCoordinates(
          point.latitude, point.longitude);
      if (placemarks.firstOrNull case final placemark?) {
        return _place(point, placemark);
      }
    } on Exception catch (e) {
      logger.w('GeocodingService.reverse: $e');
    }
    return EventPlace(point);
  }

  /// Hasta [limit] lugares que coinciden con [query]. Vacía si no hay
  /// resultados o el geocodificador falla.
  Future<List<EventPlace>> search(String query, {int limit = 5}) async {
    final List<Location> locations;
    try {
      locations = await _geocoding.locationFromAddress(query);
    } on Exception catch (e) {
      // Sin resultados también llega como excepción (NoResultFoundException).
      logger.w('GeocodingService.search: $e');
      return const [];
    }
    return Future.wait([
      for (final location in locations.take(limit))
        reverse(LatLng(location.latitude, location.longitude)),
    ]);
  }

  static EventPlace _place(LatLng point, Placemark placemark) {
    final street = [placemark.thoroughfare, placemark.subThoroughfare]
        .where((part) => part?.isNotEmpty ?? false)
        .join(' ');
    return EventPlace(
      point,
      address: street.isNotEmpty ? street : (placemark.name ?? ''),
      city: placemark.locality?.isNotEmpty ?? false
          ? placemark.locality!
          : (placemark.subAdministrativeArea ?? ''),
      country: (placemark.isoCountryCode ?? '').toUpperCase(),
    );
  }
}
