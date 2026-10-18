import 'package:flutter/foundation.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25
///

enum ApiPathsEnums {
  //user authentication and enrollment
  registerUser(path: 'user/register/'),
  signIn(path: 'user/login/'),
  logout(path: 'logout/'),
  passwordReset(path: 'user/password/reset/'),
  passwordResetConfirm(path: 'user/password/reset/confirm/'),
  refreshToken(path: 'user/token/refresh/'),
  tokenVerify(path: 'user/token/verify/'),
  //profile
  profile(path: 'user/profile/'),
  profileImage(path: 'user/profile/image/'),
  profileUpdate(path: 'user/profile/update/'),
  //path de eventos
  events(path: 'events/all/'),
  eventCreate(path: 'events/create/'),
  eventOwner(path: 'events/owner/'),
  eventImages(path: 'events/{id}/images/'),
  eventDetails(path: 'event/details/'),
  eventAccess(path: 'events/access/'),
  eventLocations(path: 'events/locations/'),
  eventCategories(path: 'events/categories/'),
  eventUpdate(path: 'events/update/{id}/'),
  eventDelete(path: 'events/delete/{id}/'),
  promotions(path: 'promotions/'),
  // tickets
  ticketEnroll(path: 'ticket/enroll/'),
  ticketEventOwner(path: 'ticket/event/owner/'),
  ticketsByUser(path: 'ticket/user/all/'),
  ticketCancel(path: 'ticket/cancel/{id}/'),
  ticketCountByEvent(path: 'tickets/count/{event_id}/');

  const ApiPathsEnums({required this.path});

  final String path;

  /// Base del API. Se puede sobreescribir con
  /// `--dart-define=API_BASE_URL=http://192.168.x.x:8080/api/v1/`.
  static const _baseUrlOverride = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_baseUrlOverride.isNotEmpty) return _baseUrlOverride;
    // El emulador de Android accede al host a través de 10.0.2.2.
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8080/api/v1/';
    }
    return 'http://localhost:8080/api/v1/';
  }

  Uri get uri => Uri.parse(baseUrl).resolve(path);

  /// Para paths con `{id}`, p. ej. `ticket/cancel/{id}/`.
  Uri uriWithId(Object id) =>
      Uri.parse(baseUrl).resolve(path.replaceFirst(RegExp(r'\{\w+\}'), '$id'));

  /// El API devuelve algunas URLs como ruta relativa (`/images/...`).
  static String? absoluteUrl(String? url) =>
      url == null || url.isEmpty || !url.startsWith('/')
          ? url
          : Uri.parse(baseUrl).resolve(url).toString();
}