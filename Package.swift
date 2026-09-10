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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v2.0.1/AdshiftSDK.xcframework.zip",
        checksum: "7f746f855d113e0b3d3ac3dbcc5b595e0ca3021839df1fd5f04529c6bdf1c4eb"
    )
    ]
)
