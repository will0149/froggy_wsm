import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'logger_config.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/16/26

/// Por qué no hay ubicación: [denied] se puede volver a pedir; [blocked]
/// (permiso negado para siempre o GPS apagado) solo desde los ajustes.
enum LocationStatus { granted, denied, blocked }

typedef UserLocation = ({LatLng? position, LocationStatus status});

/// Ubicación del dispositivo; en los tests se reemplaza con
/// `overrideWithValue`.
class UserLocationService {
  const UserLocationService();

  /// Pide el permiso si hace falta. Si el GPS tarda o falla, usa la última
  /// ubicación conocida. No lanza excepciones.
  Future<UserLocation> current() async {
    try {
      return await _current();
    } on Exception catch (e) {
      logger.w('UserLocationService: $e');
      return (position: null, status: LocationStatus.blocked);
    }
  }

  Future<UserLocation> _current() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      return (position: null, status: LocationStatus.blocked);
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    switch (permission) {
      case LocationPermission.denied:
        return (position: null, status: LocationStatus.denied);
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        return (position: null, status: LocationStatus.blocked);
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        break;
    }

    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: Duration(seconds: 10),
        ),
      );
    } on Exception {
      position = await Geolocator.getLastKnownPosition();
    }
    return (
      position: position == null
          ? null
          : LatLng(position.latitude, position.longitude),
      status: LocationStatus.granted,
    );
  }

  /// Ajustes de la app (permiso bloqueado) o de ubicación (GPS apagado).
  Future<void> openSettings() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
    } else {
      await Geolocator.openAppSettings();
    }
  }
}
