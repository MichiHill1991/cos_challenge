import 'package:cos_challenge/providers/auth_provider.dart';
import 'package:cos_challenge/snippet.dart';
import 'package:cos_challenge/utils/vin_generator.dart';
import 'package:cos_challenge/widgets/progress.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _vinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  late AppLocalizations _loc;

  @override
  Widget build(BuildContext context) {
    _loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(_loc.homeTitle),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    maxLength: CosChallenge.vinLength,
                    validator: _validateVin,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loading ? null : _searchVin,
                onLongPress: kDebugMode ? _fillUp : null,
                child: _loading ? CosProgress() : Text(_loc.search),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateVin(String? vin) {
    if (vin == null || vin.isEmpty) {
      return _loc.vinEmptyError;
    } else if (vin.length != CosChallenge.vinLength) {
      return _loc.vinLengthError;
    }
    return null;
  }

  Future<void> _searchVin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    try {
      final vin = _vinController.text.trim();
      await _fakeApiCall(vin);
      if (!mounted) return;

      final content = SnackBar(content: Text(_loc.vinSearchSuccess));
      ScaffoldMessenger.of(context).showSnackBar(content);
    } catch (e) {
      if (!mounted) return;

      final content = SnackBar(content: Text(_loc.vinSearchFailed));
      ScaffoldMessenger.of(context).showSnackBar(content);
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _fakeApiCall(String vin) async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _logout() async {
    await ref.read(authProvider.notifier).logout();
  }

  @override
  void dispose() {
    _vinController.dispose();
    super.dispose();
  }

  void _fillUp() {
    setState(() => _vinController.text = VinGenerator.generate());
  }
}
