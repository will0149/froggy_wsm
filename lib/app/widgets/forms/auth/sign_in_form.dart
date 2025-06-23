import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:parkea/generated/l10n.dart';

import '../../../../data/entities/login_dto.dart';
import '../../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../pages/auth/password_reset_page.dart';
import '../../../pages/home/home_feed_page.dart';

class SignInForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignInForm({super.key, required this.formKey});

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends ConsumerState<SignInForm> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _valid = false;
  bool _isObscure = true;
  bool isLoading = false;
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authLogicProvider);
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
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'example@example.com',
              labelText: S.of(context).email,
              prefixIcon: const Icon(Icons.email),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email most has a value';
              } else {
                return null;
              }
            },
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
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: parkeaBlueAccent,
                        fixedSize: const Size(130, 43),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                              color: parkeaBlueAccent, width: 1.2),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          _valid = widget.formKey.currentState!.validate();
                          isLoading = true;
                        });
                        logger.i("loading $isLoading");
                        Timer(Duration(seconds: 3), () { //TODO: remove when login is complete
                          if (_valid) {
                            logger.i("step 1");
                            authState
                                .signIn(LoginDTO(
                              email: emailController.value.text,
                              password: passwordController.value.text,
                            ))
                                .then((value) {
                              logger.i("step 2");
                              var code = value?.status?.code;
                              logger.d("Value $code");
                              if (code! >= 200 && code < 300) {
                                // showSuccessToast("Login Success!!");
                                logger.i("step 3");
                                logger.d("Process Complete and logging");
                                context.goNamed(HomeFeedPage.routeName);
                              }
                            }).catchError((error) {
                              logger.i("step 5");
                              logger.e("bruja ${error.toString()}");
                              setState(() {
                                isLoading = false;
                              });
                              // showErrorToast("Algo fallo ${error.toString()}!");
                            });
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        });
                      },
                      child: Text(
                        S.of(context).login,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
              GestureDetector(
                onTap: () => context.pushNamed(PasswordResetPage.routeName),
                child: Text.rich(
                  TextSpan(
                    text: S.of(context).forgotPassword,
                    style: const TextStyle(
                      color: parkeaBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    // recognizer: TapGestureRecognizer()
                    //   ..onTap = () => Navigator.pushNamed(context, "/main"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
