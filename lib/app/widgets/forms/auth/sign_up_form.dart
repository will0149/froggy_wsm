import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/device/utils/loggerConfig.dart';
import 'package:parkea/generated/l10n.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../../domain/usecases/auth/fire_base_auth_uc.dart';
import '../../../pages/home/home_feed_page.dart';

class SignUpForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignUpForm({Key? key, required this.formKey}) : super(key: key);

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends ConsumerState<SignUpForm> {
  var userNameController = TextEditingController();
  var provinceController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isLoading = false;
  bool _valid = false;

  final List<Map<String, dynamic>> _provinces = [
    {
      'value': 'panama',
      'label': 'Panama',
      'textStyle': const TextStyle(
        color: parkeaBlueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      'icon': const Icon(Icons.location_city),
    },
    {
      'value': 'colon',
      'label': 'Colón',
      'textStyle': const TextStyle(
        color: parkeaBlueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      'icon': const Icon(Icons.location_city),
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
      'icon': const Icon(Icons.location_city),
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
      'icon': const Icon(Icons.location_city),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(fireBaseAuthApiProvider);
    return Form(
      key: widget.formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15.0,
        runSpacing: 20.0,
        children: [
          TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              hintText: 'fulano',
              labelText: S.of(context).name,
              prefixIcon: const Icon(Icons.person),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Most has a value';
              } else {
                return null;
              }
            },
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
            validator: (value) {
              if (value!.isEmpty) {
                return 'Most select a value';
              } else {
                return null;
              }
            },
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
                return 'Most has a value';
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
              _isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: parkeaOrange,
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
                          _isLoading = true;
                        });
                        if (_valid) {
                          //set user session data
                          authState
                              .registerUsingEmailPassword(
                            name: userNameController.value.text,
                            email: emailController.value.text,
                            password: passwordController.value.text,
                          )
                              .catchError((error) {
                            logger.e(error);
                            setState(() {
                              _isLoading = false;
                            });
                          });

                          if (authState.isLoggedIn) {
                            logger.d("Process Complete and logging");
                            setState(() {
                              _isLoading = false;
                            });
                            context.goNamed(HomeFeedPage.routeName);
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: Text(
                        S.of(context).signUp,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
