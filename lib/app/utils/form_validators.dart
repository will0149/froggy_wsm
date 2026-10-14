import 'package:flutter/widgets.dart';

import '../../generated/l10n.dart';

/// Made for parkea.
/// By User: josedominguez
/// Date: 10/13/26

/// Validadores de los formularios de auth. Las reglas de contraseña del API
/// (no común, no solo numérica…) solo se comprueban en el servidor.
abstract final class FormValidators {
  static const minPasswordLength = 8;

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

  static String? newPassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    return value.length < minPasswordLength
        ? S.of(context).passwordTooShort
        : null;
  }

  static String? confirmPassword(
      BuildContext context, String? value, String password) {
    if (value == null || value.isEmpty) return S.of(context).fieldRequired;
    return value != password ? S.of(context).passwordsDoNotMatch : null;
  }
}
