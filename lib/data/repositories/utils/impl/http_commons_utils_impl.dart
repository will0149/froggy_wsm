import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../../../device/utils/loggerConfig.dart';
import '../../../constants.dart';
import '../http_common_utils.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

class HttpCommonUtilsImpl implements HttpCommonUtils {
  var client = RetryClient(http.Client());

  @override
  Future<http.Response> post(
      {required Uri uri,
      String? body,
      required Map<String, String> headers}) async {
    logger.w('session headers $headers');
    logger.t(uri);
    if (body != null) logger.i(jsonDecode(body));
    return await client
        .post(
      uri,
      body: body,
      headers: headers,
    )
        .timeout(
      const Duration(seconds: timeOutSecs),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(jsonEncode(defaultTimeOutResponse),
            408); // Request Timeout response status code
      },
    );
  }

  @override
  Future<http.Response> get(
      {required Uri uri, required Map<String, String> headers}) async {
    logger.w('session headers $headers');
    logger.t(uri);
    return await client
        .get(
      uri,
      headers: headers,
    )
        .timeout(
      const Duration(seconds: timeOutSecs),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(jsonEncode(defaultTimeOutResponse),
            408); // Request Timeout response status code
      },
    );
  }
}
