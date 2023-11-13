import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/06/23
 */

final authSessionProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});