import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      child: SafeScaffold(
        appBar: AppBar(
          title: Text(F.name),
          centerTitle: true,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.25,
                width: size.width * 1,
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  color: backGroundColor,
                  borderRadius:
                      const BorderRadius.only(bottomRight: Radius.circular(200.0), bottomLeft:  Radius.circular(200.0)),
                ),
                child: Center(
                  child: Wrap(
                    direction: Axis.vertical,
                    runAlignment: WrapAlignment.center,
                    children: [
                      Text(
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white),
                          "Hola!",
                      ),
                      Text(
                        "Bienvenido",
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                      ),
                      // Image.asset("assets/logo.png")
                    ],
                  ),
                ),
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
              child: Text(
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black87,
                    fontFamily: "GothicA1-Bold"
                ),
                "Atheneox Studios",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
