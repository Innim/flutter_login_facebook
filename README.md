# flutter_login_facebook

Flutter Plugin to login via Facebook.

## SDK version

Facebook SDK version, used in pluging:

* iOS: **^7.0** ([CocoaPods](https://cocoapods.org/pods/FBSDKLoginKit))
* Android: **^7.0** ([Maven](https://search.maven.org/artifact/com.facebook.android/facebook-android-sdk/7.0.0/jar))

## Minimum requirements

* iOS **9.0** and higher.
* Android **4.1** and newer (SDK **16**).

## Getting Started

To use this plugin:

 1. add `flutter_login_facebook` as a [dependency in your pubspec.yaml file](https://pub.dev/packages/flutter_login_facebook#-installing-tab-);
 2. [setup android](#android);
See [Facebook Login documentation](https://developers.facebook.com/docs/facebook-login) for full information.

### Android

Go to [Facebook Login for Android - Quickstart](https://developers.facebook.com/docs/facebook-login/android).

#### Select an App or Create a New App

You need to complete **Step 1**: [Select an App or Create a New App](https://developers.facebook.com/docs/facebook-login/android#1--select-an-app-or-create-a-new-app).

Skip **Step 2** (Download the Facebook App) and **Step 3** (Integrate the Facebook SDK).

#### Edit Your Resources and Manifest

Complete **Step 4**: [Edit Your Resources and Manifest](https://developers.facebook.com/docs/facebook-login/android#manifest)

* Add values to `/android/app/src/main/res/values/strings.xml` (create file if not exist)
* Add `meta-data` element and activities in `android/app/src/main/AndroidManifest.xml`, section `application`:

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

Complete **Step 5**: [Associate Your Package Name and Default Class with Your App](https://developers.facebook.com/docs/facebook-login/android#5--associate-your-package-name-and-default-class-with-your-app).

1. Set `Package Name` - your package name for Android application (attribute `package` in `AndroidManifest.xml`).
2. Set `Default Activity Class Name` - your main activity class (with package). By default it would be `com.yourcompany.yourapp.MainActivity`.
3. Click "Save".

Complete **Step 6**: [Provide the Development and Release Key Hashes for Your App](https://developers.facebook.com/docs/facebook-login/android#6--provide-the-development-and-release-key-hashes-for-your-app).

1. Generate Development and Release key as described in [documentation](https://developers.facebook.com/docs/facebook-login/android#6--provide-the-development-and-release-key-hashes-for-your-app). *Note:* if your application uses [Google Play App Signing](https://support.google.com/googleplay/android-developer/answer/7384423) than you should get certificate SHA-1 fingerprint from Google Play Console and convert it to base64
```
echo "{sha1key}" | xxd -r -p | openssl base64
```
2. Add generated keys in `Key Hashes`.
3. Click "Save".

In next **Step 7** [Enable Single Sign On for Your App](https://developers.facebook.com/docs/facebook-login/android#7--enable-single-sign-on-for-your-app) you can enable Single Sing On if you want to.

And that's it for Android.
