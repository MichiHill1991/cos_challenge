import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServerException implements Exception {
  final String message;
  final int statusCode;

  ServerException(this.statusCode, this.message);
}

extension ServerExceptionExtension on ServerException {
  String? getLoginErrorMessage(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    if (statusCode == 400) return loc.loginServerError400;
    if (statusCode == 401) return loc.loginServerError401;
    if (statusCode == 403) return loc.loginServerError403;
    if (statusCode == 500) return loc.loginServerError500;
    return null;
  }
}
