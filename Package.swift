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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.0.0/AdshiftSDK.xcframework.zip",
        checksum: "891686e6603ef912a761035942a17857d7125951b6767cb975d8fe7341c5a242"
    )
    ]
)
