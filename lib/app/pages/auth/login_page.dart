import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/app/paints/middle_wave_white.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../device/utils/device_info.dart';
import '../../../device/utils/is_first_run.dart';
import '../../constants.dart';
import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/login_form.dart';
import '../../widgets/scaffolds/kill_pop_scope.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 07/11/24

class LoginPage extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  static String get routeLocation => '/$routeName';

  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  DeviceInfo deviceInfo = DeviceInfo();
  String version = "";

  @override
  void initState() {
    // TODO: implement initState
    var firstRun = IsFirstRun();
    firstRun.setAfterFirstRun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return KillPopScope(
      context: context,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CustomPaint(
                painter: MiddleWaveWhite(),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: BaseFormDecorator(
                body: LoginForm(),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Wrap(
                direction: Axis.vertical,
                spacing: wrapHorizontalSpacing,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  // Wrap(
                  //   spacing: wrapHorizontalSpacing,
                  //   children: [
                  //     CircleAvatar(
                  //       child: Image.asset("assets/logos/atheneox.PNG", fit: BoxFit.cover,),
                  //     ),
                  //     CircleAvatar(
                  //       child: Image.asset("assets/logos/cct_logo.png", fit: BoxFit.cover,),
                  //     ),
                  //     CircleAvatar(
                  //       child: Image.asset("assets/logos/appstore.png", fit: BoxFit.cover,),
                  //     ),
                  //   ],
                  // ),
                  Wrap(
                    children: [
                      InkWell(
                        child: Text(
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.black87,
                                    fontFamily: "GothicA1-Bold",
                                  ),
                          'Jldm Developer'//S.of(context).devStudio,
                        ),
                        onTap: () => launchUrlString('https://atheneox.com'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 60,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Título principal "Froggy"
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xFF212121),
                        Color(0xFF424242),
                        Colors.orangeAccent,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      "Froggy",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// Subtítulo "Warehouse Manager"
                  Text(
                    "Warehouse Manager",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                      color: const Color(0xFF616161),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 3.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
