import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../../pages/main_page.dart';

/// Made for cct_management.
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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
      key: _loginFormKey,
      child: Wrap(
        runAlignment: WrapAlignment.center,
        runSpacing: wrapVerticalSpacing,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Email',
                hintText: "user@example.com",
                icon: Icon(Icons.email)),
            controller: emailInputController,
            keyboardType: TextInputType.emailAddress,
          ),
          TextFormField(
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: "********",
              icon: const Icon(Icons.security),
              suffixIcon: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
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
          Container(
            width: size.width,
            margin: const EdgeInsets.all(10.0),
            child: OutlinedButton(
              child: Text("Iniciar Sesión",
                  style: Theme.of(context).textTheme.headlineSmall),
              onPressed: () {
                context.goNamed(MainPage.routeName);
              },
            ),
          ),
          Center(
              child: Text("Don't have an account yet?",
                  style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
