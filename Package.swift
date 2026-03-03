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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.3.0/AdshiftSDK.xcframework.zip",
        checksum: "7e53a128a1c9fc66d524c04e2ccdec7d277e3fc8fca7f657effd2e93da380ad2"
    )
    ]
)
