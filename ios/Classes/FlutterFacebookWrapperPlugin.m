#import "FlutterFacebookWrapperPlugin.h"
#if __has_include(<flutter_facebook_wrapper/flutter_facebook_wrapper-Swift.h>)
#import <flutter_facebook_wrapper/flutter_facebook_wrapper-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_facebook_wrapper-Swift.h"
#endif

@implementation FlutterFacebookWrapperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFacebookWrapperPlugin registerWithRegistrar:registrar];
}
@end
