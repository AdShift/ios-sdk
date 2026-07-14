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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.8.0/AdshiftSDK.xcframework.zip",
        checksum: "dd23c819dc314161d7e0f3d097be3e09a2194b033df9ffb1ad5375d691dd725f"
    )
    ]
)
