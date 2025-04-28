import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginValidators {
  static String? validateEmail(BuildContext context, String? email) {
    final loc = AppLocalizations.of(context)!;
    const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

    if (email == null || email.isEmpty) {
      return loc.loginErrorEmailEmpty;
    } else if (!RegExp(emailRegex).hasMatch(email)) {
      return loc.loginErrorInvalidMail;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? password) {
    final loc = AppLocalizations.of(context)!;

    if (password == null || password.isEmpty) {
      return loc.loginErrorPasswordEmpty;
    } else if (password.length < 6) {
      return loc.loginErrorCharacterLength;
    }
    return null;
  }
}
