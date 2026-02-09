import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../device/utils/loggerConfig.dart';
import '../build_header_utils.dart';


/// Made for parkea.
/// By User: josedominguez
/// Date: 06/14/25

class BuildHeadersUtilsImpl implements BuildHeadersUtils {
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),);

  @override
  Future<Map<String, String>> headers() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    await getToken().then((value) {
      if(value!.isNotEmpty) {
        headers["Authorization"] = "Bearer $value";
      }
    });
    return headers;
  }

  @override
  Future<String?> getToken() async {
    final accessToken = await storage.read(key: 'access_token', aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    return accessToken;
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
      valid = token!.isNotEmpty && today.day == DateTime.parse(expireTime!).day;
      if(!valid){
        // showWarningToast("La sesión a expirado!");
        storage.deleteAll();
      }
    }
    logger.i('valid session $valid');
    return valid;
  }

  @override
  void dropTemporalMemory() {
    storage.deleteAll();
  }

}