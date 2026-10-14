import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/loggerConfig.dart';
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

  Future<Map<String, dynamic>> getAuthorized(Uri uri) async {
    var json = await _get(uri);
    if (isTokenNotValid(json) && await refreshToken()) {
      json = await _get(uri);
    }
    return json;
  }

  Future<Map<String, dynamic>> _get(Uri uri) async {
    final response = await httpCommonUtils.get(
      uri: uri,
      headers: await headersUtils.headers(),
    );
    return decode(response);
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
