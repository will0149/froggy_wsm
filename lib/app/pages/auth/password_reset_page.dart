import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';

import '../../../generated/l10n.dart';
import '../../widgets/forms/auth/reset_password_form.dart';
import '../../widgets/scaffolds/AuthScaffold.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/16/23
 */

class PasswordResetPage extends StatefulWidget {
  static String get routeName => 'resetPassword';
  static String get routeLocation => '$routeName';

  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  late final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
        color: parkeaDarkBlueAccent,
        bannerText: S.of(context).resetPassword,
        form: ResetPasswordForm(formKey: resetPasswordFormKey));
  }
}
