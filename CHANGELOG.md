# Changelog

All notable changes to the AdShift iOS SDK will be documented in this file.

## [2.0.0] - unreleased

Major release covering consent handling and device identity. Existing integrations compile without source changes — review the upgrade notes below.

### Changed
- **Consent flags are tri-state** — `AdShiftConsent.forGDPRUser` accepts `Bool?`, where `nil` means the user has not made a decision. This lets us tell "denied" apart from "never asked" when forwarding consent to partners. Existing three-argument calls compile unchanged.
- **Non-GDPR users report granted consent** — `forNonGDPRUser()` now returns granted flags instead of denied ones. If your app branches on `isConsentGranted()`, the result changes.
- **The advertising identifier follows consent** — the IDFA is read only when ATT is authorized and no consent denial is stored. Previously a denial cleared the cached value and the next refresh read it again.
- **The AdShift device ID is written once** — it is no longer regenerated when ad storage is denied, so `getAdShiftDeviceId()` stays stable for the lifetime of the install. Users are no longer counted more than once after a consent change, and subscription platforms such as RevenueCat and Adapty stitch reliably against it.
- **Consent survives app restarts** — a value passed to `setConsentData` is stored and reapplied on the next launch, together with the advertising identifier gate.
- **`start()` no longer waits for API key validation** — the first session is recorded immediately and validation continues in the background, so a slow network does not delay the first event.
- **An unreachable backend no longer costs events** — validation resolves to a valid, invalid or unknown verdict retried with backoff, and no outcome clears the queue.
- **Both completion handlers report differently** — `start()` returns `api_key_validation_status` (`pending`, `valid` or `invalid`) in place of `api_key_validated`, and a rejected key now arrives as that status instead of through the error path. `track()` answers `queued` for every accepted event, since events reach the disk queue before any network call, and no longer answers `success`. Nothing fails to compile here, so review any code that reads these dictionaries.

### Added
- **Time in app** — every app open reports a lifetime foreground-time counter, which the backend turns into time-in-app and session-length metrics.
- **Device details** — events carry the device type and hardware model (for example `iPhone14,2`), previously reported only as the device family.
- **Delivery reliability** — events are written to disk before any network call and retried from a crash-safe queue with per-endpoint backoff, each carrying an identifier that lets the backend drop duplicates. Server-to-server clicks use the same persistent queue.
- **Server-side opt-out** — a response can permanently disable tracking for a device. The SDK then clears both queues, stops sending, and reports the new `AdShiftError.trackingDisabled` from `start()` and from deep link handling.
- **The opening link is forwarded whole** — `app_install` and `app_open`, including a foreground open, carry the full deep link as `deeplink_url`, and a server-to-server click carries it as `raw_url`. A link over 2048 bytes is left out rather than shortened, so the server never receives half a link — the event or click is still sent, only without it. This lets attribution be resolved for link formats the SDK does not parse itself, so a campaign no longer has to use a link shape the SDK recognises. The presence of a link is not an attribution claim. Credential-shaped parameters are removed on receipt and are not stored. No integration change is needed.
- **Full link logging follows `isDebug`** — the link an app was opened with is logged at debug level, so it stays out of device logs unless debug logging is switched on.

### Fixed
- **Deferred deep links survive a failed first attempt** — the one-shot lookup is now consumed only after the backend answers, so a network failure on the first launch no longer costs the deferred deep link. An answer of "there is none" ends it just as definitively, and the SDK stops asking.
- **Legitimate interest counts for TCF purpose 7** — users covered by a legitimate-interest basis under a TCF CMP are no longer treated as having denied measurement.
- **Deep link sub-parameters read the right keys** — `deep_link_sub1…5` in the deep link result are filled from the link's `deep_link_sub*` parameters. They previously carried the attribution `as_sub*` values, which is not what those fields are for.

### Upgrading
- Swift Package Manager: `from: "2.0.0"`. CocoaPods: `pod 'AdshiftSDK', '~> 2.0'`.
- Pass `nil` for a consent flag the user has not decided on.
- Review any logic that depends on the flags returned by `forNonGDPRUser()`.
- Update anything that reads the dictionaries returned by `start()` or `track()`, and anything that expects deep link data in `as_sub*` rather than `deep_link_sub*`.

---

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
