# AdShift iOS SDK

[![GitHub release](https://img.shields.io/github/v/release/AdShift/ios-sdk?sort=semver)](https://github.com/AdShift/ios-sdk/releases/latest)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Platform](https://img.shields.io/badge/platform-iOS%2015%2B-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-Proprietary-lightgrey.svg)](LICENSE)

The AdShift iOS SDK measures installs and in-app events, resolves direct and deferred deep links, supports SKAdNetwork 4.0, and carries ATT and user consent signals to ad partners.

This repository is the public home for the SDK's release notes and distribution. The SDK is proprietary and ships as a binary XCFramework attached to each release — there is no source code here.

## Release notes

- Changelog: [CHANGELOG.md](CHANGELOG.md)
- Latest release: https://github.com/AdShift/ios-sdk/releases/latest
- All releases: https://github.com/AdShift/ios-sdk/releases

## Installation

### Swift Package Manager

In Xcode, go to **File → Add Package Dependencies…** and enter:

```
https://github.com/AdShift/ios-sdk
```

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/AdShift/ios-sdk", from: "2.0.0")
]
```

### CocoaPods

```ruby
pod 'AdshiftSDK', '~> 2.0'
```

Required Info.plist entries, entitlements and the ATT setup are covered in the [installation guide](https://dev.adshift.com/docs/ios-sdk/installation).

## Documentation

The full documentation lives at [dev.adshift.com](https://dev.adshift.com/docs/ios-sdk):

| | |
|---|---|
| [Quickstart](https://dev.adshift.com/docs/ios-sdk/quickstart) | Minimal integration, start to finish |
| [Integration](https://dev.adshift.com/docs/ios-sdk/integration) | Initialization, lifecycle and configuration |
| [In-app events](https://dev.adshift.com/docs/ios-sdk/events) · [Ad revenue](https://dev.adshift.com/docs/ios-sdk/ad-revenue) | Event tracking and monetization |
| [Deep links](https://dev.adshift.com/docs/ios-sdk/deeplinks) | Universal Links, deferred links and RightLinks |
| [Consent](https://dev.adshift.com/docs/ios-sdk/consent) | ATT, GDPR, TCF 2.2 and Google consent signals |
| [SKAdNetwork](https://dev.adshift.com/docs/ios-sdk/skan) | Conversion values and SKAN 4.0 windows |
| [Push notifications](https://dev.adshift.com/docs/ios-sdk/push-notifications) | Attributing push-driven re-engagement |
| [Troubleshooting](https://dev.adshift.com/docs/ios-sdk/troubleshooting) · [Debugging](https://dev.adshift.com/docs/ios-sdk/debugging) | Verifying an integration |

## Requirements

- iOS 15.0 or newer
- Swift 5.7+, Xcode 14.0+

## Support

- Email: support@adshift.com
- Documentation: https://dev.adshift.com
- Issues are disabled here; please contact support.

## License

Copyright © 2026 AdShift sp. z o.o. All rights reserved.

This SDK is proprietary software. See [LICENSE](LICENSE) for details.
