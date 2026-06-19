// swift-tools-version: 5.7
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
    .binaryTarget(
        name: "AdshiftSDK",
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.7.0/AdshiftSDK.xcframework.zip",
        checksum: "5695b98340b393d4063890a1c4824ddb59d3912d2e10fd0c4f9a09fcb90294f8"
    )
    ]
)
