import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../device/utils/loggerConfig.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class ValidateSessionUC {

  void validateInstance(BuildContext context) async {
    logger.d("validating user session");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        logger.w('User is currently signed out!');
        Navigator.pushReplacementNamed(context, "/main");
      } else {
        logger.d('User is signed in!');
        Navigator.pushNamed(context, "/navigator");
      }
    });
  }
}