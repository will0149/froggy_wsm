import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../device/utils/logger_config.dart';
import '../build_headers_utils.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 11/28/24
 */

class BuildHeadersUtilsImpl implements BuildHeadersUtils {
  final storage = FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),);

  @override
  Map<String, String> headers() {
    Map<String, String> headers;
    String? accessToken = "";
    getToken().then((value) => {accessToken = value});
    headers = {
      "Content-Type": "application/json",
      "Authorization": "$accessToken"
    };
    logger.i(headers);
    return headers;
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'access_token');
  }

  @override
  Future<String?> getExpiration() async{
    return await storage.read(key: 'expire_time');
  }

  @override
  void saveTokenInStorage(String? token) async {
    logger.i(token);
    await storage.write(key: 'access_token', value: token);
    await storage.write(key: 'expire_time', value: '${DateTime.now()}');
    //
  }

  @override
  Future<bool> validateStorage() async {
    bool valid = false;
    final expireKey = await storage.containsKey(key: 'expire_time');
    final tokenKey = await storage.containsKey(key: 'access_token');
    if(expireKey && tokenKey){
      final token = await getToken();
      final expireTime = await getExpiration();
      final today = DateTime.now();
      logger.i('today is $today');
      logger.i('expireTime is $expireTime');
      valid = token!.isNotEmpty && today.day == DateTime.parse(expireTime!).day;
      if(!valid){
        storage.deleteAll();
      }
    }
    logger.i('valid session $valid');
    return valid;
  }

}
