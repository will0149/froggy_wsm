import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/data/repositories/utils/build_header_utils.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/data/repositories/utils/impl/build_headers_utils_impl.dart';
import 'package:parkea/data/repositories/utils/impl/http_commons_utils_impl.dart';

import '../../device/utils/loggerConfig.dart';
import '../api_path_enums.dart';
import 'utils/api_client.dart';
import '../constants.dart';
import '../mocks/mock_data_utils.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 07/01/22

class EventRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;
  late final MockDataUtils mockDataUtils;
  late final ApiClient apiClient;

  EventRepository(){
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
    mockDataUtils = MockDataUtils();
    apiClient = ApiClient(
      headersUtils: headersUtils,
      httpCommonUtils: httpCommonUtils,
    );
  }

  /// Página [page] (desde 1) del feed, más recientes primero. `body`:
  /// `{count, next, previous, results}`; fuera de rango responde 404.
  Future<Map<String, dynamic>> fetchEventsPage(int page,
          {String? category, String? search}) =>
      apiClient.getAuthorized(ApiPathsEnums.events.uri.replace(
        queryParameters: {
          'page': '$page',
          if (category != null) 'category': category,
          // Busca en nombre, descripciones, lugar, dirección y ciudad.
          if (search != null) 'search': search,
        },
      ));

  /// Eventos creados por el usuario (100 por página).
  Future<Map<String, dynamic>> fetchOwnerEventsPage(int page) =>
      apiClient.getAuthorized(ApiPathsEnums.eventOwner.uri
          .replace(queryParameters: {'page': '$page'}));

  /// Requiere cuenta verificada (si no, 403). Solo `event_date` es
  /// obligatorio; el banner se sube aparte con [uploadBanner].
  Future<Map<String, dynamic>> createEvent(Map<String, dynamic> event) =>
      apiClient.postAuthorized(ApiPathsEnums.eventCreate.uri, event);

  Future<Map<String, dynamic>> uploadBanner(int eventId, String filePath) =>
      apiClient.putFileAuthorized(
          ApiPathsEnums.eventUpdateImage.uriWithId(eventId),
          'banner_img',
          filePath);

  Future<Map<String, dynamic>> eventDetails(String id) =>
      apiClient.getAuthorized(ApiPathsEnums.eventDetails.uri
          .replace(queryParameters: {'id': id}));

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
