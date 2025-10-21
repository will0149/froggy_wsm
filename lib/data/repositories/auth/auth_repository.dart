import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/device/utils/loggerConfig.dart';

import '../../../domain/utils/build_header_utils.dart';
import '../../../domain/utils/impl/build_headers_utils_impl.dart';
import '../../api_path_enums.dart';
import '../../constants.dart';
import '../../entities/login_dto.dart';
import '../utils/http_common_utils.dart';
import '../utils/impl/http_commons_utils_impl.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

class AuthRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;

  AuthRepository(){
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
  }

  Future<Map<String, dynamic>> signIn(LoginDTO request) async {
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     'http://127.0.0.1:8000/',
      //     ApiPathsEnums.signIn.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = {
                "status": {
                  "code": 200,
                  "msg": "exitoso!"
                },
                "body": {
                  "token": "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUwMTMyODk3LCJpYXQiOjE3NTAxMjkyOTcsImp0aSI6ImJiNDI0ZDc5ZmQ2NDQ0NjNiYWY4MjgwMzY1NmFlNjMwIiwidXNlcl9pZCI6MX0.361ot8bEEl26IxK5NeOk-8D-OX8YpNRZlYJ3y5zheRWNyOLXwmC_NwE-0rh8slQlIik6XFr6HSz4Ubf6QOUFxg",
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
      var uri = Uri.https(
          // F.baseUrl.toString(),
          'http://127.0.0.1:8000/',
          ApiPathsEnums.refreshToken.path);
      final response = await httpCommonUtils.post(
        uri: uri,
        body: '',
        headers: headers,
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

      var uri = Uri.https(
          // F.baseUrl.toString(),
          'http://127.0.0.1:8000/',
          ApiPathsEnums.logout.path);
      final response = await httpCommonUtils.get(
        uri: uri,
        headers: headers,
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }
}