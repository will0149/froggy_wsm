import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../../generated/l10n.dart';
import '../../../config/loggerConfig.dart';
import '../../../constants/colors.dart';
import '../../../helpers/fire_base_auth_helper.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignUpForm({Key? key, required this.formKey}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var userNameController = TextEditingController();
  var provinceController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isObscure = true;
  bool _loading = false;
  bool _valid = false;
  var fireBaseAuthHelper = FireBaseAuthHelper();

  final List<Map<String, dynamic>> _provinces = [
    {
      'value': 'panama',
      'label': 'Panama',
      'textStyle': const TextStyle(
        color: parkeaBlueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      'icon': Icon(Icons.location_city),
    },
    {
      'value': 'herrera',
      'label': 'Herrera',
      'enable': false,
      'textStyle': const TextStyle(
        color: parkeaBlueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      'icon': Icon(Icons.location_city),
    },
    {
      'value': 'chorrera',
      'label': 'Chorrera',
      'enable': false,
      'textStyle': const TextStyle(
        color: parkeaBlueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      'icon': Icon(Icons.location_city),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator.adaptive()
        : Form(
            key: widget.formKey,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 15.0,
              runSpacing: 20.0,
              children: [
                TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    hintText: 'fulano',
                    labelText: S.of(context).name,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                SelectFormField(
                  //controller: provinceController,
                  type: SelectFormFieldType.dropdown,
                  // or can be dialog
                  initialValue: 'panama',
                  labelText: S.of(context).province,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: parkeaBlueAccent,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                  items: _provinces,
                  onChanged: (val) => print(val),
                  onSaved: (val) => print(val),
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
                Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    ElevatedButton(
                      child: Text(
                        S.of(context).signUp,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: parkeaOrange,
                        fixedSize: const Size(120, 43),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:
                              const BorderSide(color: parkeaOrange, width: 1.2),
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
                              .registerUsingEmailPassword(
                            name: userNameController.value.text,
                            email: emailController.value.text,
                            password: passwordController.value.text,
                          )
                              .whenComplete(() {
                            logger.d("Process Complete");
                            setState(() {
                              _loading = false;
                            });
                          });
                          logger.d(user);
                          if (user != null) {
                            logger.d('User is signed in!');
                            // Navigator.pushNamed(context, "/navigation");
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
