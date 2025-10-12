import 'dart:convert';

import 'package:froggy_soft/data/repositories/constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';

import '../../../../device/utils/logger_config.dart';
import '../../../../domain/dtos/series_dto.dart';
import '../../../../domain/dtos/series_series_dto.dart';
import '../../../../domain/utils/build_headers_utils.dart';
import '../../../../domain/utils/impl/build_headers_utils_impl.dart';
import '../../../../flavors.dart';
import '../../../api_paths_enums.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 08/13/24
 */

class StocksRepository {
  late final BuildHeadersUtils headersUtils;

  StocksRepository(){
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future getStockBySeries(SeriesDto? series) async {
    var client = RetryClient(http.Client());
    var response = http.Response(jsonEncode(defaultTimeOutResponse), 408);
    try {
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(SeriesSeriesDto(series: series));
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.getStocksBySeries.path);
      logger.t(uri);
      logger.i(bodyEncoded);
      response = await client.post(
        uri,
        headers: headers,
        body: bodyEncoded
      ).timeout(
        const Duration(seconds: timeOutSecs),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return response; // Request Timeout response status code
        },
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }catch(e){
      return response;
    }finally {
      client.close();
    }
  }

  Future getStockByColumnName(Map<String, String>? request) async {
    var client = RetryClient(http.Client());
    var response = http.Response(jsonEncode(defaultTimeOutResponse), 408);
    try {
      var headers = await headersUtils.headers();
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.getStocksByCartonId.path, request);
      logger.t(uri);
      response = await client.get(
          uri,
          headers: headers,
      ).timeout(
        const Duration(seconds: timeOutSecs),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return response; // Request Timeout response status code
        },
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }catch(e){
      return response;
    }finally {
      client.close();
    }
  }
  Future getTransactionalData() async {

  }
}