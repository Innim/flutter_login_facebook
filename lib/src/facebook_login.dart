import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

/// Class for implementing login via Facebook.
class FacebookLogin {
  static const String _logInMethod = "logIn";
  static const String _logOutMethod = "logOut";
  static const String _getAccessTokenMethod = "getAccessToken";
  static const String _getUserProfileMethod = "getUserProfile";
  static const String _permissionsArg = "permissions";
  static const MethodChannel _channel =
      const MethodChannel('flutter_login_facebook');

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
