import 'package:cos_challenge/network/exception.dart';
import 'package:cos_challenge/pages/login/login_validator.dart';
import 'package:cos_challenge/providers/auth_provider.dart';
import 'package:cos_challenge/widgets/progress.dart';
import 'package:cos_challenge/widgets/terms_of_use.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AppLocalizations _loc;

  bool _acceptPrivacy = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    _loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(_loc.login)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: _loc.email),
                validator: (email) {
                  return LoginValidators.validateEmail(context, email);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: _loc.password),
                obscureText: true,
                validator: (password) {
                  return LoginValidators.validatePassword(context, password);
                },
              ),
              const SizedBox(height: 16),
              TermsOfUseWidget(
                checked: _acceptPrivacy,
                onChange: _togglePrivacy,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                onLongPress: kDebugMode ? _fillUp : null,
                child: _loading ? CosProgress() : Text(_loc.login),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || !_acceptPrivacy) return;

    setState(() => _loading = true);
    try {
      var e = _emailController.text.trim();
      var p = _passwordController.text;
      await ref.read(authProvider.notifier).login(e, p);
    } on ServerException catch (e) {
      _showSnackBar(exception: e);
    } catch (e) {
      _showSnackBar();
    } finally {
      setState(() => _loading = false);
    }
  }

  void _togglePrivacy(bool? value) {
    setState(() => _acceptPrivacy = value ?? false);
  }

  void _fillUp() {
    setState(() {
      _emailController.text = "michael.hill@mein-bankerl.de";
      _passwordController.text = "COS123!";
      _acceptPrivacy = true;
    });
  }

  void _showSnackBar({ServerException? exception}) {
    if (!mounted) return;
    var text = exception?.getLoginErrorMessage(context) ?? _loc.loginFailed;
    var content = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(content);
  }
}
