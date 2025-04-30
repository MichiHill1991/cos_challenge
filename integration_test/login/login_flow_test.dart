import 'package:cos_challenge/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('LoginPage displays and validates inputs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale("en"),
          home: const LoginPage(),
        ),
      ),
    );

    expect(find.textContaining('Mail address'), findsWidgets);
    expect(find.textContaining('Password'), findsWidgets);
    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.textContaining('Please enter your mail address'), findsWidgets);
    expect(find.textContaining('Please enter password'), findsWidgets);

    /*
     * Todo:
     * Make test more deterministic -> current mock endpoint sends random
     * responses, each test should cover a specific case!
     *
     * Idea:
     * Create for each test a client which can be injected into the UserService
     * to generate specific responses based on the use case
     */
  });
}
