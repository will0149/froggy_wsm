import 'package:flutter/material.dart';
import 'package:parkea/app/colors.dart';
import 'package:parkea/app/widgets/forms/auth/sign_in_form.dart';

import '../../../generated/l10n.dart';
import '../../widgets/scaffolds/AuthScaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String get routeName => 'login';
  static String get routeLocation => '$routeName';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      color: parkeaBlueAccent,
      bannerText: S.of(context).login,
      form: SignInForm(
        formKey: loginFormKey,
      ),
    );
  }
}
