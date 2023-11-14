import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap()', () {
    test('should create instance with correct values', () {
      final map = _map();

      final res = FacebookAccessToken.fromMap(map);

      expect(res.token, 'fake_token');
      expect(res.userId, '123456');
      expect(res.expires, DateTime.utc(2022, 02, 28, 14, 04, 09, 123));
      expect(res.permissions, ['email']);
      expect(res.declinedPermissions, <String>[]);
    });

    test('should handle too long expires', () {
      final map = _map(
        expires: 9223372036854775807,
      );

      final res = FacebookAccessToken.fromMap(map);

      expect(res.token, 'fake_token');
      expect(res.userId, '123456');
      // Max supported value
      expect(res.expires, DateTime.utc(275760, 09, 13));
      expect(res.permissions, ['email']);
      expect(res.declinedPermissions, <String>[]);
    });
  });
}

Map<String, Object?> _map({
  String token = 'fake_token',
  String userId = '123456',
  int expires = 1646057049123,
  List<String> permissions = const ['email'],
  List<String> declinedPermissions = const <String>[],
}) =>
    {
      'token': token,
      'userId': userId,
      'expires': expires,
      'permissions': permissions,
      'declinedPermissions': declinedPermissions,
    };
