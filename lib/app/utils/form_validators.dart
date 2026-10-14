import 'package:flutter/widgets.dart';

import '../../generated/l10n.dart';
import 'password_policy.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Validadores de los formularios de auth.
abstract final class FormValidators {
  static final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  static String? required(BuildContext context, String? value) =>
      value == null || value.trim().isEmpty
          ? S.of(context).fieldRequired
          : null;

  /// Con [optional] un campo vacío es válido.
  static String? email(BuildContext context, String? value,
      {bool optional = false}) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return optional ? null : S.of(context).fieldRequired;
    return _emailRegex.hasMatch(email) ? null : S.of(context).invalidEmail;
  }

  /// Mismas reglas que el API (ver [PasswordPolicy]); muestra todas a la vez,
  /// una por línea, como hace el API.
  static String? newPassword(BuildContext context, String? value,
      {Iterable<String?> userAttributes = const []}) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    final issues = PasswordPolicy.check(value, userAttributes: userAttributes);
    if (issues.isEmpty) return null;
    final s = S.of(context);
    return issues
        .map((issue) => switch (issue) {
              PasswordIssue.tooSimilar => s.passwordTooSimilar,
              PasswordIssue.tooShort => s.passwordTooShort,
              PasswordIssue.tooCommon => s.passwordTooCommon,
              PasswordIssue.entirelyNumeric => s.passwordEntirelyNumeric,
            })
        .join('\n');
  }

  static String? confirmPassword(
      BuildContext context, String? value, String password) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    return value != password ? S.of(context).passwordsDoNotMatch : null;
  }
}
