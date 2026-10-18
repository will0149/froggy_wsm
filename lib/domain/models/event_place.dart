import 'package:latlong2/latlong.dart';

// Made for parkea.
// By User: josedominguez
// Date: 10/17/26

/// Ubicación de un evento elegida en el mapa: el punto y lo que el
/// geocodificador sabe de él.
class EventPlace {
  final LatLng point;

  /// Calle y número, o el nombre del sitio si no hay calle.
  final String address;

  /// Tal como la da el geocodificador, para que el filtro por ciudad del
  /// feed agrupe los eventos de la misma ciudad.
  final String city;

  /// ISO 3166-1 alfa-2 en mayúsculas; vacío si no se sabe.
  final String country;

  const EventPlace(this.point,
      {this.address = '', this.city = '', this.country = ''});

  /// Dirección, ciudad y país en una línea, sin partes vacías.
  String get summary =>
      [address, city, country].where((part) => part.isNotEmpty).join(', ');

  /// Campos de `events/create/`. El API admite 6 decimales como máximo
  /// (unos 11 cm) y responde 400 si llegan más.
  Map<String, Object?> toApiFields() => {
        'address': _limit(address, 255),
        'city': _limit(city, 100),
        'country': country,
        'latitude': point.latitude.toStringAsFixed(6),
        'longitude': point.longitude.toStringAsFixed(6),
      };

  /// Para quitar la ubicación de un evento al editarlo: el API exige
  /// latitude y longitude en null juntas, y los textos vacíos.
  static const clearedApiFields = <String, Object?>{
    'address': '',
    'city': '',
    'country': '',
    'latitude': null,
    'longitude': null,
  };

  static String _limit(String text, int max) =>
      text.length <= max ? text : text.substring(0, max);
}
