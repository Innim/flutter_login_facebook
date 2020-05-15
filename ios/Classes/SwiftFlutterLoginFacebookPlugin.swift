import Flutter
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

/// Plugin methods.
enum PluginMethod: String {
    case logIn, logOut, getAccessToken, getUserProfile
}

/// Arguments for method `PluginMethod.logIn`
enum LogInArg: String {
    case permissions
}

public class SwiftFlutterLoginFacebookPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_login_facebook", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterLoginFacebookPlugin()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    private lazy var _loginManager = LoginManager()
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = PluginMethod(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        switch method {
        case .logIn:
            guard
                let args = call.arguments as? [String: Any],
                let permissionsArg = args[LogInArg.permissions.rawValue] as? [String]
                else {
                    result(FlutterError(code: "INVALID_ARGS",
                                        message: "Arguments is invalid",
                                        details: nil))
                    return
            }
            
            let permissions = permissionsArg.map {val in Permission(stringLiteral: val)}
            logIn(result: result, permissions: permissions)
        case .logOut:
            logOut(result: result)
        case .getAccessToken:
            getAccessToken(result: result)
        case .getUserProfile:
            getUserProfile(result: result)
        }
    }
    
    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        var options = [UIApplication.LaunchOptionsKey: Any]()
        for (k, value) in launchOptions {
            let key = k as! UIApplication.LaunchOptionsKey
            options[key] = value
        }
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: options)
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL,
                            options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            application, open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return true;
    }
    
    var isLoggedIn: Bool {
        guard let token = AccessToken.current else { return false }
        
        return !token.isExpired
    }
    
    private func getAccessToken(result: @escaping FlutterResult) {
        if let token = AccessToken.current, !token.isExpired {
            result(accessTokenToMap(token: token))
        } else {
            result(nil)
        }
    }
    
    private func getUserProfile(result: @escaping FlutterResult) {
        Profile.loadCurrentProfile { profile, error in
            switch (profile, error) {
            case let (profile?, nil):
                let data: [String: Any?] = [
                    "userId" : profile.userID,
                    "name" : profile.name,
                    "firstName" : profile.firstName,
                    "middleName" : profile.firstName,
                    "lastName" : profile.lastName,
                ]
                
                result(data)
            case let (nil, error?):
                result(FlutterError(code: "FAILED",
                                    message: "Can't get profile: \(error)",
                                    details: nil))
            case (_, _):
                result(FlutterError(code: "UNKNOWN",
                                    message: "Unknown error while get current profile",
                                    details: nil))
            }
        }
    }
    
    private func logIn(result: @escaping FlutterResult, permissions: [Permission]) {
        let viewController = (UIApplication.shared.delegate?.window??.rootViewController)!
        
        _loginManager.logIn(
            permissions: permissions,
            viewController: viewController
        ) { res in
            // TODO: add `granted` and `declined` information
            let accessTokenMap: [String: Any]?
            let status: String
            switch res {
                case let .success(_, _, token):
                    status = "Success"
                    accessTokenMap = self.accessTokenToMap(token: token)
                case .cancelled:
                    status = "Cancel"
                    accessTokenMap = nil
                case let .failed(error):
                    // TODO: send error to dart
                    print("Log in failed with error: \(error)")
                    status = "Error"
                    accessTokenMap = nil
            }
        
            let data: [String: Any?] = [
                "status" : status,
                "accessToken" : accessTokenMap,
            ]
            
            result(data)
        }
    }
    
    private func logOut(result: @escaping FlutterResult) {
        if isLoggedIn {
            _loginManager.logOut()
        }
        
        result(nil)
    }
    
    private func accessTokenToMap(token: AccessToken) -> [String: Any] {
        return [
            "token" : token.tokenString,
            "userId" : token.userID,
            "expires" : Int((token.expirationDate.timeIntervalSince1970 * 1000.0).rounded()),
            "permissions" : token.permissions.map {item in item.name},
        ]
    }
}
