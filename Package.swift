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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v2.4.0/AdshiftSDK.xcframework.zip",
        checksum: "ff89c49d05b531c157e4bc8425721418134911cc047ed66c7b8353366a6e77b2"
    )
    ]
)
