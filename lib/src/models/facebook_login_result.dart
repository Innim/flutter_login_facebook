import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_login_facebook/src/models/facebook_error.dart';

/// Login status.
enum FacebookLoginStatus { Success, Cancel, Error }

/// Result for login request.
class FacebookLoginResult {
  final FacebookLoginStatus status;
  final FacebookAccessToken accessToken;
  final FacebookError error;

  FacebookLoginResult(this.status, this.accessToken, {this.error})
      : assert(status != null),
        assert(accessToken != null);

  FacebookLoginResult.fromMap(Map<String, dynamic> map)
      : status = _parseStatus(map['status']),
        accessToken = map['accessToken'] != null
            ? FacebookAccessToken.fromMap(
                map['accessToken'].cast<String, dynamic>())
            : null,
        error = map['error'] != null
            ? FacebookError.fromMap(map['error'].cast<String, dynamic>())
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
          accessToken == other.accessToken &&
          error == other.error;

  @override
  int get hashCode =>
      status.hashCode ^ accessToken?.hashCode ?? 0 ^ error?.hashCode ?? 0;

  @override
  String toString() =>
      'FacebookLoginResult(status: $status, accessToken: $accessToken, error: $error)';
}
