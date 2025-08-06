import 'package:flutter/material.dart';
import 'package:parkea/app/themes/colors/colors.dart';
import 'package:parkea/app/widgets/forms/auth/sign_up_form.dart';

import '../../../generated/l10n.dart';
import '../../widgets/scaffolds/AuthScaffold.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static String get routeName => 'signup';
  static String get routeLocation => '$routeName';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      color: parkeaOrange,
      bannerText: S.of(context).register,
      form: SignUpForm(
        formKey: signUpFormKey,
      ),
    );
  }
}
