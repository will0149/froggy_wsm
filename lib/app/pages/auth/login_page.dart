import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/widgets/forms/auth/sign_in_form.dart';
import 'package:parkea/app/widgets/paints/bottom_left_curve_orange.dart';
import 'package:parkea/app/widgets/paints/sign_in_up_white_shape.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String get routeName => 'login';
  static String get routeLocation => '$routeName';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.55,
                width: size.height * 0.55,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    image: AssetImage(
                        "assets/backgrounds/alexander-popov-9vDdkxSCAD4-unsplash.jpg"),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: parkeaBlueAccentOpacity,
              ),
            ),
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
                alignment: Alignment.center,
                height: size.height,
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 1,
                ),
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
        ));
  }
}
