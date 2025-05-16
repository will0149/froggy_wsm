import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/utils/build_headers_utils.dart';
import '../../../domain/utils/impl/build_headers_utils_impl.dart';
import '../../../flavors.dart';
import '../../api_paths_enums.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/16/24

class WarehouseRepository {
  late final BuildHeadersUtils headersUtils;

  WarehouseRepository() {
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<Map<String, dynamic>> getCustomers() async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.warehouses.path);
      logger.t(uri);
      final response = await client.get(
        uri,
        headers: headers
      ).timeout(
        const Duration(seconds: 3),
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