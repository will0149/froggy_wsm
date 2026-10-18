import '../api_path_enums.dart';
import 'utils/api_client.dart';

class TicketRepository {
  final ApiClient apiClient;

  TicketRepository({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient();

  /// Página [page] de los tickets del usuario (100 por página, por fecha de
  /// inscripción). No filtra próximos/pasados.
  Future<Map<String, dynamic>> fetchTicketsPage(int page) =>
      apiClient.getAuthorized(ApiPathsEnums.ticketsByUser.uri
          .replace(queryParameters: {'page': '$page'}));

  /// 201 con el ticket creado, o 204 sin body si el usuario ya estaba
  /// inscrito. [otp] solo se valida en eventos PRIVATE.
  Future<Map<String, dynamic>> enroll(int eventId, {String? otp}) =>
      apiClient.postAuthorized(ApiPathsEnums.ticketEnroll.uri, {
        'body': {'event': eventId, if (otp != null) 'otp': otp},
      });

  /// Página [page] de los tickets de [eventId], que debe ser del usuario.
  Future<Map<String, dynamic>> fetchEventAttendeesPage(int eventId, int page) =>
      apiClient.getAuthorized(ApiPathsEnums.ticketEventOwner.uri.replace(
          queryParameters: {'event': '$eventId', 'page': '$page'}));

  /// `{"event_id": id, "ticket_count": n}`: inscritos en el evento.
  Future<Map<String, dynamic>> countByEvent(int eventId) => apiClient
      .getAuthorized(ApiPathsEnums.ticketCountByEvent.uriWithId(eventId));

  /// 204 si se canceló; el ticket se borra.
  Future<Map<String, dynamic>> cancelTicket(int ticketId) => apiClient
      .deleteAuthorized(ApiPathsEnums.ticketCancel.uriWithId(ticketId));
}
