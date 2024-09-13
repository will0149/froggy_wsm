import 'package:cct_management/app/paints/middle_wave_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../device/utils/device_info.dart';
import '../../../device/utils/is_first_run.dart';
import '../../../flavors.dart';
import '../../constants.dart';
import '../../widgets/forms/base_form_decorator.dart';
import '../../widgets/forms/login_form.dart';
import '../../widgets/scaffolds/kill_pop_scope.dart';
import '../../widgets/scaffolds/safe_scaffold.dart';

/// Made for cct_management.
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
    var size = MediaQuery.of(context).size;
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
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: Colors.black87,
                                  fontFamily: "GothicA1-Bold",
                          ),
                          "Atheneox Studios",
                        ),
                        onTap: () => launchUrlString('https://atheneox.com'),
                      ),
                    ],
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
