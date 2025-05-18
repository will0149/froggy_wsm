import 'dart:convert';

import 'package:cct_management/data/repositories/constants.dart';
import 'package:cct_management/domain/utils/impl/build_headers_utils_impl.dart';
import 'package:cct_management/flavors.dart';
import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/auth/login_dto.dart';
import '../../../domain/utils/build_headers_utils.dart';
import '../../api_paths_enums.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 11/13/24
 */

class AuthRepository {
  late final BuildHeadersUtils headersUtils;

  AuthRepository(){
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<Map<String, dynamic>> signIn(LoginDTO request) async {
    var client = http.Client();
    try {
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(F.baseUrl.toString(), ApiPathsEnums.signIn.path);
      logger.t(uri);
      logger.i(request);
      final response = await client.post(
        uri,
        body: bodyEncoded,
        headers: {"Content-Type": "application/json",},
      ).timeout(
        const Duration(seconds: timeOutSecs),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(jsonEncode({"status": {"code": 408}}), 408); // Request Timeout response status code
        },
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var uri = Uri.https(F.baseUrl.toString(), ApiPathsEnums.refreshToken.path);
      logger.t(uri);
      final response = await client.post(
        uri,
        headers: headers,
      ).timeout(
        const Duration(seconds: timeOutSecs),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(jsonEncode({"status": {"code": 408}}), 408); // Request Timeout response status code
        },
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> logOut() async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      logger.w('sesion headers $headers');
      var uri = Uri.https(F.baseUrl.toString(), ApiPathsEnums.logout.path);
      logger.t(uri);
      final response = await client.post(
        uri,
        headers: headers,
      ).timeout(
        const Duration(seconds: timeOutSecs),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(jsonEncode({"status": {"code": 408}}), 408); // Request Timeout response status code
        },
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }

}