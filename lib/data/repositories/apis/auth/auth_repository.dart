import 'dart:convert';

import 'package:froggy_soft/data/mocks/mock_data_utils.dart';
import 'package:froggy_soft/data/utils/http_common_utils.dart';
import 'package:froggy_soft/data/utils/impl/http_commons_utils_impl.dart';
import 'package:froggy_soft/device/utils/logger_config.dart';
import 'package:froggy_soft/domain/utils/build_headers_utils.dart';
import 'package:froggy_soft/domain/utils/impl/build_headers_utils_impl.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../../../domain/dtos/auth/login_dto.dart';
import '../../../api_paths_enums.dart';
import '../../../entities/auth/register_dto.dart';
/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

class AuthRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;
  late final MockDataUtils mockDataUtils;

  AuthRepository(){
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
    mockDataUtils = MockDataUtils();
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    var client = RetryClient(http.Client());
    try {
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
      final json = mockDataUtils.userProfile();
      logger.w("response $json");
      return Future.value(json);
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> signIn(LoginDTO request) async {
    var client = RetryClient(http.Client());
    try {
      // var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //   ApiPathsEnums.v1.path + ApiPathsEnums.signIn.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.authResponse();
      logger.w("response $json");
      return Future.value(json);
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> register(RegisterDto request) async {
    var client = RetryClient(http.Client());
    try {
      // var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //   // F.baseUrl.toString(),
      //     ApiPathsEnums.v1.path + ApiPathsEnums.registerUser.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.authResponse();
      logger.w("response $json");
      return Future.value(json);
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> resetPassword(String request) async {
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(
        // F.baseUrl.toString(),
          ApiPathsEnums.v1.path + ApiPathsEnums.passwordReset.path);
      final response = await httpCommonUtils.post(
        uri: uri,
        body: bodyEncoded,
        headers: {"Content-Type": "application/json",},
      );
      final json = jsonDecode(response.body);
      // final json = mockDataUtils.authResponse();
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
          ApiPathsEnums.v1.path + ApiPathsEnums.refreshToken.path);
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
      // var headers = await headersUtils.headers();
      //
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     ApiPathsEnums.v1.path + ApiPathsEnums.logout.path);
      // final response = await httpCommonUtils.get(
      //   uri: uri,
      //   headers: headers,
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.logoutResponse();
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }
}