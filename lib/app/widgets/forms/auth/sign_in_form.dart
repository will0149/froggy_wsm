import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
import 'package:parkea/generated/l10n.dart';

import '../../../../data/entities/login_dto.dart';
import '../../../../domain/usecases/auth/rest_auth_uc.dart';
import '../../../pages/auth/password_reset_page.dart';
import '../../../utils/form_validators.dart';

class SignInForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const SignInForm({super.key, required this.formKey});

  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends ConsumerState<SignInForm> {
  var identifierController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                  content:
                      Text(state.errorMessage ?? 'Error al iniciar sesión')),
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
          Text(
            S.of(context).welcomeAgain,
            style: Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: parkeaBlueAccent),
          ),
          TextFormField(
            controller: identifierController,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: S.of(context).usernameOrEmail,
              prefixIcon: const Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return S.of(context).usernameOrEmailRequired;
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
            validator: (value) => FormValidators.required(context, value),
          ),
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10.0,
            runSpacing: 10.0,
            children: [
              authState.isLoading
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
                        final isValid = widget.formKey.currentState!.validate();
                        if (isValid) {
                          await ref.read(restAuthUCProvider.notifier).signIn(
                                LoginDTO.fromIdentifier(
                                  identifierController.value.text,
                                  passwordController.value.text,
                                ),
                              );
                        }
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
