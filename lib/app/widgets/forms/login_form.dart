import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:froggy_soft/domain/logics/auth/rest_auth_uc.dart';
import 'package:froggy_soft/domain/models/auth/auth_state.dart';
import 'package:froggy_soft/generated/l10n.dart';
import 'package:go_router/go_router.dart';

import '../../../device/utils/logger_config.dart';
import '../../../domain/dtos/auth/login_dto.dart';
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
    final authState = ref.watch(restAuthUCProvider);

    ref.listen<AsyncValue<AuthState>>(restAuthUCProvider, (previous, next) {
      next.whenOrNull(
        data: (state) {
          if (state.isAuthenticated) {
            context.goNamed(MainPage.routeName);
          } else if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error al iniciar sesión')),
            );
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $error')),
          );
        },
      );
    });
    var size = MediaQuery.of(context).size;
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
                      _isObscure ? Icons.visibility_off : Icons.visibility,
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
          authState.isLoading
              ? Container(
                  margin: const EdgeInsets.all(10.0),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
          )
              : SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      final isValid = _loginFormKey.currentState!.validate();
                      if (isValid) {
                        await ref
                            .read(restAuthUCProvider.notifier)
                            .signIn(LoginDTO(
                          email: emailInputController.value.text,
                          password: pwdInputController.value.text,
                        ),);
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
