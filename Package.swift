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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.1.0/AdshiftSDK.xcframework.zip",
        checksum: "53e53ad83bfe7cde9e79a75f4ca91de106de316e722c262ef22925f49b19bca4"
    )
    ]
)
