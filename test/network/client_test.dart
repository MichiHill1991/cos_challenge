import 'package:cos_challenge/network/api.dart';
import 'package:cos_challenge/network/mock_client.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CosUserApi Tests', () {
    late CosUserApi api;

    setUp(() {
      api = CosUserApi(client: CosUserApiMock());
    });

    test('Login successful returns user data', () async {
      final response = await api.login(
        'michael.hill@mein-bankerl.de',
        'COS123!',
      );

      expect(response['email'], equals('michael.hill@mein-bankerl.de'));
      expect(response['first_name'], equals('Michael'));
    });

    test('Login failed returns error message', () async {
      try {
        await api.login('', '');
        fail('Should have thrown an exception');
      } catch (e) {
        expect(e.toString(), contains('Login failed with status code: 400'));
      }
    });
  });
}
