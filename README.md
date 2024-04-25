# flutter_login_facebook

[![pub package](https://img.shields.io/pub/v/flutter_login_facebook)](https://pub.dartlang.org/packages/flutter_login_facebook)
![Analyze & Test](https://github.com/Innim/flutter_login_facebook/actions/workflows/dart.yml/badge.svg?branch=master)
[![innim lint](https://img.shields.io/badge/style-innim_lint-40c4ff.svg)](https://pub.dev/packages/innim_lint)

Flutter Plugin to login via Facebook.

Easily add Facebook login feature in your application. User profile information included.

## SDK version

Facebook SDK version, used in plugin:

* iOS: **17.0** ([CocoaPods](https://cocoapods.org/pods/FBSDKLoginKit))
* Android: **^17.0** ([Maven](https://search.maven.org/artifact/com.facebook.android/facebook-android-sdk))

## Minimum requirements

* iOS **12.0** and higher.
* Android **5.0** and newer (SDK **21**).

Also package require Android embedding v2. So if your project was create with Flutter pre 1.12 
you should [upgrade it](https://github.com/flutter/flutter/wiki/Upgrading-pre-1.12-Android-projects)

## Getting Started

To use this plugin:

 1. add `flutter_login_facebook` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/flutter_login_facebook#-installing-tab-);
 2. [setup android](#android);
 3. [setup ios](#ios);
 4. [additional Facebook app setup](#additional-facebook-app-setup);
 5. [use plugin in application](#usage-in-application).

See [Facebook Login documentation](https://developers.facebook.com/docs/facebook-login) for full information.

Also you can read the [article on Medium](https://medium.com/@greymag/add-facebook-login-in-your-flutter-app-5172b034aa7d) with detailed instructions.

If you have any troubles check out [Problem solving](#problem-solving) section.

### Android

Go to [Facebook Login for Android - Quickstart](https://developers.facebook.com/docs/facebook-login/android) page.

#### Select an App or Create a New App

You need to complete **Step 1**: [Select an App or Create a New App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#1--select-an-app-or-create-a-new-app).

Skip **Step 2** (Download the Facebook App) and **Step 3** (Integrate the Facebook SDK).

#### Edit Your Resources and Manifest

Complete **Step 4**: [Edit Your Resources and Manifest](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#manifest)

* Add values to `/android/app/src/main/res/values/strings.xml` (create file if it doesn't exist). 
You don't need to add `fb_login_protocol_scheme`, only `facebook_app_id` and `facebook_client_token`:
```xml
<string name="facebook_app_id">YOUR_APP_ID</string>
<string name="facebook_client_token">YOUR_CLIENT_ACCESS_TOKEN</string>
```
  * How to get your Client Access Token:
    1. Sign into your [developer account](https://developers.facebook.com/).
    2. On the [Apps page](https://developers.facebook.com/apps/), select an app to open the dashboard for that app.
    3. On the **Dashboard**, navigate to **Settings** > **Advanced** > **Security** > **Client token**.
* Make changes in `android/app/src/main/AndroidManifest.xml`:
  * Add a `meta-data` elements in section `application`:
```xml
<meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
<meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
```
  * Add a permission if not exist in root section (before or after `application`):
```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

See full `AndroidManifest.xml` in [example](example/android/app/src/main/AndroidManifest.xml).

#### Setup Facebook App

Complete **Step 5**: [Associate Your Package Name and Default Class with Your App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#5--associate-your-package-name-and-default-class-with-your-app).

1. Set `Package Name` - your package name for Android application (attribute `package` in `AndroidManifest.xml`).
2. Set `Default Activity Class Name` - your main activity class (with package). By default it would be `com.yourcompany.yourapp.MainActivity`.
3. Click "Save".

Complete **Step 6**: [Provide the Development and Release Key Hashes for Your App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#6--provide-the-development-and-release-key-hashes-for-your-app).

1. Generate Development and Release keys as described in the [documentation](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#6--provide-the-development-and-release-key-hashes-for-your-app). *Note:* if your application uses [Google Play App Signing](https://support.google.com/googleplay/android-developer/answer/7384423) then you should get certificate SHA-1 fingerprint from Google Play Console and convert it to base64
```
echo "{sha1key}" | xxd -r -p | openssl base64
```
2. Add generated keys in `Key Hashes`.
3. Click "Save".

⚠️ **Important!** You should add key hashes for every build variants. E.g. if you have CI/CD which build APK for testing
with it's own certificate (it may be auto generated debug certificate or some another) than you should add it's key too.

In the next **Step 7** [Enable Single Sign On for Your App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#7--enable-single-sign-on-for-your-app) you can enable Single Sing On if you want to.

And that's it for Android.

### iOS

Go to [Facebook Login for iOS - Quickstart](https://developers.facebook.com/docs/facebook-login/ios).

#### Select an App or Create a New App

You need to complete **Step 1**: [Select an App or Create a New App](https://developers.facebook.com/docs/facebook-login/ios?locale=en_US#1--select-an-app-or-create-a-new-app). If you've created an app during an Android setup than use it.

Skip **Step 2** (Set up Your Development Environment) and **Step 3** (Integrate the Facebook SDK).

#### Register and Configure Your App with Facebook

Complete **Step 3**: [Register and Configure Your App with Facebook](https://developers.facebook.com/docs/facebook-login/ios?locale=en_US#3--register-and-configure-your-app-with-facebook).

1. Add your Bundle Identifier - set `Bundle ID` (you can find it in Xcode: Runner - Target Runner - General, section `Identity`, field `Bundle Identifier`) and click "Save".
2. Enable Single Sign-On for Your App if you need it and click "Save".

#### Configure Your Project

Complete **Step 4**: [Configure Your Project](https://developers.facebook.com/docs/facebook-login/ios?locale=en_US#4--configure-your-project).

Configure `Info.plist` (`ios/Runner/Info.plist`):

1. In Xcode right-click on `Info.plist`, and choose `Open As Source Code`.
2. Copy and paste the following XML snippet into the body of your file (`<dict>...</dict>`),
replacing `[APP_ID]` with Facebook application id, 
`[CLIENT_TOKEN]` value found under **Settings** > **Advanced** > **Client Token** in your App Dashboard
and `[APP_NAME]` with Facebook application name
(you can copy prepared values from [Step 4](https://developers.facebook.com/docs/facebook-login/ios?locale=en_US#4--configure-your-project) in Facebook Quickstart).
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
  <key>CFBundleURLSchemes</key>
  <array>
    <string>fb[APP_ID]</string>
  </array>
  </dict>
</array>
<key>FacebookAppID</key>
<string>[APP_ID]</string>
<key>FacebookClientToken</key>
<string>[CLIENT_TOKEN]</string>
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>
```
3. Also add to `Info.plist` body (`<dict>...</dict>`):
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fb-messenger-share-api</string>
</array>
```

See full `Info.plist` in [example](example/ios/Runner/Info.plist).

⚠️ **NOTE.** Check if you already have `CFBundleURLTypes` or `LSApplicationQueriesSchemes` keys in your `Info.plist`. If you have, you should merge their values, instead of adding a duplicate key.

Skip **Step 5** (Connect Your App Delegate) and all the rest.

And that's it for iOS.

#### Additional information

##### Privacy Manifest for App Store Review requirements

Additional guidance for developers from Facebook [documentation](https://developers.facebook.com/docs/ios/):

* Our Privacy Manifest only provides information collected by default and the SDKs that depend on the Core SDK for functionality may restate the data usage details of the Core SDK. Some app developers may choose to send us more or less information in code, or via the Events Manager or through Advanced matching functionality. These developers will need to provide details around additional data usage details in their Privacy Manifest or App Store Privacy Labels in accordance with their own practices. Refer to the following article for more information on additional data that may be sent by developers through Meta’s SDKs.
* Note that we do not attempt to associate all collected data with Meta users.
* We have pre-populated the tracking domain field for the FB SDK in the Privacy Manifest to help ensure that our services continue to function properly. We do not advise manually adding domains. Listing “www.facebook.com” or subdomains of “facebook.com” in the tracking domain field of a Privacy Manifest may break functionality.

**Note:** Developers can find additional details around the tracking domain field in the Privacy Manifests for Meta SDKs. What is pre-populated in the tracking domain field is intended to receive traffic when a user has provided AppTrackingTransparency (ATT) permission to the app. If our check determines that a request or event from an iOS14.5+ device lacks ATT permission, then usage of such data will be restricted and we will use privacy preserving methods (like those available in [Aggregated Event Measurement]()) to remove or combine information before delivering or measuring ads.

### Additional Facebook app setup

Go to [My App](https://developers.facebook.com/apps/) on Facebook and select your application.

#### Icon 

You should add the **App Icon** (in Settings -> Basic) to let users see
your application icon instead of the default icon when they attempt to log in.

#### Add store IDs

In Setting -> Basic -> iOS fill up field "iPhone Store ID" ("iPad Store ID").

#### Permissions and features

To use the profile data, you must raise the access level for the "public_profile" and "email" functions to "Advanced Access" in `App Review` -> `Permissions and features`  (Administrator rights required).

#### Optional settings

You may want to change some other settings.
For example *Display Name*, *Contact Email*, *Category*, etc.

#### Enable application 

By default, your application has the status "In development". 

![](https://raw.githubusercontent.com/Innim/flutter_login_facebook/master/readme_images/fb_status_in_development.png)

You should enable application before log in feature goes public.

Facebook will show a warning if your application is not fully set up. 
For example, you may need to provide a **Privacy Policy**. You can use your
Privacy Policy from Google Play/App Store.

### Usage in application

You can:
- log in via Facebook;
- get access token;
- get user profile;
- get user profile image url;
- get user email (if has permissions);
- check if logged in;
- log out.

Sample code:

```dart
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

// Create an instance of FacebookLogin
final fb = FacebookLogin();

// Log in
final res = await fb.logIn(permissions: [
  FacebookPermission.publicProfile,
  FacebookPermission.email,
]);

// Check result status
switch (res.status) {
  case FacebookLoginStatus.success:
    // Logged in
    
    // Send access token to server for validation and auth
    final FacebookAccessToken accessToken = res.accessToken;
    print('Access token: ${accessToken.token}');

    // Get profile data
    final profile = await fb.getUserProfile();
    print('Hello, ${profile.name}! You ID: ${profile.userId}');

    // Get user profile image url
    final imageUrl = await fb.getProfileImageUrl(width: 100);
    print('Your profile image: $imageUrl');

    // Get email (since we request email permission)
    final email = await fb.getUserEmail();
    // But user can decline permission
    if (email != null)
      print('And your email is $email');

    break;
  case FacebookLoginStatus.cancel:
    // User cancel log in
    break;
  case FacebookLoginStatus.error:
    // Log in failed
    print('Error while log in: ${res.error}');
    break;
}

```
#### ⚠️ WARNING! Important Changes in SDK v17.0 for iOS (plugin version 2.0.0)

With the release of SDK v17.0 for iOS, there are significant changes to the login behavior and token validation process:

1. **Limited Login Mode**: If the user has not granted the AdvertiserTracking permission 
([Apple documentation](https://developer.apple.com/documentation/apptrackingtransparency), [Facebook documentation](https://www.facebook.com/business/help/365087497929660)), 
the login process will now enter a Limited Login mode. This mode is indicated by the `isLimitedLogin` field in the `AccessToken` object.
2. **Access Token in Limited Login Mode**: In Limited Login mode, the access token is not valid and will **fail server-side verification**. 
Additionally, it will not permit Graph API requests. For Limited Login you need to validate OIDC token.
3. **OIDC Token Validation**: the OIDC Token will be available in the new `authenticationToken` field in the `AccessToken`. 
In Limited Login mode you should validate this token for the server-side verification. 
Learn more about token validation in the [documentation](https://developers.facebook.com/docs/facebook-login/limited-login/token/validating).
4. **Profile Image URL**: In Limited Login mode, the `getProfileImageUrl()` method will ignore size parameters. 
This limitation arises because we can't execute API calls, thus only a 100x100 image from the JWT authentication token can be used.

For detailed insights into these changes, please refer to the [blog post](https://developers.facebook.com/blog/post/2024/03/28/changes-made-to-fb-login-sdk/) and the documentation on [Limited Login](https://developers.facebook.com/docs/facebook-login/limited-login).

#### [Android] Express login

Express Login helps users log in with their Facebook account across devices and platforms. If a person has logged into your app before on any platform, you can use Express Login to log them in with their Facebook account on Android, instead of asking for them to select a login method, which sometimes resulted in creating duplicate accounts or even failing to log in at all.

See [documentation](https://developers.facebook.com/docs/facebook-login/android/#expresslogin).

Example: 

```dart
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

// Create an instance of FacebookLogin
final fb = FacebookLogin();

// Log in
final res = await fb.expressLogin();

if (res.status == FacebookLoginStatus.success) {
  final FacebookAccessToken accessToken = res.accessToken;
  print('Access token: ${accessToken.token}');
}
```

**Only for Android.**

If you targets Android 11 or higher, you should add

```xml
<queries>
  <package android:name="com.facebook.katana" />
</queries> 
```

in root element of your manifest `android/app/src/main/AndroidManifest.xml`. 
See [Package visibility in Android 11](https://medium.com/androiddevelopers/package-visibility-in-android-11-cc857f221cd9) for details.

## Problem solving

### Android 

#### Missing attribute

You get error like this:

```
Missing 'package' key attribute on element package at ...
```

This issue happens for the combination of:

- Using Android-SDK's API level 31 (or later),
- With old Gradle version(s).

Quote:
```
Basically, updating build-tools to 31 is not enough to support queries element (of manifest, added since Android 11+). Gradle needs to be updated, too.
```

Check your `com.android.tools.build:gradle` version in
`android/build.gradle`. It's should be 3.5.4 or higher.