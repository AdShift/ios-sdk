# AdShift iOS SDK

The AdShift iOS SDK enables app install tracking, deep linking, in-app event attribution, and StoreKit Ad Network (SKAN) 4.0+ support.

## 📦 Installation

### Swift Package Manager (Recommended)

Add AdShift SDK to your project using Xcode:

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies...**
3. Enter the repository URL:
   ```
   https://github.com/AdShift/ios-sdk
   ```
4. Select version rules (e.g., "Up to Next Major Version" starting from `1.0.0`)
5. Click **Add Package**

Or add it manually to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/AdShift/ios-sdk", from: "1.0.0")
]
```

## 🚀 Quick Start

### 1. Import the SDK

```swift
import AdshiftSDK
```

### 2. Initialize

```swift
// In your AppDelegate or App struct
Adshift.shared.configure(
    appId: "YOUR_APP_ID",
    devKey: "YOUR_DEV_KEY"
)
```

### 3. Start the SDK

```swift
// Start tracking
Adshift.shared.start()
```

## 📖 Documentation

For detailed documentation, please visit:
- [Integration Guide](https://docs.adshift.com/ios)
- [API Reference](https://docs.adshift.com/ios/api)
- [Migration Guides](https://docs.adshift.com/ios/migration)

## 📋 Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15.0+

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
- Documentation: https://docs.adshift.com
- Issues: Please contact support (issues are disabled for binary distribution)

## 📦 Releases

See [Releases](https://github.com/AdShift/ios-sdk/releases) for version history and changelogs.

