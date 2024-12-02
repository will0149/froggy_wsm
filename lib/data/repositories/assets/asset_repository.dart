import 'dart:convert';

import 'package:cct_management/flavors.dart';
import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/asset_request_dto.dart';
import '../../../domain/utils/build_headers_utils.dart';
import '../../../domain/utils/impl/build_headers_utils_impl.dart';
import '../../api_paths_enums.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 10/08/24
 */

class AssetRepository {
  late final BuildHeadersUtils headersUtils;

  AssetRepository(){
    headersUtils = BuildHeadersUtilsImpl();
  }

  Future<Map<String, dynamic>> assignAsset(AssetRequestDto request) async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(F.baseUrl.toString(), ApiPathsEnums.addAssets.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(
        uri,
        body: bodyEncoded,
        headers: headers
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    }finally {
      client.close();
    }
  }
}