import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'types.dart';

/// Login status.
enum FacebookLoginStatus { success, cancel, error }

/// Result for login request.
class FacebookLoginResult {
  final FacebookLoginStatus status;
  final FacebookAccessToken? accessToken;
  final FacebookError? error;

  FacebookLoginResult(this.status, FacebookAccessToken this.accessToken,
      {this.error});

  FacebookLoginResult.error({this.error})
      : status = FacebookLoginStatus.error,
        accessToken = null;

  FacebookLoginResult.fromMap(JsonData map)
      : status = _parseStatus(map['status'] as String),
        accessToken = map['accessToken'] != null
            ? FacebookAccessToken.fromMap(map['accessToken']!.castJsonData())
            : null,
        error = map['error'] != null
            ? FacebookError.fromMap(map['error']!.castJsonData())
            : null;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.toString().split('.').last,
      'accessToken': accessToken,
      'error': error?.toMap(),
    };
  }

  static FacebookLoginStatus _parseStatus(String status) {
    switch (status) {
      case 'Success':
        return FacebookLoginStatus.success;
      case 'Cancel':
        return FacebookLoginStatus.cancel;
      case 'Error':
        return FacebookLoginStatus.error;
    }

    throw StateError('Invalid status: $status');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FacebookLoginResult &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          accessToken == other.accessToken &&
          error == other.error;

  @override
  int get hashCode =>
      status.hashCode ^ (accessToken?.hashCode ?? 0) ^ (error?.hashCode ?? 0);

  @override
  String toString() =>
      'FacebookLoginResult(status: $status, accessToken: $accessToken, '
      'error: $error)';
}
