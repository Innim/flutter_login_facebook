# flutter_login_facebook

[![pub package](https://img.shields.io/pub/v/flutter_login_facebook)](https://pub.dartlang.org/packages/flutter_login_facebook)

Flutter Plugin to login via Facebook.

Easily add Facebook login feature in your application. User profile information included.

## SDK version

Facebook SDK version, used in plugin:

* iOS: **^7.0** ([CocoaPods](https://cocoapods.org/pods/FBSDKLoginKit))
* Android: **^7.0** ([Maven](https://search.maven.org/artifact/com.facebook.android/facebook-android-sdk/7.0.0/jar))

## Minimum requirements

* iOS **9.0** and higher.
* Android **4.1** and newer (SDK **16**).

## Getting Started

To use this plugin:

 1. add `flutter_login_facebook` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/flutter_login_facebook#-installing-tab-);
 2. [setup android](#android);
 3. [setup ios](#ios);
 4. [additional Facebook app setup](#additional-facebook-app-setup);
 5. [use plugin in application](#usage-in-application).

See [Facebook Login documentation](https://developers.facebook.com/docs/facebook-login) for full information.

Also you can read the [article on Medium](https://medium.com/@greymag/add-facebook-login-in-your-flutter-app-5172b034aa7d) with detailed instructions.

### Android

Go to [Facebook Login for Android - Quickstart](https://developers.facebook.com/docs/facebook-login/android) page.

#### Select an App or Create a New App

You need to complete **Step 1**: [Select an App or Create a New App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#1--select-an-app-or-create-a-new-app).

Skip **Step 2** (Download the Facebook App) and **Step 3** (Integrate the Facebook SDK).

#### Edit Your Resources and Manifest

Complete **Step 4**: [Edit Your Resources and Manifest](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#manifest)

* Add values to `/android/app/src/main/res/values/strings.xml` (create file if it doesn't exist)
* Add a `meta-data` element and activities to `android/app/src/main/AndroidManifest.xml`, section `application`:

```xml
    <meta-data android:name="com.facebook.sdk.ApplicationId" 
        android:value="@string/facebook_app_id"/>
    
    <activity android:name="com.facebook.FacebookActivity"
        android:configChanges=
                "keyboard|keyboardHidden|screenLayout|screenSize|orientation"
        android:label="@string/app_name" />
    <activity
        android:name="com.facebook.CustomTabActivity"
        android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="@string/fb_login_protocol_scheme" />
        </intent-filter>
    </activity>
```

See full `AndroidManifest.xml` in [example](example/android/app/src/main/AndroidManifest.xml).

#### Setup Facebook App

Complete **Step 5**: [Associate Your Package Name and Default Class with Your App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#5--associate-your-package-name-and-default-class-with-your-app).

1. Set `Package Name` - your package name for Android application (attribute `package` in `AndroidManifest.xml`).
2. Set `Default Activity Class Name` - your main activity class (with package). By default it would be `com.yourcompany.yourapp.MainActivity`.
3. Click "Save".

Complete **Step 6**: [Provide the Development and Release Key Hashes for Your App](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#6--provide-the-development-and-release-key-hashes-for-your-app).

1. Generate Development and Release keys as described in the [documentation](https://developers.facebook.com/docs/facebook-login/android?locale=en_US#6--provide-the-development-and-release-key-hashes-for-your-app). *Note:* if your application uses [Google Play App Signing](https://support.google.com/googleplay/android-developer/answer/7384423) than you should get certificate SHA-1 fingerprint from Google Play Console and convert it to base64
```
echo "{sha1key}" | xxd -r -p | openssl base64
```
2. Add generated keys in `Key Hashes`.
3. Click "Save".

⚠️ **Important!** You should add key hashes for every build variants. E.g. if you have CI/CD which build APK for testing
with it's own cerificate (it may be auto generated debug cetificate or some another) than you should add it's key too.

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
replacing `[APP_ID]` with Facebook application id and `[APP_NAME]` with Facebook application name
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
<key>FacebookDisplayName</key>
<string>[APP_NAME]</string>
```
3. Also add to `Info.plist` body (`<dict>...</dict>`):
```xml
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>fbapi</string>
  <string>fbapi20130214</string>
  <string>fbapi20130410</string>
  <string>fbapi20130702</string>
  <string>fbapi20131010</string>
  <string>fbapi20131219</string>
  <string>fbapi20140410</string>
  <string>fbapi20140116</string>
  <string>fbapi20150313</string>
  <string>fbapi20150629</string>
  <string>fbapi20160328</string>
  <string>fbauth</string>
  <string>fb-messenger-share-api</string>
  <string>fbauth2</string>
  <string>fbshareextension</string>
</array>
```

See full `Info.plist` in [example](example/ios/Runner/Info.plist).

⚠️ **NOTE.** Check if you already have `CFBundleURLTypes` or `LSApplicationQueriesSchemes` keys in your `Info.plist`. If you have, you should merge their values, instead of adding a duplicate key.

Skip **Step 5** (Connect Your App Delegate) and all the rest.

And that's it for iOS.

### Additional Facebook app setup

Go to [My App](https://developers.facebook.com/apps/) on Facebook and select your application.

#### Icon 

You should add the **App Icon** (in Settings -> Basic) to let users see
your application icon instead of the default icon when they attempt to log in.

#### Add store IDs

In Setting -> Basic -> iOS fill up field "iPhone Store ID" ("iPad Store ID").

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
  case FacebookLoginStatus.Success:
    // Logged in
    
    // Send this access token to server for validation and auth
    final accessToken = res.accessToken;
    // Send access token to server for validation and auth
    final FacebookAccessToken accessToken = res.accessToken;
    print('Access token: ${accessToken.token}');

    // Get profile data
    final profile = await fb.getUserProfile();
    print('Hello, ${profile.name}! You ID: ${profile.userId}');

    // Get email (since we request email permission)
    final email = await fb.getUserEmail();
    // But user can decline permission
    if (email != null)
      print('And your email is $email');

    break;
  case FacebookLoginStatus.Cancel:
    // User cancel log in
    break;
  case FacebookLoginStatus.Error:
    // Log in failed
    print('Error while log in: ${res.error}');
    break;
}

```