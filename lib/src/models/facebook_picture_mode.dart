import 'package:flutter/foundation.dart';

/// Defines the aspect ratio mode for the source image of the profile picture.
enum FlutterPictureMode {
  /// A square cropped version of the image will be included in the view.
  square,

  /// The original picture's aspect ratio will be used for the source image in the view.
  normal
}

extension FlutterPictureModeExtension on FlutterPictureMode {
  /// Name of mode.
  String get name => describeEnum(this);
}
