#import "FlutterLoginFacebookPlugin.h"
#if __has_include(<flutter_login_facebook/flutter_login_facebook-Swift.h>)
#import <flutter_login_facebook/flutter_login_facebook-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_login_facebook-Swift.h"
#endif

@implementation FlutterLoginFacebookPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterLoginFacebookPlugin registerWithRegistrar:registrar];
}
@end
