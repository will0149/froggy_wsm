import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../device/utils/loggerConfig.dart';
import '../../usecases/auth/fire_base_auth_uc.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/06/23
 */

final authSessionProvider = StreamProvider<User?>((ref) {
  final authInstance = ref.watch(fireBaseAuthApiProvider);
  ref.onDispose(() {
    logger.w('authSessionProvider has been disposed');
  });
  return authInstance.auth.authStateChanges();
});