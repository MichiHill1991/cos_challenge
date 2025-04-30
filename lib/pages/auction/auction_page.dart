import 'package:cos_challenge/model/success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuctionPage extends StatelessWidget {
  final Success data;

  const AuctionPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(loc.appBarAuction)),
      body: const Placeholder(),
    );
  }
}
