import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:parkea/data/entities/auth/register_dto.dart';
import 'package:parkea/device/utils/loggerConfig.dart';

import '../utils/build_header_utils.dart';
import '../utils/impl/build_headers_utils_impl.dart';
import '../../api_path_enums.dart';
import '../../entities/login_dto.dart';
import '../utils/http_common_utils.dart';
import '../utils/impl/http_commons_utils_impl.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

/// El API siempre responde HTTP 200; el código real viene en el JSON:
/// `{ "status": <int>, "body": <payload> }`.
class AuthRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;

  /// El refresh token rota: dos refresh en paralelo con el mismo token hacen
  /// que uno falle, así que todas las instancias comparten la petición en curso.
  static Future<bool>? _refreshInFlight;

  static final _sessionExpired = StreamController<void>.broadcast();

  /// Emite cuando el API rechaza el refresh token (expirado o en blacklist):
  /// los tokens locales ya se borraron y hay que volver a iniciar sesión.
  static Stream<void> get sessionExpired => _sessionExpired.stream;

  AuthRepository() {
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    var json = await _getProfile();
    if (_isTokenNotValid(json) && await refreshToken()) {
      json = await _getProfile();
    }
    return json;
  }

  Future<Map<String, dynamic>> _getProfile() async {
    final response = await httpCommonUtils.get(
      uri: ApiPathsEnums.profile.uri,
      headers: await headersUtils.headers(),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> signIn(LoginDTO request) async {
    final response = await httpCommonUtils.post(
      uri: ApiPathsEnums.signIn.uri,
      body: jsonEncode(request),
      headers: {
        "Content-Type": "application/json",
      },
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> register(RegisterDto request) async {
    final response = await httpCommonUtils.post(
      uri: ApiPathsEnums.registerUser.uri,
      body: jsonEncode(request),
      headers: {
        "Content-Type": "application/json",
      },
    );
    return _decode(response);
  }

  /// Envía el correo con el enlace `parkea://reset-password?uid=..&token=..`.
  /// El API responde igual exista o no la cuenta.
  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final response = await httpCommonUtils.post(
      uri: ApiPathsEnums.passwordReset.uri,
      body: jsonEncode({"email": email}),
      headers: {
        "Content-Type": "application/json",
      },
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> confirmPasswordReset({
    required String uid,
    required String token,
    required String newPassword1,
    required String newPassword2,
  }) async {
    final response = await httpCommonUtils.post(
      uri: ApiPathsEnums.passwordResetConfirm.uri,
      body: jsonEncode({
        "uid": uid,
        "token": token,
        "new_password1": newPassword1,
        "new_password2": newPassword2,
      }),
      headers: {
        "Content-Type": "application/json",
      },
    );
    return _decode(response);
  }

  /// Renueva el access token y guarda el nuevo par de tokens.
  /// Devuelve false si la sesión ya no se puede renovar.
  Future<bool> refreshToken() {
    return _refreshInFlight ??=
        _refreshToken().whenComplete(() => _refreshInFlight = null);
  }

  Future<bool> _refreshToken() async {
    final refresh = await headersUtils.getRefreshToken();
    if (refresh == null) return false;
    final response = await httpCommonUtils.post(
      uri: ApiPathsEnums.refreshToken.uri,
      body: jsonEncode({"refresh": refresh}),
      headers: {
        "Content-Type": "application/json",
      },
    );
    final json = _decode(response);
    final body = json['body'];
    if (json['status'] == 200 && body is Map<String, dynamic>) {
      await headersUtils.saveTokens(
          access: body['access'], refresh: body['refresh']);
      return true;
    }
    logger.w("refresh failed $json");
    if (json['status'] == 401) {
      await headersUtils.dropTemporalMemory();
      _sessionExpired.add(null);
    }
    return false;
  }

  /// Mete el refresh token en la blacklist. No requiere Bearer.
  Future<void> logOut() async {
    final refresh = await headersUtils.getRefreshToken();
    if (refresh == null) return;
    final response = await httpCommonUtils.post(
      uri: ApiPathsEnums.logout.uri,
      body: jsonEncode({"refresh": refresh}),
      headers: {
        "Content-Type": "application/json",
      },
    );
    _decode(response);
  }

  bool _isTokenNotValid(Map<String, dynamic> json) {
    final body = json['body'];
    return json['status'] == 401 &&
        body is Map<String, dynamic> &&
        body['code'] == 'token_not_valid';
  }

  /// Lanza [FormatException] si no llega el envelope, p. ej. la página HTML
  /// de un 500 del API.
  Map<String, dynamic> _decode(http.Response response) {
    final json = jsonDecode(response.body);
    if (json is! Map<String, dynamic>) {
      throw FormatException('Respuesta inesperada del API', response.body);
    }
    logger.w("response $json");
    return json;
  }
}
