import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../data/repositories/localdb/database_helper.dart';
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
          logger.d("valor $value");
          bool check = value == null ? false : true;
          if(!check) {
            logger.d("1");
            _dbHelper.database;
            _isReady = true;
            _isFirstLoad = true;
            storage.write(key: 'database_created', value: "true");
          }
          logger.d("2");
          _isReady = true;
          _isFirstLoad = false;
        });
      }).whenComplete((){
        notifyListeners();
      });
    }  on Exception catch (e) {
      logger.d("3");
      logger.e(e.toString());
    }
    logger.d("4");
  }

  Future<String?> isCreatedDone() async {
    final isCreated = await storage.read(key: 'database_created');
    logger.d("isCreated $isCreated");
    return isCreated;
  }
}

final handleCreateDatabaseProvider = Provider<HandleCreateDatabase>((ref) => HandleCreateDatabase(),);