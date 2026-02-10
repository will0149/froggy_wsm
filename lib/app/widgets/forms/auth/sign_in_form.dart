import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/domain/models/auth/auth_state.dart';
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
  bool _isObscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(restAuthUCProvider);

    ref.listen<AsyncValue<AuthState>>(restAuthUCProvider, (previous, next) {
      next.whenOrNull(
        data: (state) {
          if (state.isAuthenticated) {
            context.goNamed(HomeFeedPage.routeName);
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
                          await ref
                              .read(restAuthUCProvider.notifier)
                              .signIn(LoginDTO(
                                email: emailController.value.text,
                                password: passwordController.value.text,
                              ));
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
