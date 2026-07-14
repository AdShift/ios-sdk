# Changelog

All notable changes to the AdShift iOS SDK will be documented in this file.

## [1.8.0] - 2026-07-14

### Added
- **On-device short link resolution** — short RightLinks now resolve inside the installed app, delivering the same deep-link data and attribution as long links across Universal Links, QR codes, and push notifications.
- **Push notification attribution** — taps on push notifications that carry a RightLink are now attributed for re-engagement.

### Changed
- **SKAdNetwork** — ad revenue is now included in the conversion value calculation.

### Fixed
- Corrected SKAdNetwork attribution registration.

---

## [1.7.0] - 2026-06-19

### Changes
- Merge pull request #16 from AdShift/feat/ios-sdk-tracking-twin-hosts

---

## [1.6.0] - 2026-05-27

### Changes
- Merge pull request #15 from AdShift/feat/getadshiftdeviceid-public-api

---

## [1.5.0] - 2026-05-08

### Changes
- Merge pull request #14 from AdShift/release/v1.5.0

---

## [1.4.0] - 2026-03-19

### Changes
- feat: add Apple AdServices attribution token support (#11)

---

## [1.3.0] - 2026-03-03

### Changes
- Merge pull request #10 from AdShift/fix/sdk-audit-v1.3

---

## [1.2.0] - 2026-02-21

### Changes
- feat: use dynamic currency rates from backend instead of hardcoded values (#9)

---

## [1.1.0] - 2026-01-16

### Changes
- Merge pull request #8 from AdShift/platform-validation-correction

---

## [1.0.1] - 2026-01-05

### Changes
- chore: bump version to 1.0.1

---

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2025-12-03

### Changed
- Migrate API key validation from management.adshift.com to dl.adshift.com (25x faster, Redis-based)
- Lower minimum requirements to Swift 5.7 / Xcode 14.0 for better compatibility
- Update documentation links to dev.adshift.com
- Fix README with correct initialization examples

### Added
- Initial production release
- Full SKAdNetwork 4.0 support
- Deep linking (direct & deferred)
- Privacy Manifest compliance
- GDPR/TCF 2.2 consent management

---

## Release Notes Template

Each release will follow this format:

## [X.Y.Z] - YYYY-MM-DD

### Added
- New features

### Changed
- Changes in existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Removed features

### Fixed
- Bug fixes

### Security
- Security fixes
