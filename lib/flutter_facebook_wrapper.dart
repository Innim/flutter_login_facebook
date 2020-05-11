import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

enum FacebookLoginStatus { Success, Cancel, Error }

class FlutterFacebookWrapper {
  static const String _logInMethod = "logIn";
  static const String _logOutMethod = "logOut";
  static const String _getAccessTokenMethod = "getAccessToken";
  static const String _getUserProfileMethod = "getUserProfile";
  static const String _permissionsArg = "permissions";
  static const MethodChannel _channel =
      const MethodChannel('flutter_facebook_wrapper');

  Future<FacebookAccessToken> get accessToken async {
    final Map<dynamic, dynamic> tokenData =
        await _channel.invokeMethod(_getAccessTokenMethod);

    return tokenData != null
        ? FacebookAccessToken.fromMap(tokenData.cast<String, dynamic>())
        : null;
  }

  Future<bool> get isLoggedIn async {
    var token = await accessToken;

    return token != null && DateTime.now().isBefore(token.expires);
  }

  Future<FacebookUserProfile> get userProfile async {
    final Map<dynamic, dynamic> profileData =
        await _channel.invokeMethod(_getUserProfileMethod);

    return profileData != null
        ? FacebookUserProfile.fromMap(profileData.cast<String, dynamic>())
        : null;
  }

  Future<FacebookLoginResult> logIn(List<String> permissions) async {
    if (!await isLoggedIn) {
      final Map<dynamic, dynamic> loginResultData = await _channel
          .invokeMethod(_logInMethod, {_permissionsArg: permissions});
      return FacebookLoginResult.fromMap(
          loginResultData.cast<String, dynamic>());
    } else {
      return FacebookLoginResult(
          FacebookLoginStatus.Success, await accessToken);
    }
  }

  Future<void> logOut() => _channel.invokeMethod(_logOutMethod);
}

/// Профиль пользователя.
class FacebookUserProfile {
  final String userId;
  final String name;
  final String firstName;
  final String middleName;
  final String lastName;

  FacebookUserProfile.fromMap(Map<String, dynamic> map)
      : userId = map['userId'],
        name = map['name'],
        firstName = map['firstName'],
        middleName = map['middleName'],
        lastName = map['lastName'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacebookUserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          name == other.name &&
          firstName == other.firstName &&
          middleName == other.middleName &&
          lastName == other.lastName;

  @override
  int get hashCode =>
      userId.hashCode ^
      name.hashCode ^
      firstName.hashCode ^
      middleName.hashCode ^
      lastName.hashCode;
}

/// Токен.
class FacebookAccessToken {
  final String token;
  final String userId;
  final DateTime expires;
  final List<String> permissions;

  FacebookAccessToken.fromMap(Map<String, dynamic> map)
      : token = map['token'],
        userId = map['userId'],
        expires =
            DateTime.fromMillisecondsSinceEpoch(map['expires'], isUtc: true),
        permissions = map['permissions'].cast<String>();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'userId': userId,
      'expires': expires.millisecondsSinceEpoch,
      'permissions': permissions
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
          const IterableEquality().equals(permissions, other.permissions);

  @override
  int get hashCode =>
      token.hashCode ^
      userId.hashCode ^
      expires.hashCode ^
      permissions.hashCode;
}

/// Результат входа.
class FacebookLoginResult {
  final FacebookLoginStatus status;
  final FacebookAccessToken accessToken;

  FacebookLoginResult(this.status, this.accessToken)
      : assert(status != null),
        assert(accessToken != null);

  FacebookLoginResult.fromMap(Map<String, dynamic> map)
      : status = _parseStatus(map['status']),
        accessToken = map['accessToken'] != null
            ? FacebookAccessToken.fromMap(
                map['accessToken'].cast<String, dynamic>())
            : null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.toString().split('.').last,
      'accessToken': accessToken
    };
  }

  static FacebookLoginStatus _parseStatus(String status) {
    switch (status) {
      case 'Success':
        return FacebookLoginStatus.Success;
      case 'Cancel':
        return FacebookLoginStatus.Cancel;
      case 'Error':
        return FacebookLoginStatus.Error;
    }

    throw StateError('Invalid status: $status');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacebookLoginResult &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          accessToken == other.accessToken;

  @override
  int get hashCode => status.hashCode ^ accessToken?.hashCode ?? 0;
}
