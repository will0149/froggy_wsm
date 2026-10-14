import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/data/entities/auth/register_dto.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
import 'package:parkea/domain/usecases/auth/rest_auth_uc.dart';
import 'package:parkea/generated/l10n.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../../utils/form_validators.dart';

class SignUpForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignUpForm({super.key, required this.formKey});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends ConsumerState<SignUpForm> {
  var userNameController = TextEditingController();
  var provinceController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2nd = true;

  @override
  void dispose() {
    userNameController.dispose();
    provinceController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

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
    final authState = ref.watch(restAuthUCProvider);

    ref.listen<AsyncValue<AuthState>>(restAuthUCProvider, (previous, next) {
      next.whenOrNull(
        data: (state) {
          // Al autenticarse, el redirect del router lleva al home.
          if (state.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.errorMessage ?? 'Error al registrarse')),
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
            autocorrect: false,
            validator: (value) => FormValidators.required(context, value),
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
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'example@example.com',
              labelText: S.of(context).email,
              prefixIcon: const Icon(Icons.email),
            ),
            validator: (value) =>
                FormValidators.email(context, value, optional: true),
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
            validator: (value) => FormValidators.newPassword(context, value),
          ),
          TextFormField(
            controller: passwordConfirmationController,
            keyboardType: TextInputType.text,
            obscureText: _isObscure2nd,
            decoration: InputDecoration(
              hintText: '******',
              labelText: S.of(context).confirmPassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  icon: Icon(
                    _isObscure2nd ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure2nd = !_isObscure2nd;
                    });
                  }),
            ),
            validator: (value) => FormValidators.confirmPassword(
                context, value, passwordController.text),
          ),
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              authState.isLoading
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
                        final isValid = widget.formKey.currentState!.validate();
                        if (isValid) {
                          final email = emailController.value.text.trim();
                          final request = RegisterDto(
                            username: userNameController.value.text.trim(),
                            email: email.isEmpty ? null : email,
                            password1: passwordController.value.text,
                            password2:
                                passwordConfirmationController.value.text,
                          );
                          await ref
                              .read(restAuthUCProvider.notifier)
                              .register(request);
                        }
                      },
                      child: Text(
                        S.of(context).signUp,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
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
