import '../../device/utils/loggerConfig.dart';
import 'auth/api_error_message.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Recorre todas las páginas de un listado `{count, next, results}` del API.
/// Para listados cortos (tickets, mis eventos) que no necesitan scroll
/// infinito.
Future<List<T>> fetchAllPages<T>(
  Future<Map<String, dynamic>> Function(int page) fetchPage,
  T Function(Map<String, dynamic> json) fromJson, {
  required String errorMessage,
  int maxPages = 20,
}) async {
  final items = <T>[];
  for (var page = 1; page <= maxPages; page++) {
    final result = await fetchPage(page);
    final status = result['status'];
    final body = result['body'];
    if (status == timeoutStatus) throw Exception(connectionErrorMessage);
    if (status != 200 || body is! Map<String, dynamic>) {
      throw Exception(apiErrorMessage(body) ?? errorMessage);
    }
    final results = body['results'];
    if (results is List) {
      items.addAll(results.whereType<Map<String, dynamic>>().map(fromJson));
    }
    if (body['next'] == null) return items;
  }
  logger.w('fetchAllPages: se alcanzó el máximo de $maxPages páginas');
  return items;
}
