import Flutter
import UIKit

public class SwiftFlutterFacebookWrapperPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_facebook_wrapper", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFacebookWrapperPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
