import 'dart:math';

import 'package:list_ext/list_ext.dart';

import 'types.dart';

int _maxMillisecondsSinceEpoch = 8640000000000000;

/// Facebook access token.
class FacebookAccessToken {
  /// Access token.
  ///
  /// For Limited Login, this value will be non null,
  /// but any verification checks will fail, as will requests to the Graph API
  ///
  /// See [authenticationToken] and [isLimitedLogin].
  final String token;
  final String userId;
  final DateTime expires;
  final List<String> permissions;
  final List<String> declinedPermissions;

  /// OIDC Token.
  ///
  /// You need to verify this access token for Limited Login.
  ///
  /// This token is created at login and is not updated afterward,
  /// so it may contain a date that has expired before the current date.
  ///
  /// Also any information in it is also up to date at the time of logging in.
  ///
  /// https://developers.facebook.com/docs/facebook-login/limited-login/token
  final String? authenticationToken;

  /// true if login was in Limited Login mode.
  ///
  /// https://developers.facebook.com/docs/facebook-login/limited-login
  ///
  /// On iOS if user didn't provide AdvertiserTracking permission,
  /// login will be in Limited Login mode, even if we want a Standard Login.
  final bool isLimitedLogin;

  FacebookAccessToken.fromMap(JsonData map)
      : token = map['token'] as String,
        userId = map['userId'] as String,
        expires = DateTime.fromMillisecondsSinceEpoch(
            min(_maxMillisecondsSinceEpoch, map['expires'] as int),
            isUtc: true),
        permissions = (map['permissions'] as List).cast<String>(),
        declinedPermissions =
            (map['declinedPermissions'] as List).cast<String>(),
        authenticationToken = map['authenticationToken'] as String?,
        isLimitedLogin = _parseBool(map['isLimitedLogin']);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expires': expires.millisecondsSinceEpoch,
      'permissions': permissions,
      'declinedPermissions': declinedPermissions,
      'authenticationToken': authenticationToken,
      'isLimitedLogin': isLimitedLogin,
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
          authenticationToken == other.authenticationToken &&
          isLimitedLogin == other.isLimitedLogin &&
          permissions.isUnorderedEquivalent(other.permissions) &&
          declinedPermissions.isUnorderedEquivalent(other.declinedPermissions);

  @override
  int get hashCode =>
      token.hashCode ^
      userId.hashCode ^
      expires.hashCode ^
      permissions.hashCode ^
      declinedPermissions.hashCode ^
      authenticationToken.hashCode ^
      isLimitedLogin.hashCode;

  @override
  String toString() {
    return 'FacebookAccessToken(token: $token, userId: $userId, '
        'expires: $expires, permissions: $permissions, '
        'declinedPermissions: $declinedPermissions, '
        'authenticationToken: $authenticationToken, '
        'isLimitedLogin: $isLimitedLogin'
        ')';
  }
}

bool _parseBool(Object? value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    return value.toLowerCase() == 'true' || value.toLowerCase() == 'yes';
  }
  return false;
}
