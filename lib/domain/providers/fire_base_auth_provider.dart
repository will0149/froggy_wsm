import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../device/utils/loggerConfig.dart';
import 'auth/firebase_auth_provider.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/03/22

final userInstanceProvider = FutureProvider.autoDispose<User?>((ref) {
  final userInstance = ref.watch(fireBaseAuthApiProvider);
  // userInstance.validateInstance();
  ref.onDispose(() {
    logger.w('userInstance has been disposed');
  });
  return userInstance.getUserInstance();
});