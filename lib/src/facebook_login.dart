import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'facebook_plugin_channel.dart';
import 'models/types.dart';
import 'plugin_method.dart';

/// Class for implementing login via Facebook.
class FacebookLogin {
  static const _permissionsArg = 'permissions';

  static const _widthArg = 'width';
  static const _heightArg = 'height';

  static final _channel = FacebookPluginChannel();

  /// If `true` all requests and results will be printed in console.
  final bool debug;

  FacebookLogin({this.debug = false}) {
    if (debug) sdkVersion.then((v) => _log('SDK version: $v'));
  }

  Future<FacebookAccessToken?> get accessToken async {
    final tokenData = await _invoke(PluginMethod.getAccessToken);

    return tokenData != null ? FacebookAccessToken.fromMap(tokenData) : null;
  }

  /// Returns currently used Facebook SDK.
  Future<String> get sdkVersion async {
    final res =
        await _channel.invokeMethodNow<String>(PluginMethod.getSdkVersion);
    return res ?? 'n/a';
  }

  Future<bool> get isLoggedIn async {
    final token = await accessToken;
    return _isLoggedIn(token);
  }

  /// Get user profile information.
  ///
  /// If not logged in or error during request than return `null`.
  Future<FacebookUserProfile?> getUserProfile() async {
    if (await isLoggedIn == false) {
      if (debug) _log('Not logged in. User profile is null');
      return null;
    }

    try {
      final profileData = await _invoke(PluginMethod.getUserProfile);

      if (debug) _log('User profile: $profileData');

      if (profileData != null) {
        return FacebookUserProfile.fromMap(profileData);
      }
    } on PlatformException catch (e) {
      if (debug) _log('Get profile error: $e');
    }
    return null;
  }

  /// Get user profile image url.
  ///
  /// If not logged in or error during request than return `null`.
  ///
  /// [width] of picture is required, but [height] is optional,
  /// and by default is equals to [width].
  ///
  /// In Limited Login mode image sizes are **ignored**.
  /// This is because we can't make Graph API requests in Limited Login mode,
  /// so this method always return basic profile image from AuthenticationToken.
  ///
  /// Also in Limited Login mode Url have expiration time and can stop
  /// working after a while. To get new URL user should login again.
  Future<String?> getProfileImageUrl({required int width, int? height}) async {
    if (await isLoggedIn == false) {
      if (debug) _log('Not logged in. Profile image url is null');
      return null;
    }

    try {
      final url = await _channel.invokeMethod<String>(
        PluginMethod.getProfileImageUrl,
        {
          _widthArg: width,
          _heightArg: height ?? width,
        },
      );

      if (debug) _log('Profile image url: $url');

      return url;
    } on PlatformException catch (e) {
      if (debug) _log('Get profile image url error: $e');
    }

    return null;
  }

  /// Get user email.
  ///
  /// Attention! User need to be logged in with
  /// accepted [FacebookPermission.email] permission.
  ///
  /// If not logged in, decline [FacebookPermission.email] permission
  /// or error during request occurred, than returns `null`.
  Future<String?> getUserEmail() async {
    final token = await accessToken;
    if (!_isLoggedIn(token)) {
      if (debug) _log('Not logged in. Email is null');
      return null;
    }

    if (!token!.permissions.contains(FacebookPermission.email.name)) {
      if (debug) _log('User did not accept `email` permission. Email is null');
      return null;
    }

    try {
      final email =
          await _channel.invokeMethod<String>(PluginMethod.getUserEmail);

      if (debug) _log('User email: $email');
      return email;
    } on PlatformException catch (e) {
      if (debug) _log('Get user email error: $e');
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
      List<String> customPermissions = const []}) async {
    final permissionsArg = permissions.map((e) => e.name).toList();
    if (customPermissions.isNotEmpty) permissionsArg.addAll(customPermissions);

    if (debug) _log('Log In with permissions $permissionsArg');
    return _invokeLoginMethod(
        PluginMethod.logIn, {_permissionsArg: permissionsArg});
  }

  /// Start Express log in Facebook process
  ///
  /// Express Login is an **[Android only option](https://developers.facebook.com/docs/facebook-login/android/#expresslogin)**
  ///
  /// If Login is successful, returns [FacebookLoginResult] with Success Status.
  /// ```
  /// var fbUser = await FacebookLogin().expressLogin();
  /// ```
  Future<FacebookLoginResult> expressLogin() async {
    assert(Platform.isAndroid);
    if (debug) _log('Trying to expressLogin');
    return _invokeLoginMethod(PluginMethod.expressLogIn);
  }

  Future<void> logOut() {
    if (debug) _log('Log Out');
    return _channel.invokeMethod(PluginMethod.logOut);
  }

  bool _isLoggedIn(FacebookAccessToken? token) =>
      token != null && DateTime.now().isBefore(token.expires);

  Future<FacebookLoginResult> _invokeLoginMethod(PluginMethod method,
      [Map<String, Object>? arguments]) async {
    final loginResultData = await _invoke(method, arguments);

    if (debug) _log('Result: $loginResultData');
    return loginResultData != null
        ? FacebookLoginResult.fromMap(loginResultData)
        : FacebookLoginResult.error();
  }

  Future<JsonData?> _invoke(PluginMethod method, [Object? arguments]) async =>
      (await _channel.invokeMethod<JsonRawData>(method, arguments))
          ?.cast<String, Object?>();

  void _log(String message) {
    if (debug) debugPrint('[FB] $message');
  }
}
