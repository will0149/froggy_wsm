import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkea/app/pages/auth/login_page.dart';

import '../../../../device/utils/loggerConfig.dart';
import '../../../../domain/usecases/auth/fire_base_auth_uc.dart';
import '../../../../generated/l10n.dart';
import '../../../colors.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/16/23
 */

class ResetPasswordForm extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  const ResetPasswordForm({super.key, required this.formKey});

  @override
  ResetPasswordFormState createState() => ResetPasswordFormState();
}

class ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  var emailController = TextEditingController();
  bool _valid = false;
  bool _isObscure = true;
  bool isLoading = false;
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
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'example@example.com',
              labelText: S.of(context).email,
              prefixIcon: const Icon(Icons.email),
            ),
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
                      onPressed: () async {
                        setState(() {
                          _valid = widget.formKey.currentState!.validate();
                          isLoading = true;
                        });
                        if (_valid) {
                          //set user session data
                          authState.auth
                              .sendPasswordResetEmail(
                            email: emailController.value.text,
                          )
                              .catchError((error) {
                            logger.e(error);
                            setState(() {
                              isLoading = false;
                            });
                          });
                          setState(() {
                            isLoading = false;
                          });

                          context.goNamed(LoginPage.routeName); //
                        }
                      },
                      child: Text(
                        S.of(context).resetPassword,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.white, fontSize: 12),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
