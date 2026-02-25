import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:flutter/foundation.dart';

import '../../../device/utils/logger_config.dart';
import '../../entities/firesstore_entity.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/19/25
 */

class FireStoreConfig {

  Future<bool> getActivateFlag() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('auth-check')
          .doc('eval-joyeros')
          .withConverter<FiresStoreEntity>(
            fromFirestore: (snapshots, _) => FiresStoreEntity.fromJson(snapshots.data()!),
            toFirestore: (entity, _) => entity.toJson(),
          )
          .get();

      if (kDebugMode){
        logger.d("flag is ${doc.data()?.toJson()}");
      }

      if (!doc.exists) {
        debugPrint('FirestoreConfig: Document "eval-joyeros" does not exist');
        return false;
      }

      final data = doc.data();
      return data?.activate ?? false;
    } catch (e) {
      debugPrint('FirestoreConfig: Error getting activate flag: $e');
      return false;
    }
  }
}
