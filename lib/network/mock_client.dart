import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class CosUserApiMock extends BaseClient {
  static final _statusCode = <int, Map<String, dynamic>>{
    200: {
      "id": "abcd-efgh-ijgk-mnop",
      "first_name": "Michael",
      "last_name": "Hill",
      "email": "michael.hill@mein-bankerl.de",
    },
    400: {"message": "Request body is faulted"},
    401: {"message": "Invalid login details (login failed)"},
    403: {"message": "You are not allowed to use this endpoint"},
    500: {"message": "Service is unavailable"},
  };

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    if (request is Request) {
      var user = jsonDecode(request.body);
      if ((user["email"]?.isEmpty ?? true) ||
          (user["password"]?.isEmpty ?? true)) {
        return _getResponseFromCode(400, request);
      }

      await Future<void>.delayed(const Duration(seconds: 1));
      var result = Random().nextInt(_statusCode.length + 1);
      var response = _statusCode.entries.toList()[result];

      return _getResponseFromCode(response.key, request);
    }

    return _getResponseFromCode(500, request);
  }

  StreamedResponse _getResponseFromCode(int code, BaseRequest request) {
    if (!_statusCode.containsKey(code)) {
      final body = _statusCode[500]!.values.first;
      return StreamedResponse(
        Stream.value(Uint8List.fromList(body!.codeUnits)),
        500,
        request: request,
      );
    }

    final body = _statusCode[code]!.values.first;
    return StreamedResponse(
      Stream.value(Uint8List.fromList(body!.codeUnits)),
      code,
      request: request,
    );
  }
}
