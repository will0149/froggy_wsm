import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/data/mocks/mock_data_utils.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/data/repositories/utils/impl/http_commons_utils_impl.dart';

import '../../device/utils/loggerConfig.dart';
import 'utils/build_header_utils.dart';
import 'utils/impl/build_headers_utils_impl.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/03/22

class UserRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;
  late final MockDataUtils mockDataUtils;

  UserRepository() {
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
    mockDataUtils = MockDataUtils();
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    var client = RetryClient(http.Client());
    try {
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
      final json = mockDataUtils.userProfile();
      logger.w("response $json");
      return Future.value(json);
    } finally {
      client.close();
    }
  }
}
