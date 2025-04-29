import 'dart:convert';

import 'package:cos_challenge/model/success.dart';
import 'package:cos_challenge/model/user.dart';
import 'package:cos_challenge/network/user_service.dart';
import 'package:cos_challenge/network/user_service_mock.dart';
import 'package:cos_challenge/network/vin_search_service.dart';
import 'package:cos_challenge/snippet.dart';
import 'package:cos_challenge/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dataProvider = StateNotifierProvider<DataNotifier, DataState>((ref) {
  return DataNotifier();
});

class DataState {
  final bool isAuthenticated;
  final User? user;
  final Success? auction;

  DataState({required this.isAuthenticated, this.user, this.auction});

  DataState copyWith({bool? isAuthenticated, User? user, Success? auction}) {
    return DataState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      auction: auction ?? this.auction,
    );
  }
}

class DataNotifier extends StateNotifier<DataState> {
  DataNotifier() : super(DataState(isAuthenticated: false)) {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(CosConstants.prefsUser);
    if (userData != null) {
      final user = User.fromJson(jsonDecode(userData));
      state = DataState(isAuthenticated: true, user: user);
    } else {
      state = DataState(isAuthenticated: false, user: null);
    }

    final auctionData = prefs.getString(CosConstants.prefsAuction);
    if (auctionData != null) {
      final success = Success.fromJson(jsonDecode(auctionData));
      state = state.copyWith(auction: success);
    }
  }

  Future<void> login(String email, String password) async {
    final api = UserService(client: UserServiceMock());
    final userMap = await api.login(email, password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(CosConstants.prefsUser, jsonEncode(userMap));
    final user = User.fromJson(userMap);
    state = DataState(isAuthenticated: true, user: user);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(CosConstants.prefsUser);
    state = DataState(isAuthenticated: false, user: null, auction: null);
  }

  User? getUser() {
    return state.user;
  }

  Future<Object> searchVin(String vin) async {
    final api = VinSearchService(client: CosChallenge.httpClient);
    final result = await api.searchVin(vin, state.user!.id);
    if (result is Success) {
      state = state.copyWith(auction: result);
    }
    return result;
  }
}
