import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../constants.dart';
import '../auth/auth_repository.dart';
import 'build_header_utils.dart';
import 'http_common_utils.dart';
import 'impl/build_headers_utils_impl.dart';
import 'impl/http_commons_utils_impl.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Peticiones al API con su envelope `{ "status": <int>, "body": <payload> }`.
/// Las autenticadas renuevan el token una vez si el access expiró.
class ApiClient {
  final BuildHeadersUtils headersUtils;
  final HttpCommonUtils httpCommonUtils;

  /// Renueva los tokens; si el API rechaza el refresh se emite
  /// [AuthRepository.sessionExpired].
  final Future<bool> Function() refreshToken;

  ApiClient({
    BuildHeadersUtils? headersUtils,
    HttpCommonUtils? httpCommonUtils,
    Future<bool> Function()? refreshToken,
  })  : headersUtils = headersUtils ?? BuildHeadersUtilsImpl(),
        httpCommonUtils = httpCommonUtils ?? HttpCommonUtilsImpl(),
        refreshToken = refreshToken ?? (() => AuthRepository().refreshToken());

  Future<Map<String, dynamic>> getAuthorized(Uri uri) =>
      _authorized((headers) => httpCommonUtils.get(uri: uri, headers: headers));

  Future<Map<String, dynamic>> postAuthorized(Uri uri, Object body) =>
      _authorized((headers) => httpCommonUtils.post(
          uri: uri, body: jsonEncode(body), headers: headers));

  Future<Map<String, dynamic>> patchAuthorized(Uri uri, Object body) =>
      _authorized((headers) => httpCommonUtils.patch(
          uri: uri, body: jsonEncode(body), headers: headers));

  Future<Map<String, dynamic>> putAuthorized(Uri uri, Object body) =>
      _authorized((headers) => httpCommonUtils.put(
          uri: uri, body: jsonEncode(body), headers: headers));

  Future<Map<String, dynamic>> deleteAuthorized(Uri uri) => _authorized(
      (headers) => httpCommonUtils.delete(uri: uri, headers: headers));

  Future<Map<String, dynamic>> putFileAuthorized(
          Uri uri, String field, String filePath) =>
      _authorized((headers) => httpCommonUtils.sendMultipart(
          method: 'PUT',
          uri: uri,
          headers: headers,
          field: field,
          filePath: filePath));

  Future<Map<String, dynamic>> postFileAuthorized(
          Uri uri, String field, String filePath) =>
      _authorized((headers) => httpCommonUtils.sendMultipart(
          method: 'POST',
          uri: uri,
          headers: headers,
          field: field,
          filePath: filePath));

  /// Envía con el access token; si expiró, renueva una vez y reintenta.
  Future<Map<String, dynamic>> _authorized(
      Future<http.Response> Function(Map<String, String> headers) send) async {
    try {
      var json = decode(await send(await headersUtils.headers()));
      if (isTokenNotValid(json) && await refreshToken()) {
        json = decode(await send(await headersUtils.headers()));
      }
      return json;
    } on http.ClientException catch (e) {
      // Sin red o conexión cortada: se trata igual que un timeout.
      logger.e(e.toString());
      return Map.of(defaultTimeOutResponse);
    }
  }

  static bool isTokenNotValid(Map<String, dynamic> json) {
    final body = json['body'];
    return json['status'] == 401 &&
        body is Map<String, dynamic> &&
        body['code'] == 'token_not_valid';
  }

  /// Lanza [FormatException] si no llega el envelope, p. ej. la página HTML
  /// de un 500 del API.
  static Map<String, dynamic> decode(http.Response response) {
    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) {
      throw FormatException('Respuesta inesperada del API', response.body);
    }
    logger.w("response $json");
    return json;
  }
}
