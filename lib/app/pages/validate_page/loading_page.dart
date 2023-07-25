import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/navigator.dart';
import 'package:parkea/app/pages/auth/auth_page.dart';
import 'package:parkea/app/widgets/color_loader.dart';
import 'package:parkea/domain/providers/fire_base_auth_provider.dart';

import '../../../device/utils/is_first_run.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  StartState createState() => StartState();
}

class StartState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  checkFirstSeen() async {
    var firstRun = IsFirstRun();
    bool firstCall = await firstRun.isFirstRun();
    if (firstCall) {
      Navigator.pushReplacementNamed(context, "/slideshow");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(userInstanceProvider);
    return authProvider.when(
      data: (user) {
        if (user != null) {
          return const NavigatorBar();
        } else {
          return const AuthPage();
        }
      },
      error: (err, s) => Text(err.toString()),
      loading: () => const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorLoader(),
            ],
          ),
        ),
      ),
    );
  }
}
