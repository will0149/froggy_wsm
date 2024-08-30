import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/dtos/series_series_dto.dart';
import '../../../flavors.dart';
import '../../api_paths_enums.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/13/24
 */

class StocksRepository {

  Future<Map<String, dynamic>> getStockBySeries(SeriesDto? series) async {
    var client = http.Client();
    try {
      var bodyEncoded = jsonEncode(SeriesSeriesDto(series: series));
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.getStocksBySeries.path);
      logger.t(uri);
      logger.i(series?.toJson());
      final response = await client.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: bodyEncoded
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }
}