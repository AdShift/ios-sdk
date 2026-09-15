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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v2.2.0/AdshiftSDK.xcframework.zip",
        checksum: "6a4e56a668547b23ac8000ae4dab1ca36c3a03f8c45df4032eb192acce3d399b"
    )
    ]
)
