// swift-tools-version: 5.9
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
            url: "https://github.com/AdShift/ios-sdk/releases/download/v${VERSION}/AdshiftSDK.xcframework.zip",
            checksum: "${CHECKSUM}"
        )
    ]
)
