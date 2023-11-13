import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/pages/auth/sign_up_page.dart';
import 'package:parkea/app/pages/auth/welcome_slide_page.dart';
import 'package:parkea/app/themes/buttom_transparent_border_blue.dart';
import 'package:parkea/app/widgets/exit_pop_scope.dart';
import 'package:parkea/app/widgets/paints/bottom_left_curve_orange.dart';
import 'package:parkea/app/widgets/paints/middle_wave_white.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';
import 'package:parkea/generated/l10n.dart';

import 'login_page.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  static String get routeName => 'auth';
  static String get routeLocation => '/$routeName';

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends ConsumerState<AuthPage> {
  @override
  Widget build(BuildContext context) {

    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
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
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  S.of(context).parkeaAndShare,
                  textStyle: Theme.of(context).textTheme.headlineMedium/**/?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
              repeatForever: false,
              onTap: () {
                print("Tap Event");
              },
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
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontFamily: "GothicA1-Bold",
                        shadows: [
                          const Shadow(
                              color: Colors.white,
                              offset: Offset(2, 1),
                              blurRadius: 1)
                        ]),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.065,
                    child: ElevatedButton(
                      onPressed: () {
                        context.goNamed(LoginPage.routeName);
                      },
                      style: buttonTransparentBlue,
                      child: Text(
                        S.of(context).authenticate,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.065,
                    // width: size.width * 0.8,
                    // height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        context.goNamed(SignUpPage.routeName);
                      },
                      style: buttonTransparentBlue,
                      child: Text(
                        S.of(context).signUp,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                S.of(context).devStudio,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontFamily: "GothicA1-Bold"
                ),
              ),
            ),
            onTap: () {
              context.goNamed(WelcomeSlidePage.routeName);
            },
          ),
        ],
      ),
    ));
  }
}
