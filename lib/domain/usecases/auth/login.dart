import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../device/utils/loggerConfig.dart';
import '../../repositories/LoginUseCaseI.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/26/22
 */

class LoginUseCase {

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.e('Wrong password provided.');
      }
    }

    return user;
  }

}
