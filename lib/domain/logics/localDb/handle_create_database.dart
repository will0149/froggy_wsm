import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/configs/database_helper.dart';
import '../../../device/utils/logger_config.dart';

class HandleCreateDatabase extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),);
  bool _isFirstLoad = true;
  bool _isReady = false;

  bool get isReady => _isReady;

  bool get isFirstLoad => _isFirstLoad;

  HandleCreateDatabase(){
    _dbCreation();
  }

  Future<void> _dbCreation() async {
    try {
      await isCreatedDone().then((value) {
        // ✅ Do something when data arrives
        Future.microtask(() {
          if (kDebugMode) logger.d("valor $value");
          bool check = value == null ? false : true;
          if(!check) {
            if (kDebugMode) logger.d("1");
            _dbHelper.database;
            _isReady = true;
            _isFirstLoad = true;
            storage.write(key: 'database_created', value: "true");
          }
          if (kDebugMode) logger.d("2");
          _isReady = true;
          _isFirstLoad = false;
        });
      }).whenComplete((){
        notifyListeners();
      });
    }  on Exception catch (e) {
      if (kDebugMode) logger.d("3");
      if (kDebugMode) logger.e(e.toString());
    }
    if (kDebugMode) logger.d("4");
  }

  Future<String?> isCreatedDone() async {
    final isCreated = await storage.read(key: 'database_created');
    if (kDebugMode) logger.d("isCreated $isCreated");
    return isCreated;
  }
}

final handleCreateDatabaseProvider = Provider<HandleCreateDatabase>((ref) => HandleCreateDatabase(),);