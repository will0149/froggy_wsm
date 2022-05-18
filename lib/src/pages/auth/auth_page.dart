import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../../../generated/l10n.dart';
import '../../constants/colors.dart';
import '../../themes/buttom_transparent_border_blue.dart';
import '../../widgets/paints/bottom_left_curve_orange.dart';
import '../../widgets/paints/middle_wave_white.dart';
import '../../widgets/scaffolds/safe_scaffold.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  DateTime timeBackPress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        child: SafeScaffold(
      child: Container(
        constraints: const BoxConstraints.expand(),
        height: size.height / 1.4,
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: size.width * 0.05,
              child: Container(
                child: Text(
                S.of(context).parkeaAndShare,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  // decoration: TextDecoration.underline,
                  // decorationColor: parkeaOrange,
                ),
              ),
              ),
            ),
            SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: MiddleWaveWhite(),
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: BottomLeftCurveOrange(),
                  ),
                ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                  left: size.width * 0.10,
                  right: size.width * 0.10,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  direction: Axis.vertical,
                  spacing: 15.0,
                  runSpacing: 20.0,
                  children: [
                    Text(
                      S.of(context).joinOurUniverse,
                      style: const TextStyle(
                        color: parkeaBlueAccent,
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.055,
                      child: ElevatedButton(
                        child: Text(
                          S.of(context).authenticate,
                          style: const TextStyle(
                            color: parkeaBlueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        style: buttonTransparentBlue,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.055,
                      child: ElevatedButton(
                        child: Text(
                          S.of(context).signUp,
                          style: const TextStyle(
                            color: parkeaBlueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        onPressed: () {},
                        style: buttonTransparentBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                S.of(context).devStudio,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
      ),
    ),
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPress);
          final isExitWarning = difference >= Duration(seconds: 2);
          timeBackPress = DateTime.now();

          if (isExitWarning) {
            const message = "Press back again to exit";
            FlutterToastr.show(message, context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom);
            return false;
          } else {
            exit(0);
          }
        });
  }
}
