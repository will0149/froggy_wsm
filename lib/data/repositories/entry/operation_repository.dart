import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/inbound_dto.dart';
import '../../../domain/dtos/outgoing_dto.dart';
import '../../../domain/dtos/relocation_dto.dart';
import '../../../domain/dtos/tally_count_dto.dart';
import '../../api_paths_enums.dart';
import '../../entities/relocation_entity.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class OperationRepository {
  Future<Map<String, dynamic>> entryAdd(InboundDto request) async {
    var client = http.Client();
    try {
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(ApiPathsEnums.host.path, ApiPathsEnums.inbound.path);
      logger.t(uri);
      logger.i(request.toJson());
      final response = await client.post(
        uri,
        body: bodyEncoded,
        headers: {"Content-Type": "application/json"},
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
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(ApiPathsEnums.host.path, ApiPathsEnums.outgoing.path);
      logger.t(uri);
      final response = await client.post(uri, body: bodyEncoded,
        headers: {"Content-Type": "application/json"},);
      final json = jsonDecode(response.body);
      var serviceResponse = RelocationEntity.fromJson(json);
      logger.w(serviceResponse);
      return json;
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> relocate(RelocationDto request) async {
    var client = http.Client();
    try {

      var bodyEncoded = jsonEncode(request);
      var uri =
          Uri.https(ApiPathsEnums.host.path, ApiPathsEnums.relocation.path);
      logger.t(uri);
      final response = await client.post(
        uri,
        body: bodyEncoded,
        headers: {"Content-Type": "application/json"},
      );
      final json = jsonDecode(response.body);
      logger.w(json);
      return json;
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> count(TallyCountDto request) async {
    var client = http.Client();
    try{
      var bodyEncoded = jsonEncode(request);
      var uri = Uri.https(ApiPathsEnums.host.path, ApiPathsEnums.count.path);
      logger.t(uri);
      final response = await client.post(uri, body: bodyEncoded,
        headers: {"Content-Type": "application/json"},);
      final json = jsonDecode(response.body);
      var serviceResponse = RelocationEntity.fromJson(json);
      logger.w(serviceResponse.toJson());
      return json;
    }finally {
      client.close();
    }
  }
}
