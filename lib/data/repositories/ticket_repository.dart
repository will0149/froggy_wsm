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

  /// 204 si se canceló; el ticket se borra.
  Future<Map<String, dynamic>> cancelTicket(int ticketId) =>
      apiClient.deleteAuthorized(ApiPathsEnums.ticketCancel.uriWithId(ticketId));
}
