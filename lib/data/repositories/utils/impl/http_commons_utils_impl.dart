import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:intl/intl.dart';

import '../../../../device/utils/loggerConfig.dart';
import '../../../constants.dart';
import '../http_common_utils.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

class HttpCommonUtilsImpl implements HttpCommonUtils {
  /// El API traduce sus mensajes (validaciones, errores) según este header;
  /// el idioma es el que cargó la app (`Intl.defaultLocale`).
  static Map<String, String> _withLanguage(Map<String, String> headers) => {
        ...headers,
        'Accept-Language': Intl.getCurrentLocale().replaceAll('_', '-'),
      };

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
      headers: _withLanguage(headers),
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
      headers: _withLanguage(headers),
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
  Future<http.Response> patch(
      {required Uri uri,
      String? body,
      required Map<String, String> headers}) async {
    logger.t(uri);
    if (body != null) logger.i(jsonDecode(body));
    return await client.patch(uri, body: body, headers: _withLanguage(headers)).timeout(
          const Duration(seconds: timeOutSecs),
          onTimeout: () =>
              http.Response(jsonEncode(defaultTimeOutResponse), 408),
        );
  }

  @override
  Future<http.Response> delete(
      {required Uri uri, required Map<String, String> headers}) async {
    logger.t(uri);
    return await client.delete(uri, headers: _withLanguage(headers)).timeout(
          const Duration(seconds: timeOutSecs),
          onTimeout: () =>
              http.Response(jsonEncode(defaultTimeOutResponse), 408),
        );
  }

  @override
  Future<http.Response> putMultipart(
      {required Uri uri,
      required Map<String, String> headers,
      required String field,
      required String filePath}) async {
    logger.t(uri);
    final request = http.MultipartRequest('PUT', uri)
      // Content-Type lo pone MultipartRequest con su boundary.
      ..headers.addAll(_withLanguage(headers)..remove('Content-Type'))
      ..files.add(await http.MultipartFile.fromPath(field, filePath));
    // Las subidas tardan más que una petición normal.
    final streamed = await request.send().timeout(
          const Duration(seconds: timeOutSecs * 4),
        );
    return http.Response.fromStream(streamed);
  }
}
