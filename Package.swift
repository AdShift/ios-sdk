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
        checksum: "95b762b381f85083e1d5a479168855b9be26e7c12ea44eef961aaf9e0930056e"
    )
    ]
)
