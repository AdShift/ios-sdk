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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.4.0/AdshiftSDK.xcframework.zip",
        checksum: "2da4b046b8134c427116a1e9d7e0d48f94dbf31caac39a730871a1f46384fca2"
    )
    ]
)
