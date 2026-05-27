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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.6.0/AdshiftSDK.xcframework.zip",
        checksum: "6ff325575edf25b2a621b2245d694fd72e8043d20bdadfc9ce4401e29356ab57"
    )
    ]
)
