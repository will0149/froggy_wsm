import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/inbound_dto.dart';
import '../../../domain/dtos/outgoing_dto.dart';
import '../../../domain/dtos/relocation_dto.dart';
import '../../../domain/dtos/tally_count_dto.dart';
import '../../../domain/utils/build_headers_utils.dart';
import '../../../domain/utils/impl/build_headers_utils_impl.dart';
import '../../../flavors.dart';
import '../../api_paths_enums.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/11/24
// String baseUrl = FlavorConfig.instance.variables["baseUrl"];
class OperationRepository {
  late final BuildHeadersUtils headersUtils;

  OperationRepository(){
    headersUtils = BuildHeadersUtilsImpl();
  }
  Future<Map<String, dynamic>> entryAdd(InboundDto request) async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.inbound.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(
        uri,
        body: bodyEncoded,
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

  Future<Map<String, dynamic>> addOutgoing(OutgoingDto request) async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.outgoing.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(uri, body: bodyEncoded,
        headers: headers,
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

  Future<Map<String, dynamic>> relocate(RelocationDto request) async {
    var client = http.Client();
    try {
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(request);
      var uri =
          Uri.https(F.baseUrl, ApiPathsEnums.relocation.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(
        uri,
        body: bodyEncoded,
        headers: headers,
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
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> countValidate(TallyCountDto request) async {
    var client = http.Client();
    try{
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.countValidate.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(uri, body: bodyEncoded,
        headers: headers,
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

  Future<Map<String, dynamic>> count(TallyCountDto request) async {
    var client = http.Client();
    try{
      var headers = await headersUtils.headers();
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(F.baseUrl, ApiPathsEnums.count.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(uri, body: bodyEncoded,
        headers: headers,
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
