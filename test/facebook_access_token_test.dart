import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap()', () {
    test('should create instance with correct values', () {
      final map = <String, dynamic>{
        'token': 'fake_token',
        'userId': '123456',
        'expires': 1646057049123,
        'permissions': ['email'],
        'declinedPermissions': <String>[],
      };

      final res = FacebookAccessToken.fromMap(map);

      expect(res.token, 'fake_token');
      expect(res.userId, '123456');
      expect(res.expires, DateTime.utc(2022, 02, 28, 14, 04, 09, 123));
      expect(res.permissions, ['email']);
      expect(res.declinedPermissions, <String>[]);
    });
  });
}
