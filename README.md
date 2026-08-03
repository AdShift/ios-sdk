# AdShift iOS SDK

[![GitHub release](https://img.shields.io/github/v/release/AdShift/ios-sdk?sort=semver)](https://github.com/AdShift/ios-sdk/releases/latest)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![Platform](https://img.shields.io/badge/platform-iOS%2015%2B-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/license-Proprietary-lightgrey.svg)](LICENSE)

The AdShift iOS SDK enables app install tracking, deep linking, in-app event attribution, and StoreKit Ad Network (SKAN) 4.0+ support.

## Latest version

- Latest release & release notes: https://github.com/AdShift/ios-sdk/releases/latest
- All versions: https://github.com/AdShift/ios-sdk/releases
- Changelog: [CHANGELOG.md](CHANGELOG.md)

## 📦 Installation

### Swift Package Manager (Recommended)

Add AdShift SDK to your project using Xcode:

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies...**
3. Enter the repository URL:
   ```
   https://github.com/AdShift/ios-sdk
   ```
4. Select version rules (e.g., "Up to Next Major Version" starting from `2.0.0`)
5. Click **Add Package**

Or add it manually to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/AdShift/ios-sdk", from: "2.0.0")
]
```

### CocoaPods

Add AdShift SDK to your `Podfile`:

```ruby
pod 'AdshiftSDK', '~> 2.0'
```

Then run:

```bash
pod install
```

## 🚀 Quick Start

### 1. Import the SDK

```swift
import AdshiftSDK
```

### 2. Configure

```swift
// In your AppDelegate or App struct
Adshift.shared.apiKey = "YOUR_API_KEY"
Adshift.shared.isDebug = true  // Optional: Enable debug logs
```

### 3. Start the SDK

```swift
// Start tracking (call this in applicationDidBecomeActive or view's onAppear)
Task {
    await Adshift.shared.start()
}
```

## 📖 Documentation

For detailed documentation, please visit:
- [Main Documentation](https://dev.adshift.com/)
- [iOS SDK Integration Guide](https://dev.adshift.com/docs/ios-sdk)
- [Deep Linking Guide](https://dev.adshift.com/docs/deeplinks-rightlink)

## 📋 Requirements

- iOS 15.0+
- Swift 5.7+
- Xcode 14.0+

## 🔒 Privacy

AdShift SDK respects user privacy and complies with:
- App Tracking Transparency (ATT)
- GDPR/TCF 2.2
- Apple Privacy Manifest

## 📝 License

Copyright © 2025 AdShift sp. z o.o. All rights reserved.

This SDK is proprietary software. See [LICENSE](LICENSE) for details.

## 🆘 Support

- Email: support@adshift.com
- Documentation: https://dev.adshift.com
- Issues: Please contact support (issues are disabled for binary distribution)

## 📦 Releases

See [Releases](https://github.com/AdShift/ios-sdk/releases) for version history and changelogs.

