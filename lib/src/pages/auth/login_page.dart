import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../constants/colors.dart';
import '../../widgets/scaffolds/safe_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late final TextEditingController userEmailController =
      TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeScaffold(
        child: Container(
      margin: EdgeInsets.only(
        left: size.width * 0.10,
        right: size.width * 0.10,
      ),
      child: Stack(
        children: [
          Center(
            child: Form(
              key: loginFormKey,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15.0,
                runSpacing: 20.0,
                children: [
                  Text(
                    S.of(context).welcomeAgain,
                    style: const TextStyle(
                      color: parkeaBlueAccent,
                      fontWeight: FontWeight.normal,
                      fontSize: 28,
                    ),
                  ),
                    TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'example@example.com',
                        labelText: S.of(context).email,
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: '******',
                      labelText: S.of(context).password,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must be longer than 8 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            S.of(context).login,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: parkeaBlueAccent,
                            fixedSize: Size(120, 43),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side:
                              const BorderSide(color: parkeaBlueAccent, width: 1.2),
                            ),
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            text: S.of(context).forgotPassword,
                            style: const TextStyle(
                              color: parkeaBlueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () =>
                                  Navigator.pushNamed(context, "/main"),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
