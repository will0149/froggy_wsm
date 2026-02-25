import 'package:http/http.dart' as http;

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

abstract class HttpCommonUtils {
  Future<http.Response> post(
      {required Uri uri, String? body, required Map<String, String> headers});
  Future<http.Response> get({required Uri uri, required Map<String, String> headers});
}