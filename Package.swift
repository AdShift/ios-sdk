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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v3.1.0/AdshiftSDK.xcframework.zip",
        checksum: "402b9e13ecd2f6d32b433b7a8c12394234ea5532787ea11032f5650b05ad837c"
    )
    ]
)
