import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../device/utils/loggerConfig.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/26/22
 */

class FireBaseAuthUC {

  Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  void validateInstance(BuildContext context) async {
    logger.d("validating user session");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        logger.w('User is currently signed out!');
        Navigator.pushReplacementNamed(context, "/main");
      } else {
        logger.d('User is signed in!');
        Navigator.pushReplacementNamed(context, "/navigator");
      }
    });
  }

  Future<User?> getUserInstance() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

}

final fireBaseAuthApiProvider = Provider<FireBaseAuthUC>((ref) => FireBaseAuthUC());
