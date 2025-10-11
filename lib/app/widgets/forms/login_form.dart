import 'package:froggy_soft/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/auth/login_dto.dart';
import '../../../domain/logics/clients/auth_logic.dart';
import '../../constants.dart';
import '../../pages/main_page.dart';
import '../toasts/build_toasts.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 07/11/24

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController pwdInputController = TextEditingController();

  bool _isObscure = true;
  bool _valid = false;
  bool isLoading = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailInputController.dispose();
    pwdInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var authHandlerP = ref.watch(authLogicProvider);
    return Form(
      key: _loginFormKey,
      child: Wrap(
        runAlignment: WrapAlignment.center,
        runSpacing: wrapVerticalSpacing,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: S.of(context).emailInput,
              hintText: "user@example.com",
              // icon: const Icon(
              //   Icons.email,
              //   color: Colors.orange,
              // ),
            ),
            controller: emailInputController,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: S.of(context).passwordInput,
              hintText: "********",
              // icon: const Icon(Icons.security, color: Colors.orange),
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Colors.orange),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  }),
            ),
            controller: pwdInputController,
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ),
          isLoading
              ? Container(
                  margin: const EdgeInsets.all(10.0),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
          )
              : SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _valid = _loginFormKey.currentState!.validate();
                        isLoading = true;
                      });

                      if (_valid) {
                        var data = LoginDTO(
                            email: emailInputController.text,
                            password: pwdInputController.text);
                        authHandlerP.signIn(data).then((value) {
                          var code = value?.status?.code;
                          logger.i("code in form $code");
                          if (code! >= 200 && code < 300) {
                            showSuccessToast("Login Success!!");
                            setState(() {
                              isLoading = false;
                            });
                            context.goNamed(MainPage.routeName);
                          } else {
                            showErrorToast(
                                "Datos Inválidos ${value?.status?.msg}");
                          }
                        }).whenComplete(() {
                          logger.i("finished sign in");
                          setState(() {
                            isLoading = false;
                          });
                        }).catchError((error) {
                          logger.e("bruja ${error.toString()}");
                          setState(() {
                            isLoading = false;
                          });
                          showErrorToast("Algo fallo ${error.toString()}!");
                        });
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      S.of(context).loginButton,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
          Center(
            child: Text(
              S.of(context).dontHaveAnAccountYet,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
