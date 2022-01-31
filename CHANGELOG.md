## 1.2.1 - 2022-01-31

* Added `user_link` permission. Thanks to [@YuriNagy01](https://github.com/YuriNagy01).

## 1.2.0+1 - 2021-12-07

* Readme: section about setup permissions for Facebook app. Thanks to [@SF-97](https://github.com/SF-97).

## 1.2.0 - 2021-10-26

* Upgrade to Facebook SDK 12. See [Migration guide](UPGRADE.md#Upgrade-to-1-2).
  * ⚠️ The minimum supported version of iOS is now **10.0**.

## 1.1.0 - 2021-08-05

* Upgrade to Facebook SDK 11. See [Migration guide](UPGRADE.md#Upgrade-to-1-1).
* Remove upper bound for Flutter constraint in pubspec.

## 1.0.1 - 2021-03-15

* **Fixed**: App Events use the correct token if none have been provided manually (Facebook SDK 9.1). Thanks to [@shemhazai](https://github.com/shemhazai).

## 1.0.0 - 2021-03-04

* Flutter 2.0.0.

## 1.0.0-nullsafety.1 - 2021-02-02

* Migrated to null safety.

## 0.5.0 - 2021-02-02

* Upgrade to Facebook SDK 9 (with new Graph API version). See [Migration guide](UPGRADE.md#Upgrade-to-0-5).

## 0.4.2+3 - 2021-01-05

* Readme: update `FacebookLoginStatus` values. Thanks to [@mean-cj](https://github.com/mean-cj).

## 0.4.2+2 - 2021-01-01

* Upgrade `innim_lint` to 0.1.5.

## 0.4.2+1 - 2020-12-26

* Upgrade `innim_lint` to 0.1.4. Refactoring.
* Update [list_ext](https://pub.dev/packages/list_ext) dependency.

## 0.4.2 - 2020-12-22

* Use [innim_lint](https://pub.dev/packages/innim_lint) analysis options.

## 0.4.1 - 2020-12-15

* Added permissions `pages_manage_posts`, `pages_read_engagement` ([PR #37](https://github.com/Innim/flutter_login_facebook/pull/37)). Thanks to [@rogiervandenberg](https://github.com/rogiervandenberg).

## 0.4.0+1 - 2020-11-05

* Added [Express Login](https://developers.facebook.com/docs/facebook-login/android/#expresslogin) for Android ([PR #27](https://github.com/Innim/flutter_login_facebook/pull/27)). Thanks to [@atrope](https://github.com/atrope).

## 0.3.0 - 2020-10-20

* Upgrade to Facebook SDK >8.

## 0.2.1+1 - 2020-10-15

* Readme: fixes in code example and typos.

## 0.2.1 - 2020-08-06

* **Fixed**: Crash on iOS 10.

## 0.2.0+1 - 2020-06-21

* Readme: add information about usage `getProfileImageUrl()`.

## 0.2.0 - 2020-06-20

* Method to get user profile image.

## 0.1.2+4 - 2020-06-20

* **Fixed:** Plugin may break some other libraries ([PR #8](https://github.com/Innim/flutter_login_facebook/pull/8)). Thanks to [@spiritinlife](https://github.com/spiritinlife).

## 0.1.2+3 - 2020-06-11

* **Fixed:** intercept all open urls and launches, even though it can't be handled. 
* Minor readme improvements.

## 0.1.2+2 - 2020-06-03

* Readme: fix links urls.
* Readme: fix some errors in text.
* Readme: Medium article link.

## 0.1.2+1 - 2020-05-27

* Readme: add log in error handling.
* Fixed mistake in Readme.

## 0.1.2 - 2020-05-27

* An ability to get user email (if have permissions).
* Add `declinedPermissions` in `AccessToken`.

## 0.1.1+1 - 2020-05-22

* [android] Fixed: reset activity is never called.

## 0.1.1 - 2020-05-22

* Add error information for login failure.
* Readme: add information about additional key hashes.
* Mute exception furing get profile.

## 0.1.0+1 - 2020-05-19

* More detailed description.

## 0.1.0 - 2020-05-19

* Core functionality (iOS/Android).
