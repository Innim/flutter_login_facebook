import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

/// Class for implementing login via Facebook.
class FacebookLogin {
  // Methods
  static const _methodLogIn = "logIn";
  static const _methodLogOut = "logOut";
  static const _methodGetAccessToken = "getAccessToken";
  static const _methodGetUserProfil = "getUserProfile";

  static const _permissionsArg = "permissions";

  static const MethodChannel _channel =
      const MethodChannel('flutter_login_facebook');

  Future<FacebookAccessToken> get accessToken async {
    final Map<dynamic, dynamic> tokenData =
        await _channel.invokeMethod(_methodGetAccessToken);

    return tokenData != null
        ? FacebookAccessToken.fromMap(tokenData.cast<String, dynamic>())
        : null;
  }

  Future<bool> get isLoggedIn async {
    final token = await accessToken;
    return token != null && DateTime.now().isBefore(token.expires);
  }

  Future<FacebookUserProfile> get userProfile async {
    if (await isLoggedIn == false) return null;

    final Map<dynamic, dynamic> profileData =
        await _channel.invokeMethod(_methodGetUserProfil);

    return profileData != null
        ? FacebookUserProfile.fromMap(profileData.cast<String, dynamic>())
        : null;
  }

  Future<FacebookLoginResult> logIn(
      {List<String> permissions = const []}) async {
    assert(permissions != null);
    if (!await isLoggedIn) {
      final Map<dynamic, dynamic> loginResultData = await _channel
          .invokeMethod(_methodLogIn, {_permissionsArg: permissions});
      return FacebookLoginResult.fromMap(
          loginResultData.cast<String, dynamic>());
    } else {
      return FacebookLoginResult(
          FacebookLoginStatus.Success, await accessToken);
    }
  }

  Future<void> logOut() => _channel.invokeMethod(_methodLogOut);
}
