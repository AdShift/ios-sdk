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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.0.1/AdshiftSDK.xcframework.zip",
        checksum: "b114ab62472e4fdea29fc7799669b57383cd432f813e52356fed9ab8cffa82b9"
    )
    ]
)
