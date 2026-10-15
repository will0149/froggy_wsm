import 'package:flutter/material.dart';
import 'package:parkea/app/themes/colors/colors.dart';

import '../../../generated/l10n.dart';
import '../../widgets/forms/auth/reset_password_confirm_form.dart';
import '../../widgets/scaffolds/auth_scaffold.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Destino del enlace `parkea://reset-password?uid=..&token=..`.
class PasswordResetConfirmPage extends StatefulWidget {
  static String get routeName => 'resetPasswordConfirm';

  static String get routeLocation => 'confirm';

  final String? uid;
  final String? token;

  const PasswordResetConfirmPage({super.key, this.uid, this.token});

  @override
  State<PasswordResetConfirmPage> createState() =>
      _PasswordResetConfirmPageState();
}

class _PasswordResetConfirmPageState extends State<PasswordResetConfirmPage> {
  late final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      color: parkeaDarkBlueAccent,
      bannerText: S.of(context).resetPassword,
      form: ResetPasswordConfirmForm(
        formKey: formKey,
        uid: widget.uid,
        token: widget.token,
      ),
    );
  }
}
