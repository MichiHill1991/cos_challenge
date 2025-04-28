import 'dart:convert';

import 'package:cos_challenge/network/exception.dart';
import 'package:http/http.dart';

class CosUserApi {
  final Client client;

  CosUserApi({Client? client}) : client = client ?? Client();

  static const String baseUrl = 'anyUrl';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw ServerException(
        response.statusCode,
        'Failed to login: ${response.body}',
      );
    }
  }
}
