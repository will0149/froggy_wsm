import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/series_dto.dart';
import '../../../domain/dtos/series_series_dto.dart';
import '../../../domain/utils/build_headers_utils.dart';
import '../../../domain/utils/impl/build_headers_utils_impl.dart';
import '../../../flavors.dart';
import '../../api_paths_enums.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/13/24
 */

class StocksRepository {
  late final BuildHeadersUtils headersUtils;

  StocksRepository(){
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<Map<String, dynamic>> getStockBySeries(SeriesDto? series) async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(SeriesSeriesDto(series: series));
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.getStocksBySeries.path);
      logger.t(uri);
      logger.i(series?.toJson());
      final response = await client.post(
        uri,
        headers: headers,
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