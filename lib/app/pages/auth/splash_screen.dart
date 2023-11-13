import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/widgets/color_loader.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/16/22
 */

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String get routeName => 'splash';
  static String get routeLocation => '$routeName';

  @override
  StartState createState() => StartState();
}

class StartState extends ConsumerState<SplashScreen> {
  bool isWelcome = false;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ColorLoader(),
        ],
      ),
    );
  }
}
