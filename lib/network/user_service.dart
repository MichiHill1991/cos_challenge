import 'dart:convert';

import 'package:cos_challenge/model/user.dart';
import 'package:cos_challenge/network/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class UserService {
  final Client client;

  UserService({Client? client}) : client = client ?? Client();

  static const String baseUrl = 'anyUrl';

  Future<User> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      debugPrint("${response.statusCode}: Failed to login: ${response.body}");
      throw ServerException(
        response.statusCode,
        'Failed to login: ${response.body}',
      );
    }
  }
}
