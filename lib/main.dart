import 'package:cos_challenge/pages/login/login_page.dart';
import 'package:cos_challenge/pages/vin_search/vin_search_page.dart';
import 'package:cos_challenge/providers/data_provider.dart';
import 'package:cos_challenge/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(dataProvider);

    Widget page = LoginPage();
    if (authState.isAuthenticated) {
      page = VinSearchPage();
    }

    return MaterialApp(
      title: 'COS Challenge',
      theme: cosTheme,
      locale: Locale('en'),
      supportedLocales: const [Locale('de'), Locale('en')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: page,
    );
  }
}
