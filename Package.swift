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
        url: "https://github.com/AdShift/ios-sdk/releases/download/v1.2.0/AdshiftSDK.xcframework.zip",
        checksum: "4515f68612ec73b7cf028ff79987bde2811e830c9bad24c7a883b174e4532ad1"
    )
    ]
)
