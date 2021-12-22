import 'package:list_ext/list_ext.dart';

/// Facebook access token.
class FacebookAccessToken {
  final String token;
  final String userId;
  final DateTime expires;
  final List<String> permissions;
  final List<String> declinedPermissions;

  FacebookAccessToken.fromMap(Map<String, dynamic> map)
      : token = map['token'] as String,
        userId = map['userId'] as String,
        expires = DateTime.fromMillisecondsSinceEpoch(
            map['expires'] as int > 8640000000000000
                ? 8640000000000000
                : map['expires'] as int,
            isUtc: true),
        permissions = (map['permissions'] as List).cast<String>(),
        declinedPermissions =
            (map['declinedPermissions'] as List).cast<String>();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expires': expires.millisecondsSinceEpoch,
      'permissions': permissions,
      'declinedPermissions': declinedPermissions,
    };
  }

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
