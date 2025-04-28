import 'dart:convert';

import 'package:cos_challenge/network/api.dart';
import 'package:cos_challenge/network/mock_client.dart';
import 'package:cos_challenge/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  final bool isAuthenticated;
  final Map<String, dynamic>? user;

  AuthState({required this.isAuthenticated, this.user});
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState(isAuthenticated: false)) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(CosConstants.prefsUser);
    if (userData != null) {
      final userMap = jsonDecode(userData);
      state = AuthState(isAuthenticated: true, user: userMap);
    } else {
      state = AuthState(isAuthenticated: false, user: null);
    }
  }

  Future<void> login(String email, String password) async {
    final user = await CosUserApi(
      client: CosUserApiMock(),
    ).login(email, password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(CosConstants.prefsUser, jsonEncode(user));
    state = AuthState(isAuthenticated: true, user: user);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(CosConstants.prefsUser);
    state = AuthState(isAuthenticated: false, user: null);
  }
}
