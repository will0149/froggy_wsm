import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/usecases/auth/validate_session_uc.dart';
import '../../widgets/color_loader.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  late final ValidateSessionUC uc = ValidateSessionUC();

  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(milliseconds: 1500);
    return Timer(duration, route);
  }

  route() {
    uc.validateInstance(context);
  }

  initScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            ColorLoader(),
          ],
        ),
      ),
    );
  }
}
