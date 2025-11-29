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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.0.0/AdshiftSDK.xcframework.zip",
        checksum: "caac11a3675117e66438ecce873c7819934e3d6a7ccf9d3d95e62a77fb8abc4d"
    )
    ]
)
