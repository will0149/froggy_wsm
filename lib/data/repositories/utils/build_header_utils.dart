/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25
library;

abstract class BuildHeadersUtils {
  Future<Map<String, String>> headers();
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> saveTokens({required String access, required String refresh});
  /// true si hay un refresh token guardado que todavía no ha expirado.
  Future<bool> validateStorage();
  Future<void> dropTemporalMemory();
}
