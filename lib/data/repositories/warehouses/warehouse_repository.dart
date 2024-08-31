import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../flavors.dart';
import '../../api_paths_enums.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/16/24

class WarehouseRepository {

  Future<Map<String, dynamic>> getCustomers() async {
    var client = http.Client();
    try {
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.warehouses.path);
      logger.t(uri);
      final response = await client.get(
        uri,
        headers: {"Content-Type": "application/json"},
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }

}