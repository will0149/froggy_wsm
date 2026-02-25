

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 11/28/24
 */

abstract class BuildHeadersUtils {
  Future<Map<String, String>> headers();
  Future<String?> getToken();
  Future<String?> getExpiration();
  void saveTokenInStorage(String? token);
  Future<bool> validateStorage();
  void dropTemporalMemory();
}