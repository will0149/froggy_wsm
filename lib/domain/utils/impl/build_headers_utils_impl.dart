import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../app/widgets/toasts/build_toasts.dart';
import '../../../data/configs/database_helper.dart';
import '../../../device/utils/logger_config.dart';
import '../build_headers_utils.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 11/28/24
 */

class BuildHeadersUtilsImpl implements BuildHeadersUtils {
  DatabaseHelper _databaseHelper = DatabaseHelper();
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),);

  @override
  Future<Map<String, String>> headers() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
    };
    //TODO: restaurar el token de recuperacion por sesion
    headers["Authorization"] = "Basic dmVudGFzQGV2YWxqb3llcm9zLmNvbTozMTFmYzkwYmI3NjE0NjU4YWNkYQ=='";
    // await getToken().then((value) {
    //   if(value!.isNotEmpty) {
    //     headers["Authorization"] = "Bearer $value";
    //   }
    // });
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
    if (kDebugMode) logger.i(token);
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
        showWarningToast("La sesión a expirado!");
        dropTemporalMemory();
      }
    }
    if (kDebugMode) logger.i('valid session $valid');
    return valid;
  }

  @override
  void dropTemporalMemory() {
    Future.microtask(() async {
      try {
        _databaseHelper.clearDatabase();
        storage.deleteAll();
        if (kDebugMode) logger.w("Limipieza de memoria exitosa!");
      } catch (e) {
        if (kDebugMode) logger.e("Error borrando la memoria: $e");
      }
    });
  }

}
