# Migration guides

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
