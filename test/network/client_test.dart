import 'package:cos_challenge/network/user_service.dart';
import 'package:cos_challenge/network/user_service_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserService Tests', () {
    late UserService api;

    setUp(() {
      api = UserService(client: UserServiceMock());
    });

    test('Login successful returns user data', () async {
      final user = await api.login('michael.hill@mein-bankerl.de', 'COS123!');

      expect(user.email, equals('michael.hill@mein-bankerl.de'));
      expect(user.firstName, equals('Michael'));
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
