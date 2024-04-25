import Flutter
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

/// Plugin methods.
enum PluginMethod: String {
    case logIn, logOut, getAccessToken, getUserProfile, getUserEmail, getSdkVersion, getProfileImageUrl, isReady
}

/// Plugin methods in Dart code.
enum PluginDartMethod: String {
    case ready
}

/// Arguments for method `PluginMethod.logIn`
enum LogInArg: String {
    case permissions
}

/// Arguments for method `PluginMethod.getProfileImageUrl`
enum GetProfileImageUrlArg: String {
    case width, height
}

enum LocalStoreKey: String {
    case limitedLogin
    
    var value: String {
        return "flutter_login_facebook.\(rawValue)"
    }
}

class FbAppObserver : FBSDKApplicationObserving {
    private let onReady: () -> Void
    
    init(onReady: @escaping () -> Void) {
        self.onReady = onReady
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // before that we have no data about the previously logged in user
        onReady()
        return true
    }
}

public class SwiftFlutterLoginFacebookPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_login_facebook", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterLoginFacebookPlugin(channel: channel)
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
    }
    
    private let _channel: FlutterMethodChannel
    
    private lazy var _initObserver = FbAppObserver { self.onFbReady() }
    
    private lazy var _loginManager = LoginManager()
    private var _isReady = false
    
    init(channel: FlutterMethodChannel) {
        self._channel = channel
    }
    
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
            
            logIn(result: result, permissions: permissionsArg)
        case .logOut:
            logOut(result: result)
        case .getAccessToken:
            getAccessToken(result: result)
        case .getUserProfile:
            getUserProfile(result: result)
        case .getUserEmail:
            getUserEmail(result: result)
        case .getProfileImageUrl:
            guard
                let args = call.arguments as? [String: Any],
                let widthArg = args[GetProfileImageUrlArg.width.rawValue] as? Int,
                let heightArg = args[GetProfileImageUrlArg.height.rawValue] as? Int
                else {
                    result(FlutterError(code: "INVALID_ARGS",
                                        message: "Arguments is invalid",
                                        details: nil))
                    return
            }
            
            getProfileImageUrl(result: result, width: widthArg, height: heightArg)
        case .getSdkVersion:
            getSdkVersion(result: result)
        case .isReady:
            isReady(result: result)
        }
    }
    
    public func application(_ application: UIApplication,
                            didFinishLaunchingWithOptions launchOptions: [AnyHashable: Any] = [:]) -> Bool {
        var options = [UIApplication.LaunchOptionsKey: Any]()
        for (k, value) in launchOptions {
            let key = k as! UIApplication.LaunchOptionsKey
            options[key] = value
        }
        
        let fbDelegate = ApplicationDelegate.shared
        fbDelegate.addObserver(_initObserver)
        fbDelegate.application(application, didFinishLaunchingWithOptions: options)
        
        return true
    }
    
    public func application(_ application: UIApplication, open url: URL,
                            options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let processed = ApplicationDelegate.shared.application(
            application, open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return processed;
    }
    
    private func onFbReady() {
        let fbDelegate = ApplicationDelegate.shared
        fbDelegate.addObserver(_initObserver)
        
        _isReady = true
        _channel.invokeMethod(PluginDartMethod.ready.rawValue, arguments: nil)
    }
    
    var isLoggedIn: Bool {
        guard let token = AccessToken.current else { return false }
        
        return !token.isExpired
    }
    
    private func getSdkVersion(result: @escaping FlutterResult) {
        let sdkVersion = Settings.shared.sdkVersion
        result(sdkVersion)
    }
    
    private func isReady(result: @escaping FlutterResult) {
        result(_isReady)
    }
    
    private func getAccessToken(result: @escaping FlutterResult) {
        if let token = AccessToken.current, !token.isExpired {
            result(accessTokenToMap(token: token, authenticationToken: AuthenticationToken.current, isLimitedLogin: loadIsLimitedLogin()))
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
    
    private func getUserEmail(result: @escaping FlutterResult) {
        if let email = Profile.current?.email {
            if email.isEmpty == false {
                result(email)
                return
            }
        }
        
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields": "email"])
        graphRequest.start(completion: { (connection, res, error) -> Void in
            guard
                let response = res as? [String: Any],
                let email = response["email"] as? String
                else {
                    let resError: FlutterError
                    if let err = error {
                        resError = FlutterError(
                            code: "FAILED",
                            message: "Can't get email: \(err)",
                            details: nil)
                    } else {
                        resError = FlutterError(
                            code: "UNKNOWN",
                            message: "Invalid result on get email: \(String(describing: result))",
                            details: nil)
                    }
                    result(resError)
                    return;
            }
            
            result(email)
        })
    }
    
    private func getProfileImageUrl(result: @escaping FlutterResult, width: Int, height: Int) {
        let isLimitedLogin = loadIsLimitedLogin()
        if isLimitedLogin {
            // If we use a Limited Login than loadCurrentProfile() will return not working url,
            // and profile.imageURL will return nil.
            // So we just trying to parse data from AuthenticationToken
            var url: String? = nil
            if let authenticationToken = AuthenticationToken.current {
                if let claims = authenticationToken.claims() {
                    url = claims.picture
                } else {
                    url = parseAuthenticationToken(authenticationToken)?.picture
                }
            }
        
            result(url)
            return
        }
        
        Profile.loadCurrentProfile { profile, error in
            switch (profile, error) {
            case let (profile?, nil):
                let url = profile.imageURL(forMode: Profile.PictureMode.normal,
                                           size: CGSize(width: width, height: height))
                result(url?.absoluteString)
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
    
    private func logIn(result: @escaping FlutterResult, permissions: [String]) {
        let nonce = UUID().uuidString
        let config = LoginConfiguration(permissions: permissions, tracking: .enabled, nonce: nonce)
        
        // If we have not permissions for tracking, then FB SDK will falls back to limited login
        // and there is not way no know about this.
        // So, as a temporary workaround, we will make the same checks as FB SDK does.
        // https://github.com/facebook/facebook-ios-sdk/blob/7aa39da29eca817495cecf1f9fa831f023208c63/FBSDKLoginKit/FBSDKLoginKit/LoginManager.swift#L570
        let isLimitedLogin = _DomainHandler.sharedInstance().isDomainHandlingEnabled() && !Settings.shared.isAdvertiserTrackingEnabled
        
        _loginManager.logIn(configuration: config) { res in
            // TODO: add `granted` and `declined` information
            let accessTokenMap: [String: Any?]?
            let status: String
            let errorMap: [String: Any?]?
            
            switch res {
            case let .success(granted, declined, token):
                status = "Success"
                
                let authenticationToken = AuthenticationToken.current
                if authenticationToken?.nonce != nonce {
                    // print warning, but process for now
                    print("[WARNING] Nonce is not match. Expected: \(nonce), got: \(authenticationToken?.nonce ?? "nil")")
                }
                    
                self.saveIsLimitedLogin(isLimitedLogin)
                
                // TODO: check why it's nullable now?
                accessTokenMap = self.accessTokenToMap(token: token!, authenticationToken: authenticationToken, isLimitedLogin: isLimitedLogin)
                errorMap = nil
                break;
            case .cancelled:
                status = "Cancel"
                accessTokenMap = nil
                errorMap = nil
                break
            case let .failed(error):
                status = "Error"
                accessTokenMap = nil
                
                print("Log in failed with error: \(error)")
                errorMap = self.errorToMap(error: error)
                
                break
            }
            
            let data: [String: Any?] = [
                "status": status,
                "accessToken": accessTokenMap,
                "error": errorMap
            ]
            
            result(data)
        }
    }
    
    private func logOut(result: @escaping FlutterResult) {
        if isLoggedIn {
            _loginManager.logOut()
            saveIsLimitedLogin(false)
        }
        
        result(nil)
    }
    
    // we need this method, becase token.claims() returns nil for an expired token
    private func parseAuthenticationToken(_ token: AuthenticationToken) -> AuthenticationTokenClaimsRaw? {
        let segments = token.tokenString.components(separatedBy: ".")

        guard
          segments.count == 3
        else {
          return nil
        }
        
        return AuthenticationTokenClaimsRaw(encodedClaims: segments[1])
    }
    
    private func accessTokenToMap(token: AccessToken, authenticationToken: AuthenticationToken?, isLimitedLogin: Bool) -> [String: Any?] {
        return [
            "token": token.tokenString,
            "userId": token.userID,
            "expires": Int64((token.expirationDate.timeIntervalSince1970 * 1000.0).rounded()),
            "permissions": token.permissions.map {item in item.name},
            "declinedPermissions": token.declinedPermissions.map {item in item.name},
            "authenticationToken": authenticationToken?.tokenString,
            "isLimitedLogin": isLimitedLogin,
        ]
    }
    
    private func errorToMap(error: Error) -> [String: Any?]? {
        let nsError = error as NSError
        let info = nsError.userInfo
        
        return [
            "developerMessage": info[ErrorDeveloperMessageKey] as? String,
            "localizedDescription": info[ErrorLocalizedDescriptionKey] as? String,
            "localizedTitle": info[ErrorLocalizedTitleKey] as? String,
        ]
    }
    
    private func saveIsLimitedLogin(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: LocalStoreKey.limitedLogin.value)
    }
    
    private func loadIsLimitedLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: LocalStoreKey.limitedLogin.value)
    }
}


// we had to copy and make simplier version of AuthenticationTokenClaim,
// because AuthenticationTokenClaim() have no public simple constructor without parsing
// and parsing of an expired token returns nil
// TODO: remove it if we will have an opportunity or check and update on every SDK upgrade
final class AuthenticationTokenClaimsRaw {
  private enum Keys {
    static let aud = "aud"
    static let email = "email"
    static let exp = "exp"
    static let familyName = "family_name"
    static let givenName = "given_name"
    static let iat = "iat"
    static let iss = "iss"
    static let jti = "jti"
    static let middleName = "middle_name"
    static let name = "name"
    static let nonce = "nonce"
    static let picture = "picture"
    static let sub = "sub"
    static let userAgeRange = "user_age_range"
    static let userBirthday = "user_birthday"
    static let userFriends = "user_friends"
    static let userGender = "user_gender"
    static let userHometown = "user_hometown"
    static let userLink = "user_link"
    static let userLocation = "user_location"
  }

  private enum Values {
    static let validHost = "facebook.com"
    static let validHostSuffix = ".facebook.com"
  }

  /// A unique identifier for the token.
  public let jti: String

  /// Issuer Identifier for the Issuer of the response.
  public let iss: String

  /// Audience(s) that this ID Token is intended for.
  public let aud: String

  /// String value used to associate a Client session with an ID Token, and to mitigate replay attacks.
  public let nonce: String

  /// Expiration time on or after which the ID Token MUST NOT be accepted for processing.
  public let exp: TimeInterval

  /// Time at which the JWT was issued.
  public let iat: TimeInterval

  /// Subject - Identifier for the End-User at the Issuer.
  public let sub: String

  /// End-User's full name in displayable form including all name parts.
  public let name: String?

  /// End-User's given name in displayable form
  public let givenName: String?

  /// End-User's middle name in displayable form
  public let middleName: String?

  /// End-User's family name in displayable form
  public let familyName: String?

  /**
   End-User's preferred e-mail address.

   IMPORTANT: This field will only be populated if your user has granted your application the 'email' permission.
   */
  public let email: String?

  /// URL of the End-User's profile picture.
  public let picture: String?

  /**
   End-User's friends.

   IMPORTANT: This field will only be populated if your user has granted your application the 'user_friends' permission.
   */
  public let userFriends: [String]?

  /// End-User's birthday
  public let userBirthday: String?

  /// End-User's age range
  public let userAgeRange: [String: NSNumber]?

  /// End-User's hometown
  public let userHometown: [String: String]?

  /// End-User's location
  public let userLocation: [String: String]?

  /// End-User's gender
  public let userGender: String?

  /// End-User's link
  public let userLink: String?

  public convenience init?(encodedClaims: String) {
    guard let claimsData = Base64.decode(asData: Base64.base64(fromBase64Url: encodedClaims)),
              let claimsDictionary = try? JSONSerialization.jsonObject(with: claimsData) as? [String: Any],
              let validJTI = claimsDictionary[Keys.jti] as? String,
              !validJTI.isEmpty,
              let issuer = claimsDictionary[Keys.iss] as? String,
              let audience = claimsDictionary[Keys.aud] as? String,
              let expiration = claimsDictionary[Keys.exp] as? Double,
              let issuedTimestamp = claimsDictionary[Keys.iat] as? Double,
              let nonce = claimsDictionary[Keys.nonce] as? String,
              let subject = claimsDictionary[Keys.sub] as? String,
              !subject.isEmpty
        else {
          return nil
        }
        
        
    var potentialAgeRange: [String: NSNumber]?
    if let rawAgeRange = claimsDictionary[Keys.userAgeRange] as? [String: NSNumber],
       !rawAgeRange.isEmpty {
      potentialAgeRange = rawAgeRange
    }

    var potentialHometown: [String: String]?
    if let hometown = claimsDictionary[Keys.userHometown] as? [String: String],
       !hometown.isEmpty {
      potentialHometown = hometown
    }

    var potentialLocation: [String: String]?
    if let location = claimsDictionary[Keys.userLocation] as? [String: String],
       !location.isEmpty {
      potentialLocation = location
    }

    self.init(
      jti: validJTI,
      iss: issuer,
      aud: audience,
      nonce: nonce,
      exp: expiration,
      iat: issuedTimestamp,
      sub: subject,
      name: claimsDictionary[Keys.name] as? String,
      givenName: claimsDictionary[Keys.givenName] as? String,
      middleName: claimsDictionary[Keys.middleName] as? String,
      familyName: claimsDictionary[Keys.familyName] as? String,
      email: claimsDictionary[Keys.email] as? String,
      picture: claimsDictionary[Keys.picture] as? String,
      userFriends: claimsDictionary[Keys.userFriends] as? [String],
      userBirthday: claimsDictionary[Keys.userBirthday] as? String,
      userAgeRange: potentialAgeRange,
      userHometown: potentialHometown,
      userLocation: potentialLocation,
      userGender: claimsDictionary[Keys.userGender] as? String,
      userLink: claimsDictionary[Keys.userLink] as? String
    )
  }

  init(
    jti: String,
    iss: String,
    aud: String,
    nonce: String,
    exp: TimeInterval,
    iat: TimeInterval,
    sub: String,
    name: String?,
    givenName: String?,
    middleName: String?,
    familyName: String?,
    email: String?,
    picture: String?,
    userFriends: [String]?,
    userBirthday: String?,
    userAgeRange: [String: NSNumber]?,
    userHometown: [String: String]?,
    userLocation: [String: String]?,
    userGender: String?,
    userLink: String?
  ) {
    self.jti = jti
    self.iss = iss
    self.aud = aud
    self.nonce = nonce
    self.exp = exp
    self.iat = iat
    self.sub = sub
    self.name = name
    self.givenName = givenName
    self.middleName = middleName
    self.familyName = familyName
    self.email = email
    self.picture = picture
    self.userFriends = userFriends
    self.userBirthday = userBirthday
    self.userAgeRange = userAgeRange
    self.userHometown = userHometown
    self.userLocation = userLocation
    self.userGender = userGender
    self.userLink = userLink
  }
}
