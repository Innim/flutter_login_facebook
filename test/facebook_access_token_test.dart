import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isAllowed', () {
    test('should return true is allowed', () {
      final obj = _token(permissions: ["email"]);

      expect(obj.isAllowed(FacebookPermission.email), true);
    });

    test('should return false is declined', () {
      final obj = _token(declinedPermissions: ["email"]);

      expect(obj.isAllowed(FacebookPermission.email), false);
    });

    test('should return false is not presented', () {
      final obj = _token(
        permissions: ["publicProfile"],
        declinedPermissions: ['userFriends'],
      );

      expect(obj.isAllowed(FacebookPermission.email), false);
    });
  });
}

FacebookAccessToken _token(
        {String token,
        String userId,
        DateTime expires,
        List<String> permissions,
        List<String> declinedPermissions}) =>
    FacebookAccessToken(
      token ?? "test",
      userId ?? "test_id",
      expires ?? DateTime.now().add(Duration(days: 30)),
      permissions ?? ['publicProfile'],
      declinedPermissions ?? [],
    );
