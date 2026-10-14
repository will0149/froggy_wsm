import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/usecases/auth/password_reset_uc.dart';
import '../../../../generated/l10n.dart';
import '../../../pages/auth/login_page.dart';
import '../../../themes/colors/colors.dart';
import '../../../utils/form_validators.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Si [uid] y [token] no vienen del enlace se piden a mano (útil en dev).
class ResetPasswordConfirmForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final String? uid;
  final String? token;

  const ResetPasswordConfirmForm({
    super.key,
    required this.formKey,
    this.uid,
    this.token,
  });

  @override
  ResetPasswordConfirmFormState createState() =>
      ResetPasswordConfirmFormState();
}

class ResetPasswordConfirmFormState
    extends ConsumerState<ResetPasswordConfirmForm> {
  late final uidController = TextEditingController(text: widget.uid);
  late final tokenController = TextEditingController(text: widget.token);
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool _isObscure = true;

  bool get _hasLinkData =>
      (widget.uid?.isNotEmpty ?? false) && (widget.token?.isNotEmpty ?? false);

  @override
  void dispose() {
    uidController.dispose();
    tokenController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!widget.formKey.currentState!.validate()) return;
    final error = await ref.read(passwordResetUCProvider.notifier).confirmReset(
          uid: uidController.text,
          token: tokenController.text,
          newPassword1: passwordController.text,
          newPassword2: passwordConfirmationController.text,
        );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error ?? S.of(context).passwordResetDone)),
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
            S.of(context).changePassword,
            style: const TextStyle(
              color: parkeaBlueAccent,
              fontWeight: FontWeight.normal,
              fontSize: 28,
            ),
          ),
          if (!_hasLinkData) ...[
            TextFormField(
              controller: uidController,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'UID',
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (value) => FormValidators.required(context, value),
            ),
            TextFormField(
              controller: tokenController,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Token',
                prefixIcon: Icon(Icons.key),
              ),
              validator: (value) => FormValidators.required(context, value),
            ),
          ],
          TextFormField(
            controller: passwordController,
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: S.of(context).newPassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _isObscure = !_isObscure),
              ),
            ),
            validator: (value) => FormValidators.newPassword(context, value),
          ),
          TextFormField(
            controller: passwordConfirmationController,
            obscureText: _isObscure,
            decoration: InputDecoration(
              labelText: S.of(context).confirmPassword,
              prefixIcon: const Icon(Icons.lock),
            ),
            validator: (value) => FormValidators.confirmPassword(
                context, value, passwordController.text),
          ),
          isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: parkeaBlueAccent,
                    fixedSize: const Size(160, 43),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side:
                          const BorderSide(color: parkeaBlueAccent, width: 1.2),
                    ),
                  ),
                  onPressed: _submit,
                  child: Text(
                    S.of(context).changePassword,
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
        ],
      ),
    );
  }
}
