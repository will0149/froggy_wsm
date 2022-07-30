import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/themes/buttom_transparent_border_blue.dart';
import 'package:parkea/app/widgets/paints/bottom_left_curve_orange.dart';
import 'package:parkea/app/widgets/paints/middle_wave_white.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:parkea/generated/l10n.dart';

import '../../widgets/exit_pop_scope.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ExitPopScope(
        child: SafeScaffold(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.95,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topLeft,
                      image: AssetImage(
                          "assets/backgrounds/alex-voulgaris-jfoIIFLw3_Y-unsplash.jpg"),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: size.height * 0.55,
                  width: size.height * 0.55,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.bottomRight,
                      image: AssetImage(
                          "assets/backgrounds/angello-pro-tL5RIAYxObs-unsplash.jpg"),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: parkeaBlueAccentOpacity,
                ),
              ),
              Positioned(
                top: 40,
                left: size.width * 0.05,
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
                        width: size.width * 0.5,
                        height: size.height * 0.065,
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
                        width: size.width * 0.5,
                        height: size.height * 0.065,
                        // width: size.width * 0.8,
                        // height: size.height * 0.07,
                        child: ElevatedButton(
                          child: Text(
                            S.of(context).signUp,
                            style: const TextStyle(
                              color: parkeaBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/signup");
                          },
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
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
