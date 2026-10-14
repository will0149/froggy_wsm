import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/auth/login_page.dart';

import '../../../../domain/usecases/auth/password_reset_uc.dart';
import '../../../../generated/l10n.dart';
import '../../../pages/auth/password_reset_confirm_page.dart';
import '../../../themes/colors/colors.dart';
import '../../../utils/form_validators.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 11/16/23

class ResetPasswordForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;

  const ResetPasswordForm({super.key, required this.formKey});

  @override
  ResetPasswordFormState createState() => ResetPasswordFormState();
}

class ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!widget.formKey.currentState!.validate()) return;
    // El aviso de resultado quedaría detrás del teclado.
    FocusScope.of(context).unfocus();
    final error = await ref
        .read(passwordResetUCProvider.notifier)
        .requestReset(emailController.text);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ?? S.of(context).resetEmailSent)),
    );
    if (error == null) context.goNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(passwordResetUCProvider).isLoading;
    return Form(
      key: widget.formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 15.0,
        runSpacing: 20.0,
        children: [
          Text(
            S.of(context).resetPassword,
            style: const TextStyle(
              color: parkeaBlueAccent,
              fontWeight: FontWeight.normal,
              fontSize: 28,
            ),
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
            validator: (value) => FormValidators.email(context, value),
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
                        fixedSize: const Size(120, 43),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(
                              color: parkeaBlueAccent, width: 1.2),
                        ),
                      ),
                      onPressed: _submit,
                      child: Text(
                        S.of(context).resetPassword,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
              // En local no hay SMTP: el uid/token se copian del log del API.
              if (kDebugMode)
                TextButton(
                  onPressed: () =>
                      context.pushNamed(PasswordResetConfirmPage.routeName),
                  child: Text(S.of(context).haveResetLink),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
