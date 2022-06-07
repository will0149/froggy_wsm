import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

import '../../../../generated/l10n.dart';
import '../../../config/loggerConfig.dart';
import '../../../constants/colors.dart';
import '../../../helpers/fire_base_auth_helper.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignInForm({Key? key, required this.formKey}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _savePassword = false;
  //ValueNotifier<bool> _loading = ValueNotifier(false);
  bool _loading = false;
  bool _valid = false;
  bool _isObscure = true;
  var fireBaseAuthHelper = FireBaseAuthHelper();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
            controller: emailController,
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
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
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
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
             _loading ? const CircularProgressIndicator.adaptive() : ElevatedButton(
                child: Text(
                  S.of(context).login,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 12.0),
                ),
                style: ElevatedButton.styleFrom(
                  primary: parkeaBlueAccent,
                  fixedSize: const Size(120, 43),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side:
                        const BorderSide(color: parkeaBlueAccent, width: 1.2),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _valid = widget.formKey.currentState!.validate();
                  });
                  if (_valid) {
                    setState(() {
                      _loading = true;
                    });

                    //set user session data
                    User? user = await fireBaseAuthHelper
                        .signInUsingEmailPassword(
                            email: emailController.value.text,
                            password: passwordController.value.text,
                            context: context,
                    )
                        .whenComplete(() {
                      logger.d("Process Complete");
                      setState(() {
                        _loading = false;
                      });
                    });

                    if (user != null) {
                      logger.d('User is signed in!');
                      FlutterToastr.show("User Sign in ${user.displayName}", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom);
                      //Navigator.pushNamed(context, "/navigation");
                    }
                    fireBaseAuthHelper.signOut();
                  }
                },
              ),
              Text.rich(
                TextSpan(
                  text: S.of(context).forgotPassword,
                  style: const TextStyle(
                    color: parkeaBlueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(context, "/main"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
