import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../device/utils/loggerConfig.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/26/22
 */

class FireBaseAuthUC extends ChangeNotifier {
  bool isLoggedIn = false;
  User? user;

  Future<void> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.e('Wrong password provided.');
      }
    }
  }

  Future<void> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      if (e.code == 'weak-password') {
        logger.d('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logger.d('The account already exists for that email.');
      }
      logger.e(e);
    } catch (e) {
      logger.e(e);
    }
  }

  void validateInstance(BuildContext context) async {
    logger.d("validating user session");
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        logger.w('User is currently signed out!');
        isLoggedIn = false;
        notifyListeners();
        Navigator.pushReplacementNamed(context, "/main");
      } else {
        logger.d('User is signed in!');
        isLoggedIn = true;
        notifyListeners();
        Navigator.pushReplacementNamed(context, "/navigator");
      }
    });
  }

  Future<User?> getUserInstance() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }
}

final fireBaseAuthApiProvider =
    ChangeNotifierProvider<FireBaseAuthUC>((ref) => FireBaseAuthUC());
