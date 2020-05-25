import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  /// If `true` all requests and results will be printed in console.
  final bool debug;

  FacebookLogin({this.debug = false}) : assert(debug != null) {
    if (debug) sdkVersion.then((v) => _log('SDK version: $v'));
  }

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

  /// Get user profile information.
  ///
  /// If not logged in or error during request than return `null`.
  Future<FacebookUserProfile> getUserProfile() async {
    if (await isLoggedIn == false) {
      if (debug) _log('Not logged in. User profile is null');
      return null;
    }

    try {
      final Map<dynamic, dynamic> profileData =
          await _channel.invokeMethod(_methodGetUserProfil);

      if (debug) _log('User profile: $profileData');

      if (profileData != null)
        return FacebookUserProfile.fromMap(profileData.cast<String, dynamic>());
    } on PlatformException catch (e) {
      if (debug) _log('Get profile error: $e');
    }
    return null;
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

    if (debug) _log('Log In with permissions $permissionsArg');
    final Map<dynamic, dynamic> loginResultData = await _channel
        .invokeMethod(_methodLogIn, {_permissionsArg: permissionsArg});

    if (debug) _log('Result: $loginResultData');
    return FacebookLoginResult.fromMap(loginResultData.cast<String, dynamic>());
  }

  Future<void> logOut() {
    if (debug) _log('Log Out');
    return _channel.invokeMethod(_methodLogOut);
  }

  void _log(String message) {
    if (debug) debugPrint('[FB] $message');
  }
}
