import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:list_ext/list_ext.dart';

/// Facebook access token.
class FacebookAccessToken {
  final String token;
  final String userId;
  final DateTime expires;
  final List<String> permissions;
  final List<String> declinedPermissions;

  FacebookAccessToken(this.token, this.userId, this.expires, this.permissions,
      this.declinedPermissions)
      : assert(token != null),
        assert(userId != null),
        assert(expires != null),
        assert(permissions != null),
        assert(declinedPermissions != null);

  FacebookAccessToken.fromMap(Map<String, dynamic> map)
      : token = map['token'],
        userId = map['userId'],
        expires =
            DateTime.fromMillisecondsSinceEpoch(map['expires'], isUtc: true),
        permissions = map['permissions'].cast<String>(),
        declinedPermissions = map['declinedPermissions'].cast<String>();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expires': expires.millisecondsSinceEpoch,
      'permissions': permissions,
      'declinedPermissions': declinedPermissions,
    };
  }

  /// Returns `true` if user did allow [permission].
  bool isAllowed(FacebookPermission permission) =>
      permissions.contains(permission.name);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacebookAccessToken &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          userId == other.userId &&
          expires == other.expires &&
          permissions.isUnorderedEquivalent(other.permissions) &&
          declinedPermissions.isUnorderedEquivalent(other.declinedPermissions);

  @override
  int get hashCode =>
      token.hashCode ^
      userId.hashCode ^
      expires.hashCode ^
      permissions.hashCode ^
      declinedPermissions.hashCode;

  @override
  String toString() {
    return 'FacebookAccessToken(token: $token, userId: $userId, '
        'expires: $expires, permissions: $permissions, '
        'declinedPermissions: $declinedPermissions)';
  }
}
