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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v3.0.0/AdshiftSDK.xcframework.zip",
        checksum: "50f95f565d0098eeb098a0acbf135633e46854e8ed7e2673c8b0a6af4fcb79d4"
    )
    ]
)
