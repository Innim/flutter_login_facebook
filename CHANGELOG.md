## 1.9.0

* Upgrade Facebook Android SDK to 16.2.0. 
* Upgrade Facebook iOS SDK to 16.2.1. 

See [Migration guide](UPGRADE.md#Upgrade-to-1-9).

## 1.8.0

* Upgrade Facebook Android SDK to 16.0.1. 
* Upgrade Facebook iOS SDK to 16.0.1. 

See [Migration guide](UPGRADE.md#Upgrade-to-1-8).

## 1.7.0

* Upgrade Facebook Android SDK to 15.1.0.
  * ⚠️ The minimum supported version of Android is now **5.0** (API 21).
* Upgrade Facebook iOS SDK to 15.1.0. Thanks to [@hamzaalmahdi](https://github.com/hamzaalmahdi).
  * ⚠️ The minimum supported version of iOS is now **12.0**.
* Added Instagram permissions: `instagram_basic` and `instagram_content_publish`. Thanks to [@vhnum](https://github.com/vhnum).
* Fixed compatibility issue with Flutter 3.3.9.

See [Migration guide](UPGRADE.md#Upgrade-to-1-7).

## 1.6.2

* [Android] Migrate from `jcenter()` to `mavenCentral()`.
* **Fixed**: Compilation error `Could not resolve com.facebook.android:...`.

## 1.6.1

* Upgrade Facebook Android SDK to 14.1.1.
* Added new [Problem solving](README.md#problem-solving) section in README.

## 1.6.0

* Upgrade Facebook iOS SDK to 14.1.
* Upgrade Facebook Android SDK to 14.1.

See [Migration guide](UPGRADE.md#Upgrade-to-1-6).

## 1.5.0+1

**Fixed**: Don't compile for iOS.

* Upgrade Facebook iOS SDK to 14.

If you're upgrading from **1.5.0** - please follow to 
[Migration guide](UPGRADE.md#Upgrade-to-1-5) to version 1.5
once again.

## 1.5.0

⛔️ May not compile for iOS! Use one of the next versions ⛔️ 

* Upgrade to Facebook SDK 13.2.
  * ⚠️ The minimum supported version of iOS is now **11.0**.

See [Migration guide](UPGRADE.md#Upgrade-to-1-5).

## 1.4.1

* **Fixed**: Exception on parse Access Token if Facebook returns extremely high expiry timestamps for expires. Thanks to [@rogiervandenberg](https://github.com/rogiervandenberg).

## 1.4.0+1

* Update README and Example.

## 1.4.0

* Fix warnings and deprecation messages.
* **BREAKING** Full remove of Android embedding v1 support. 
This will not affect most of developers. See [Readme](README.md#minimum-requirements).

## 1.3.0

* Upgrade to Facebook SDK 12.3.
* Add Client Token support.

See [Migration guide](UPGRADE.md#Upgrade-to-1-3).

## 1.2.1

* Added `user_link` permission. Thanks to [@YuriNagy01](https://github.com/YuriNagy01).

## 1.2.0+1

* Readme: section about setup permissions for Facebook app. Thanks to [@SF-97](https://github.com/SF-97).

## 1.2.0

* Upgrade to Facebook SDK 12. See [Migration guide](UPGRADE.md#Upgrade-to-1-2).
  * ⚠️ The minimum supported version of iOS is now **10.0**.

## 1.1.0

* Upgrade to Facebook SDK 11. See [Migration guide](UPGRADE.md#Upgrade-to-1-1).
* Remove upper bound for Flutter constraint in pubspec.

## 1.0.1

* **Fixed**: App Events use the correct token if none have been provided manually (Facebook SDK 9.1). Thanks to [@shemhazai](https://github.com/shemhazai).

## 1.0.0

* Flutter 2.0.0.

## 1.0.0-nullsafety.1

* Migrated to null safety.

## 0.5.0

* Upgrade to Facebook SDK 9 (with new Graph API version). See [Migration guide](UPGRADE.md#Upgrade-to-0-5).

## 0.4.2+3

* Readme: update `FacebookLoginStatus` values. Thanks to [@mean-cj](https://github.com/mean-cj).

## 0.4.2+2

* Upgrade `innim_lint` to 0.1.5.

## 0.4.2+1

* Upgrade `innim_lint` to 0.1.4. Refactoring.
* Update [list_ext](https://pub.dev/packages/list_ext) dependency.

## 0.4.2

* Use [innim_lint](https://pub.dev/packages/innim_lint) analysis options.

## 0.4.1

* Added permissions `pages_manage_posts`, `pages_read_engagement` ([PR #37](https://github.com/Innim/flutter_login_facebook/pull/37)). Thanks to [@rogiervandenberg](https://github.com/rogiervandenberg).

## 0.4.0+1

* Added [Express Login](https://developers.facebook.com/docs/facebook-login/android/#expresslogin) for Android ([PR #27](https://github.com/Innim/flutter_login_facebook/pull/27)). Thanks to [@atrope](https://github.com/atrope).

## 0.3.0

* Upgrade to Facebook SDK >8.

## 0.2.1+1

* Readme: fixes in code example and typos.

## 0.2.1

* **Fixed**: Crash on iOS 10.

## 0.2.0+1

* Readme: add information about usage `getProfileImageUrl()`.

## 0.2.0

* Method to get user profile image.

## 0.1.2+4

* **Fixed:** Plugin may break some other libraries ([PR #8](https://github.com/Innim/flutter_login_facebook/pull/8)). Thanks to [@spiritinlife](https://github.com/spiritinlife).

## 0.1.2+3

* **Fixed:** intercept all open urls and launches, even though it can't be handled. 
* Minor readme improvements.

## 0.1.2+2

* Readme: fix links urls.
* Readme: fix some errors in text.
* Readme: Medium article link.

## 0.1.2+1

* Readme: add log in error handling.
* Fixed mistake in Readme.

## 0.1.2

* An ability to get user email (if have permissions).
* Add `declinedPermissions` in `AccessToken`.

## 0.1.1+1

* [android] Fixed: reset activity is never called.

## 0.1.1

* Add error information for login failure.
* Readme: add information about additional key hashes.
* Mute exception during get profile.

## 0.1.0+1

* More detailed description.

## 0.1.0

* Core functionality (iOS/Android).
