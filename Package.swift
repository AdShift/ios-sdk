// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdshiftSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "AdshiftSDK",
            targets: ["AdshiftSDK"])
    ],
    targets: [
        // Binary distribution - XCFramework will be added here on first release
        // Example:
        // .binaryTarget(
        //     name: "AdshiftSDK",
        //     url: "https://github.com/AdShift/ios-sdk/releases/download/v1.0.0/AdshiftSDK.xcframework.zip",
        //     checksum: "abc123def456..."
        // )
    ]
)

