# Migration guides

## Upgrade to 3.0

Facebook SDK upgraded to 18.0.3 on iOS and 18.1.3 on Android.

### Flutter and Dart

- Update your project to Flutter **3.38.0** or newer.

### Android

- Update `minSdkVersion` to **24** if your app still uses a lower value.
- If your Android project still uses the old pre-plugin-DSL Gradle setup, migrate it to the current Flutter/Gradle configuration before upgrading.

### iOS

- Update minimum deployment target to iOS **13** if you have a lower version now.
- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies.
- Also `flutter clean` may be required.

### Potential issues after update

#### iOS build fails with Swift compiler errors

If the iOS build fails after upgrading to `3.0.0` and the errors mention Facebook SDK API mismatches such as:

- incorrect argument labels around `ApplicationDelegate`;
- missing members on `Profile`;
- `LoginConfiguration` initializer or `LoginManager.logIn` not found;

For example, you may see errors like:

- `Incorrect argument label in call (have '_:didFinishLaunchingWithOptions:', expected '_:continue:')`
- `Type 'Profile' has no member 'current'`
- `'LoginConfiguration' cannot be constructed because it has no accessible initializers`
- `Value of type 'LoginManager' has no member 'logIn'`

then the most likely cause is an outdated Xcode version.

Solution: update Xcode to version **26** and rebuild the project.

#### iOS build fails with sandbox `rsync` error

If Xcode build fails with an error similar to:

- `Error (Xcode): Sandbox: rsync(...) deny(1) file-read-data`

then disable user script sandboxing for the iOS target.

Solution: set `ENABLE_USER_SCRIPT_SANDBOXING` to `NO` in Xcode Build Settings.

## Upgrade to 2.0.1

Facebook SDK upgraded to 17.0.2 version.

### iOS

- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 2.0

Facebook SDK upgraded to 17.0 version.

### iOS

- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.9

Facebook SDK upgraded to 16.2 version.

### iOS

- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.8

Facebook SDK upgraded to 16 version.

### iOS

- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.7

Facebook SDK upgraded to 15.1 version.

### Android 

- Update `minSdkVersion` in `android/app/build.gradle` to **21** if you have smaller version before.

### iOS

- Update minimum deployment target to iOS **12** if you have smaller version before.
- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.6

Facebook SDK upgraded to 14.1 version.

### iOS

- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.5

Facebook SDK upgraded to 13 version.

### iOS

- Update minimum deployment target to iOS **11** if you have smaller version before.
- Go to `/ios` directory of your project, and:
  - run `pod repo update`;
  - run `pod update`. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.3

Facebook SDK upgraded to 12.3 version.

### Android 

- Add `facebook_client_token` in `strings.xml` and `com.facebook.sdk.ClientToken` meta in `AndroidManifest.xml`.
- You can remove now:
    - `app_name` and `fb_login_protocol_scheme` from `string.xml`;
    - activities `com.facebook.FacebookActivity` and `com.facebook.CustomTabActivity` from `AndroidManifest.xml`.

See [Android - Edit Your Resources and Manifest](README.md#edit-your-resources-and-manifest) in README.

### iOS

- Edit `Info.plist` (in `ios/Runner/`):
    - add `FacebookClientToken`;
    - you can remove now most of items in `LSApplicationQueriesSchemes`, except `fbapi` and `fb-messenger-share-api`.
- You should run `pod update` in `/ios` directory for you project. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

See [iOS - Configure Your Project](README.md#configure-your-project) in README.

## Upgrade to 1.2

Facebook SDK upgraded to 12 version.

### iOS

- Update minimum deployment target to iOS 10 if you have smaller version before.
- You should run `pod update` in `/ios` directory for you project. That's for upgrading native dependencies. 
- Also `flutter clean` may be required.

## Upgrade to 1.1

Facebook SDK upgraded to 11 version.

### iOS

You should run `pod update` in `/ios` directory for you project. That's for upgrading native dependencies.

Also `flutter clean` may be required.


## Upgrade to 0.5

Facebook SDK upgraded to 9.0.

### iOS

You should run `pod update` in `/ios` directory for you project. That's for upgrading native dependencies.

Also `flutter clean` may be required.
