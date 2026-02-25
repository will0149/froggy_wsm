

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

abstract class BuildHeadersUtils {
  Future<Map<String, String>> headers();
  Future<String?> getToken();
  Future<String?> getExpiration();
  void saveTokenInStorage(String? token);
  Future<bool> validateStorage();
  void dropTemporalMemory();
}