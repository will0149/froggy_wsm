import 'package:flutter/material.dart';
import 'package:parkea/src/widgets/forms/auth/sign_up_form.dart';
import 'package:parkea/src/widgets/scaffolds/safe_scaffold.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../generated/l10n.dart';
import '../../widgets/paints/bottom_left_curve_orange.dart';
import '../../widgets/paints/sign_in_up_white_shape.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.10,
                        right: size.width * 0.10,
                      ),
                      child: SignUpForm(
                        formKey: signUpFormKey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
