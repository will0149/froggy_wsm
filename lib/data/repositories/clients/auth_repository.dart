import 'dart:convert';

import 'package:cct_management/data/repositories/constants.dart';
import 'package:cct_management/domain/utils/impl/build_headers_utils_impl.dart';
import 'package:cct_management/flavors.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

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
    var client = RetryClient(http.Client());
    try {
      // var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(F.baseUrl.toString(), ApiPathsEnums.signIn.path);
      // logger.t("url $uri");
      // logger.i(request.toJson());
      // final response = await client.post(
      //   uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // ).timeout(
      //   const Duration(seconds: timeOutSecs),
      //   onTimeout: () {
      //     // Time has run out, do what you wanted to do.
      //     return http.Response(jsonEncode({"status": {"code": 408}}), 408); // Request Timeout response status code
      //   },
      // );
      // final json = jsonDecode(response.body);
      // logger.w("response $json");
      // return json;
      final json = {
        "status": {
          "code": 200,
          "msg": "exitoso!"
        },
        "body": {
          "accessToken": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwMTMyODk3LCJpYXQiOjE3NTAxMjkyOTcsImp0aSI6ImJiNDI0ZDc5ZmQ2NDQ0NjNiYWY4MjgwMzY1NmFlNjMwIiwidXNlcl9pZCI6MX0.361ot8bEEl26IxK5NeOk-8D-OX8YpNRZlYJ3y5zheRWNyOLXwmC_NwE-0rh8slQlIik6XFr6HSz4Ubf6QOUFxg",
          "refresh_token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTc1MDczNDA5NywiaWF0IjoxNzUwMTI5Mjk3LCJqdGkiOiIzZWE4ZGE0OGNkNDc0NzM5OTRmN2EwNzZhMzhiNzI4ZiIsInVzZXJfaWQiOjF9.df82c7P54XCwa19R3-yMIXmwMaIQvSMTYyxvt0WzwWmQyhC9GmEuj_5pi0tt5PqrwHg42wwes-MhHLoNGRN4hQ"
        }
      };
      logger.w("response $json");
      return Future.value(json);
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> refreshToken() async {
    var client = RetryClient(http.Client());
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
    var client = RetryClient(http.Client());
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