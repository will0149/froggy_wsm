import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/widgets/forms/auth/sign_up_form.dart';
import 'package:parkea/app/widgets/paints/bottom_left_curve_orange.dart';
import 'package:parkea/app/widgets/paints/sign_in_up_white_shape.dart';
import 'package:parkea/app/widgets/scaffolds/safe_scaffold.dart';

import '../../../generated/l10n.dart';

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
                    "assets/backgrounds/alexander-popov-9vDdkxSCAD4-unsplash.jpg",
                  ),
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
          Positioned(
            left: 0.0,
            top: size.height * 0.08,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: parkeaOrange),
              child: Text(
                S.of(context).register,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: size.height,
            width: double.infinity,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 1,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: size.width * 0.10,
                        right: size.width * 0.10,
                      ),
                      child: SignUpForm(
                        formKey: signUpFormKey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
