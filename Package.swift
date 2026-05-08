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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.5.0/AdshiftSDK.xcframework.zip",
        checksum: "d7b388eee42422f07441c2ecc9ba38099bc37460e6552ce740ecd709afd39458"
    )
    ]
)
