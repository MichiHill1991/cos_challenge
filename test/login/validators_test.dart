import 'package:cos_challenge/pages/login/login_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('validateEmail returns error if empty', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            expect(LoginValidators.validateEmail(context, ''), isNotNull);
            return const SizedBox();
          },
        ),
      ),
    );
  });

  testWidgets('validateEmail returns error if invalid', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            expect(
              LoginValidators.validateEmail(context, 'invalid'),
              isNotNull,
            );
            return const SizedBox();
          },
        ),
      ),
    );
  });

  testWidgets('validatePassword returns error if too short', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            expect(LoginValidators.validatePassword(context, '123'), isNotNull);
            return const SizedBox();
          },
        ),
      ),
    );
  });
}
