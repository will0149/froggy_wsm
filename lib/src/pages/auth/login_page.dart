import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

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
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                left: size.width * 0.10,
                right: size.width * 0.10,
              ),
              child: Form(
                key: loginFormKey,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: [
                    TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'example@example.com',
                        labelText: S.of(context).email,

                      ),
                    ),
                    const Divider(),
                    TextFormField(
                      controller: passwordController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.text,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: '******',
                        labelText: S.of(context).password,
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
                   ElevatedButton(
                       onPressed: () {},
                       child: Text(
                         "Ingresar",
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.normal,
                         ),
                       ),
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Colors.blue),
                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                         RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0),
                           side: const BorderSide(
                               color: Colors.blue,
                               width: 1.2
                           ),
                         ),
                       ),
                     ),

                   ),
                  ],
                ),
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
