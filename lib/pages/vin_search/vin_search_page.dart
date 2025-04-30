import 'dart:async';

import 'package:cos_challenge/model/error.dart';
import 'package:cos_challenge/model/multiple_choices.dart';
import 'package:cos_challenge/model/success.dart';
import 'package:cos_challenge/pages/auction/auction_page.dart';
import 'package:cos_challenge/pages/multiple_choices/multiple_choices_page.dart';
import 'package:cos_challenge/providers/data_provider.dart';
import 'package:cos_challenge/utils/vin_generator.dart';
import 'package:cos_challenge/widgets/progress.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VinSearchPage extends ConsumerStatefulWidget {
  const VinSearchPage({super.key});

  @override
  ConsumerState<VinSearchPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<VinSearchPage> {
  final _vinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  late AppLocalizations _loc;

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_loc.appBarSearch),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
          const SizedBox(width: 8),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              _loc.cardTitle,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              _loc.cardSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _vinController,
              decoration: InputDecoration(
                labelText: _loc.enterVin,
                border: const OutlineInputBorder(),
              ),
              maxLength: 17,
              validator: _validateVin,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _onSearchPressed,
              onLongPress: kDebugMode ? _fillUp : null,
              child: _loading ? const CosProgress() : Text(_loc.search),
            ),
          ],
        ),
      ),
    );
  }

  String? _validateVin(String? vin) {
    if (vin == null || vin.isEmpty) {
      return _loc.vinEmptyError;
    } else if (vin.length != 17) {
      return _loc.vinLengthError;
    }
    return null;
  }

  void _fillUp() {
    setState(() => _vinController.text = VinGenerator.generate());
  }

  Future<void> _onSearchPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final vin = _vinController.text.trim();
      final result = await ref.read(dataProvider.notifier).searchVin(vin);

      if (!mounted) return;
      if (result is Success) {
        _navigateTo(AuctionPage(data: result));
      } else if (result is List<MultipleChoices>) {
        _navigateTo(MultipleChoicesPage(data: result));
      } else if (result is ErrorMessage) {
        _showSnackBar(_loc.vinSearchError(result.params.delaySeconds));
      }
    } catch (_) {
      _showSnackBar(_loc.vinSearchFailed);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _navigateTo(Widget page) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _logout() async {
    await ref.read(dataProvider.notifier).logout();
  }
}
