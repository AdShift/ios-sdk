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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v2.0.0/AdshiftSDK.xcframework.zip",
        checksum: "6aa387c58c7b8ca9258c892354c2b511156d035ee3f18680222af28362ef61db"
    )
    ]
)
