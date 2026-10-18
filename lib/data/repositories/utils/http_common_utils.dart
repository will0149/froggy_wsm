import 'package:http/http.dart' as http;

/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

abstract class HttpCommonUtils {
  Future<http.Response> post(
      {required Uri uri, String? body, required Map<String, String> headers});
  Future<http.Response> get({required Uri uri, required Map<String, String> headers});
  Future<http.Response> patch(
      {required Uri uri, String? body, required Map<String, String> headers});
  Future<http.Response> put(
      {required Uri uri, String? body, required Map<String, String> headers});
  Future<http.Response> delete(
      {required Uri uri, required Map<String, String> headers});
  /// Sube el archivo en [filePath] como el campo [field] de un multipart
  /// enviado con [method] (`PUT` o `POST`).
  Future<http.Response> sendMultipart(
      {required String method,
      required Uri uri,
      required Map<String, String> headers,
      required String field,
      required String filePath});
}