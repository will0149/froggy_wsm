import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:parkea/data/repositories/utils/http_common_utils.dart';
import 'package:parkea/data/repositories/utils/impl/http_commons_utils_impl.dart';

import '../../device/utils/loggerConfig.dart';
import '../../domain/utils/build_header_utils.dart';
import '../../domain/utils/impl/build_headers_utils_impl.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/03/22

class UserRepository {
  late final BuildHeadersUtils headersUtils;
  late final HttpCommonUtils httpCommonUtils;

  UserRepository() {
    headersUtils = BuildHeadersUtilsImpl();
    httpCommonUtils = HttpCommonUtilsImpl();
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
      final json = {
        "status": {"code": 200, "msg": "exitoso!"},
        "body": {
          "username": "josedominguez",
          "email": "will0149@yahoo.com",
          "first_name": "Jose",
          "last_name": "Dominguez",
          "avatar":
              "https://numwo-media.s3.amazonaws.com/profiles/moneda-antigua-50.jpg",
          "bio": "Dedicated Entrepreneur",
          "link": "https://www.example.com.pa/",
          "user_type": 0
        }
      };
      logger.w("response $json");
      return Future.value(json);
    } finally {
      client.close();
    }
  }
}
