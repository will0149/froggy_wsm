import '../api_path_enums.dart';
import 'utils/api_client.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 18/02/26

class PromotionsRepository {
  final ApiClient apiClient;

  PromotionsRepository({ApiClient? apiClient})
      : apiClient = apiClient ?? ApiClient();

  /// Promociones vigentes, en el orden del carrusel. Sin paginar: `body` es
  /// la lista.
  Future<Map<String, dynamic>> fetchPromotionsList() =>
      apiClient.getAuthorized(ApiPathsEnums.promotions.uri);
}
