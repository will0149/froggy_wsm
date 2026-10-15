
import '../api_path_enums.dart';
import 'utils/api_client.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22

class EventRepository {
  final ApiClient apiClient;

  EventRepository({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient();

  /// Página [page] (desde 1) del feed, más recientes primero. `body`:
  /// `{count, next, previous, results}`; fuera de rango responde 404.
  Future<Map<String, dynamic>> fetchEventsPage(int page,
          {String? category,
          String? search,
          String? city,
          String? country,
          int? pageSize}) =>
      apiClient.getAuthorized(ApiPathsEnums.events.uri.replace(
        queryParameters: {
          'page': '$page',
          // 20 por defecto; el API acepta hasta 50.
          if (pageSize != null) 'page_size': '$pageSize',
          // Sin esto el API incluye los eventos que ya pasaron.
          'upcoming': 'true',
          if (category != null) 'category': category,
          // Busca en nombre, descripciones, lugar, dirección y ciudad.
          if (search != null) 'search': search,
          // Ciudad exacta sin distinguir mayúsculas; país ISO 3166-1 alfa-2.
          if (city != null) 'city': city,
          if (country != null) 'country': country,
        },
      ));

  /// Países y ciudades con eventos próximos y cuántos tiene cada uno.
  Future<Map<String, dynamic>> fetchEventLocations() =>
      apiClient.getAuthorized(ApiPathsEnums.eventLocations.uri);

  /// Eventos creados por el usuario (100 por página).
  Future<Map<String, dynamic>> fetchOwnerEventsPage(int page) =>
      apiClient.getAuthorized(ApiPathsEnums.eventOwner.uri
          .replace(queryParameters: {'page': '$page'}));

  /// Requiere cuenta verificada (si no, 403). Solo `event_date` es
  /// obligatorio; el banner se sube aparte con [uploadBanner].
  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> event) =>
      apiClient.postAuthorized(ApiPathsEnums.eventCreate.uri, event);

  /// PATCH: solo cambia los campos enviados. 200 con el evento (incluye
  /// `otp`); los eventos ajenos responden 404.
  Future<Map<String, dynamic>> updateEvent(
          int eventId, Map<String, dynamic> fields) =>
      apiClient.patchAuthorized(
          ApiPathsEnums.eventUpdate.uriWithId(eventId), fields);

  /// 204; borra también sus tickets y el banner.
  Future<Map<String, dynamic>> deleteEvent(int eventId) =>
      apiClient.deleteAuthorized(ApiPathsEnums.eventDelete.uriWithId(eventId));

  Future<Map<String, dynamic>> uploadBanner(int eventId, String filePath) =>
      apiClient.putFileAuthorized(
          ApiPathsEnums.eventUpdateImage.uriWithId(eventId),
          'banner_img',
          filePath);

  Future<Map<String, dynamic>> eventDetails(String id) =>
      apiClient.getAuthorized(
          ApiPathsEnums.eventDetails.uri.replace(queryParameters: {'id': id}));
}
