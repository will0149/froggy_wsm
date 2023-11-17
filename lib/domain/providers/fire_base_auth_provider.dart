import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkea/domain/usecases/auth/fire_base_auth_uc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../device/utils/loggerConfig.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */

final userInstanceProvider = FutureProvider.autoDispose<User?>((ref) {
  final userInstance = ref.watch(fireBaseAuthApiProvider);
  // userInstance.validateInstance();
  ref.onDispose(() {
    logger.w('userInstance has been disposed');
  });
  return userInstance.getUserInstance();
});