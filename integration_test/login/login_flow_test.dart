// import 'package:cos_challenge/pages/login/login_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// void main() {
//   testWidgets('LoginPage displays and validates inputs', (tester) async {
//     await tester.pumpWidget(
//       ProviderScope(
//         child: MaterialApp(
//           localizationsDelegates: AppLocalizations.localizationsDelegates,
//           supportedLocales: AppLocalizations.supportedLocales,
//           home: const LoginPage(),
//         ),
//       ),
//     );
//
//     expect(find.text('Login'), findsOneWidget);
//
//     // Tap the login button without input
//     await tester.tap(find.byType(ElevatedButton));
//     await tester.pump();
//
//     // Should show validation errors
//     expect(find.textContaining('E-Mail'), findsWidgets);
//     expect(find.textContaining('Passwort'), findsWidgets);
//   });
// }
