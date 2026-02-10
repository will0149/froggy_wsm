import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/data/repositories/utils/build_header_utils.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/data/repositories/utils/impl/build_headers_utils_impl.dart';
import 'package:parkea/data/repositories/utils/impl/http_commons_utils_impl.dart';

import '../../device/utils/loggerConfig.dart';
import '../constants.dart';
import '../mocks/mock_data_utils.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22

class EventRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;
  late final MockDataUtils mockDataUtils;

  EventRepository(){
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
    mockDataUtils = MockDataUtils();
  }

  Future<Map<String, dynamic>> fetchEventsList(Object request) async {
    // final String response = await rootBundle.loadString(eventsPath);
    // final data = await json.decode(response);
    // return data;
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     'http://127.0.0.1:8000/',
      //     ApiPathsEnums.signIn.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.eventList();
      logger.w("response $json");
      return Future.value(json);
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> eventDetails(String request) async {
    // final String response = await rootBundle.loadString(eventsPath);
    // final data = await json.decode(response);
    // return data;
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     'http://127.0.0.1:8000/',
      //     ApiPathsEnums.signIn.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.eventDetail();
      logger.w("response $json");
      return Future.value(json);
    }finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> purchaseTicket(Object request) async {
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(request);
      final json = mockDataUtils.purchaseTicketResponse();
      logger.w("response $json");
      return Future.value(json);
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> fetchSearchResult(String searchText) async {
    var client = RetryClient(http.Client());
    try {
      var bodyEncoded = jsonEncode(searchText);
      // var uri = Uri.https(
      //     // F.baseUrl.toString(),
      //     'http://127.0.0.1:8000/',
      //     ApiPathsEnums.signIn.path);
      // final response = await httpCommonUtils.post(
      //   uri: uri,
      //   body: bodyEncoded,
      //   headers: {"Content-Type": "application/json",},
      // );
      // final json = jsonDecode(response.body);
      final json = mockDataUtils.eventDetail();
      logger.w("response $json");
      return Future.value(json);
    }finally {
      client.close();
    }
  }
}
