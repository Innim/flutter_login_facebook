// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "flutter_login_facebook",
    platforms: [
        .iOS("13.0"),
    ],
    products: [
        .library(name: "flutter-login-facebook", targets: ["flutter_login_facebook"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/facebook/facebook-ios-sdk", exact: "18.0.3"),
    ],
    targets: [
        .target(
            name: "flutter_login_facebook",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "FacebookLogin", package: "facebook-ios-sdk"),
            ],
            resources: [
            ]
        )
    ]
)
