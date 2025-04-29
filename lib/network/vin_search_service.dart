import 'dart:convert';

import 'package:cos_challenge/model/error.dart';
import 'package:cos_challenge/model/multiple_choices.dart';
import 'package:cos_challenge/model/success.dart';
import 'package:http/http.dart';

class VinSearchService {
  final Client client;

  VinSearchService({Client? client}) : client = client ?? Client();

  static const String baseUrl = 'anyUrl';

  Future<Object> searchVin(String vin, String userId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/search/$vin'),
      headers: {'user': userId},
    );

    switch (response.statusCode) {
      case 200:
        return Success.fromJson(jsonDecode(response.body));
      case 300:
        return listFromJson(response.body);
      case 400:
        return ErrorMessage.fromJson(jsonDecode(response.body));
      default:
        throw Exception('Unhandled status code');
    }
  }
}
