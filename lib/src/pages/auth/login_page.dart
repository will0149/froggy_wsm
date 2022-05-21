import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../constants/colors.dart';
import '../../widgets/forms/auth/sign_in_form.dart';
import '../../widgets/paints/bottom_left_curve_orange.dart';
import '../../widgets/paints/middle_wave_white.dart';
import '../../widgets/paints/sign_in_up_white_shape.dart';
import '../../widgets/scaffolds/safe_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
        child: Container(
      constraints: const BoxConstraints.expand(),
      height: size.height / 1.4,
      child: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: SignInUpWhiteShape(),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CustomPaint(
              painter: BottomLeftCurveOrange(),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 0.10,
                right: size.width * 0.10,
              ),
              child: SignInForm(
                formKey: loginFormKey,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
