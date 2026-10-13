import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../device/utils/loggerConfig.dart';
import '../build_header_utils.dart';


/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

class BuildHeadersUtilsImpl implements BuildHeadersUtils {
  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),);

  @override
  Future<Map<String, String>> headers() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  @override
  Future<String?> getToken() => storage.read(key: _accessKey);

  @override
  Future<String?> getRefreshToken() => storage.read(key: _refreshKey);

  @override
  Future<void> saveTokens(
      {required String access, required String refresh}) async {
    await storage.write(key: _accessKey, value: access);
    await storage.write(key: _refreshKey, value: refresh);
  }

  @override
  Future<bool> validateStorage() async {
    final refresh = await getRefreshToken();
    final expiration = refresh == null ? null : _jwtExpiration(refresh);
    final valid = expiration != null && expiration.isAfter(DateTime.now());
    if (!valid) {
      await storage.deleteAll();
    }
    logger.i('valid session $valid');
    return valid;
  }

  @override
  Future<void> dropTemporalMemory() => storage.deleteAll();

  /// Lee el claim `exp` del JWT. No valida la firma; eso lo hace el API.
  DateTime? _jwtExpiration(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'];
      if (exp is! int) return null;
      return DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    } on FormatException {
      return null;
    }
  }
}
