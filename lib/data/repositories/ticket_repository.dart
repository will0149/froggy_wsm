import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/data/repositories/utils/build_header_utils.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/data/repositories/utils/impl/build_headers_utils_impl.dart';
import 'package:parkea/data/repositories/utils/impl/http_commons_utils_impl.dart';

import '../../device/utils/loggerConfig.dart';
import '../mocks/mock_data_utils.dart';

class TicketRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;
  late final MockDataUtils mockDataUtils;

  TicketRepository() {
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
    mockDataUtils = MockDataUtils();
  }

  Future<Map<String, dynamic>> fetchUpcomingTickets() async {
    var client = RetryClient(http.Client());
    try {
      final json = mockDataUtils.upcomingTickets();
      logger.w('response $json');
      return Future.value(json);
    } finally {
      client.close();
    }
  }

  Future<Map<String, dynamic>> fetchPastTickets() async {
    var client = RetryClient(http.Client());
    try {
      final json = mockDataUtils.pastTickets();
      logger.w('response $json');
      return Future.value(json);
    } finally {
      client.close();
    }
  }
}
