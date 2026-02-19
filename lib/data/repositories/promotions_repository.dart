import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/data/repositories/utils/build_header_utils.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/data/repositories/utils/impl/build_headers_utils_impl.dart';
import 'package:parkea/data/repositories/utils/impl/http_commons_utils_impl.dart';

import '../../device/utils/loggerConfig.dart';
import '../mocks/mock_data_utils.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 18/02/26

class PromotionsRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;
  late final MockDataUtils mockDataUtils;

  PromotionsRepository() {
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
    mockDataUtils = MockDataUtils();
  }

  Future<Map<String, dynamic>> fetchPromotionsList(Object request) async {
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     'http://127.0.0.1:8000/',
      //     ApiPathsEnums.promotions.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.promotionList();
      logger.w("response $json");
      return Future.value(json);
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> promotionDetails(String request) async {
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     'http://127.0.0.1:8000/',
      //     ApiPathsEnums.promotionDetail.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.promotionDetail();
      logger.w("response $json");
      return Future.value(json);
    } finally {
      client.close();
    }
  }
}
