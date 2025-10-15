import 'dart:convert';

import 'package:froggy_soft/domain/utils/build_headers_utils.dart';
import 'package:froggy_soft/domain/utils/impl/build_headers_utils_impl.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../../../device/utils/logger_config.dart';
import '../../constants.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */

class ItemsServiceRepository {
  late final BuildHeadersUtils headersUtils;

  ItemsServiceRepository() {
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<Map<String, dynamic>> fetchItems(
      Map<String, dynamic>? queryParameters) async {
    var httpClient = RetryClient(http.Client());
    try {
      var headers = await headersUtils.headers();
      //TODO: desde el 591 hacia atras no tiene inventory availableQuantity
      var uri = Uri.https('api.alegra.com', '/api/v1/items', queryParameters);
      logger.t("url api $uri");
      final response = await httpClient.get(uri, headers: headers).timeout(
        const Duration(seconds: timeOutSecs),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response(
              jsonEncode({
                "status": {"code": 408}
              }),
              408); // Request Timeout response status code
        },
      );
      final json = jsonDecode(response.body);
      // logger.w(json);
      return {
        "body": json,
        "status": {"code": 200}
      };
    } finally {
      httpClient.close();
    }
  }
}
