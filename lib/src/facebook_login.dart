import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_login_facebook/src/models/facebook_permission.dart';

/// Class for implementing login via Facebook.
class FacebookLogin {
  // Methods
  static const _methodLogIn = "logIn";
  static const _methodLogOut = "logOut";
  static const _methodGetAccessToken = "getAccessToken";
  static const _methodGetUserProfil = "getUserProfile";
  static const _methodGetSdkVersion = "getSdkVersion";

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

  /// Returns currently used Facebook SDK.
  Future<String> get sdkVersion async {
    final String res = await _channel.invokeMethod(_methodGetSdkVersion);
    return res;
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

  /// Start log in Facebook process.
  ///
  /// [permissions] Array of read permissions. Default: `[FacebookPermission.publicProfile]`
  /// If required permission is not in enum [FacebookPermission], than use [customPermissions].
  Future<FacebookLoginResult> logIn(
      {List<FacebookPermission> permissions = const [
        FacebookPermission.publicProfile
      ],
      List<String> customPermissions}) async {
    assert(permissions != null);

    final permissionsArg = permissions.map((e) => e.name).toList();
    if (customPermissions != null) permissionsArg.addAll(customPermissions);

    final Map<dynamic, dynamic> loginResultData = await _channel
        .invokeMethod(_methodLogIn, {_permissionsArg: permissionsArg});
    return FacebookLoginResult.fromMap(loginResultData.cast<String, dynamic>());
  }

  Future<void> logOut() => _channel.invokeMethod(_methodLogOut);
}
