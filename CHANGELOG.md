# Changelog

All notable changes to the AdShift iOS SDK will be documented in this file.

## [2.4.0] - 2026-10-06

2.3.0 was not published; everything it contained ships in this release.

### Added
- **Google on-device conversion measurement** — when your app includes Google's on-device conversion library (`GoogleAdsOnDeviceConversion`, or Firebase Analytics 11.14 and later), the SDK asks it for the install's conversion info on the first launch of a fresh install and sends it with the install, so Google Ads can measure the install without an advertising identifier. The info carries no device identifier and is sent regardless of consent. There is nothing to call: add Google's library and set up the Google Ads integration in the dashboard. **With Swift Package Manager, reference the library once in your code** (for example `_ = ConversionManager.sharedInstance.versionString`), otherwise the linker can drop it; with `isDebug = true` the SDK logs when it cannot find it. `-ObjC` in Other Linker Flags works too, but with Google Mobile Ads added through Swift Package Manager it then also needs `JavaScriptCore.framework`. To turn the feature off, set `Adshift.shared.googleOnDeviceMeasurement = .disabled` before `start()`, or `GOOGLE_ADS_ON_DEVICE_CONVERSION_EVENT_DATA_ENABLED` to `NO` in `Info.plist`. Google notes that you have the option to display a prominent link in your disclosures to make clear how Google uses information from apps that use its services ([Google Ads Help](https://support.google.com/google-ads/answer/12119136)).
- **`setGoogleOnDeviceMeasurementInfo(_:)`** — for apps that call Google's library themselves: pass the info it returned. `Adshift.shared` is main-actor isolated, so take `let adshift = Adshift.shared` on the main thread; `adshift.setGoogleOnDeviceMeasurementInfo(info)` can then be called from any thread, such as the library's completion. Passed before `start()`, the SDK does not ask the library itself; passed later, the info goes with the install if it has not been sent yet, otherwise with the next app open, unless an info has already gone out for this install.
- **Two event fields** — `google_odm_info` and `google_odm_state`, on the install, or on one app open when the info arrives after the install.
- **A debug log for missing postback keys** — with `isDebug = true`, `start()` logs when `Info.plist` lacks `NSAdvertisingAttributionReportEndpoint` or `AttributionCopyEndpoint`. Without the first, Apple sends AdShift no copy of the app's SKAdNetwork postbacks; without the second, a top-level key, no copy of its AdAttributionKit postbacks (iOS 17.4 and later). Both take the bare domain, `https://adshift.com`.

### Changed
- **Apps with Firebase Analytics 11.14 or later** — Firebase already contains Google's library, so after updating to 2.4.0 the SDK starts asking it on fresh installs, with no code change. The library shipped in Firebase 12.11.0–12.12.0 (3.4.x) has a known crash and is not called; a later Firebase fixes it. Use `.disabled` to opt out.
- **Call `start()` in the app's first session** — Google's library needs the moment the app was first launched, and the SDK gives it the start of the first launch in which `start()` runs. Postponing `start()` to a later session reports a later first launch.
- **`start()` completes after the local set-up** — it no longer waits for the ATT answer, for the install to be built or for the SKAN configuration. On a first launch 2.2.0 waited for all three: with `waitForATTBeforeStart` for the ATT answer, then for the install, and on iOS 16.1 and later for the SKAN configuration fetch, up to about 33 seconds when the endpoint did not answer. The configuration is now fetched in the background: neither `start()`'s completion, nor the deferred deep link lookup, nor the install waits for it, and events tracked before it arrives count towards the conversion value, which goes out once it is there. A fetch that fails is tried again when the network comes back and when the app returns to the foreground, while the first SKAN window is open, and at every later `start()`; an app with no published configuration is asked about once per launch. Later launches use the cached configuration, which is kept in the Keychain and survives a reinstall.
- **`waitForATTBeforeStart` holds event delivery, not `start()`** — `start()` no longer waits for the ATT answer, and events are recorded as usual; their delivery waits for the answer, up to `attTimeoutMs`. The wait happens once per install and counts only while the app is in the foreground.
- **The install is registered for attribution with a conversion value update** — once, on its first launch, through `updatePostbackConversionValue(0, coarseValue: .low, lockWindow: false)` on iOS 16.1 and later (`updatePostbackConversionValue(0)` on iOS 15.4 to 16.0, `registerAppForAdNetworkAttribution()` before that), instead of the deprecated `registerAppForAdNetworkAttribution()` alone. AdAttributionKit receives that call too, so on iOS 17.4 and later the install's AdAttributionKit window opens as well; add `AttributionCopyEndpoint` to `Info.plist` to receive copies of those postbacks. Conversion value updates wait for the registration to settle, at most 10 seconds. An install that first ran an earlier SDK version is not registered again, so a value it already sent is not reset. On iOS 16.1.0, whose StoreKit lacks the `lockWindow` call, the SDK checks for the selector first, sends the fine value only and skips the window 2 and 3 updates.
- **A reinstall after the earlier SKAN cycle has ended starts a new one** — when the app is installed again more than 35 days after the earlier install's first launch, all of that install's windows have closed and Apple measures the redownload as a new conversion. The SDK registers again, counts from zero and sends values for the new windows; before, such a reinstall sent no value at all, because its windows looked closed. A reinstall inside those 35 days continues the earlier cycle, as before.
- **Queued events older than 7 days are dropped** — AdShift's gateway refuses an event that waited on the device for more than 7 days between tracking and sending, so the SDK no longer sends one and logs the drop at info level. The install is sent at any age.

### Fixed
- **Events no longer reach AdShift before the install** — on a first launch, event delivery is held from the top of `start()` until the install is queued, so the install goes first. The install waits, for at most 2.5 seconds, for Apple's attribution token and Google's conversion info, and an event tracked meanwhile, right after `start()`, used to be delivered first, before AdShift knew of the install. Server-to-server clicks are not held, and launches after the install is queued are not affected.
- **`track()` awaited right after `start()` no longer loses the event** — `start()` hands its work to a task on the main actor, so an `await track()` in the same main-actor code, for example in an async method of a view model, ran before it, failed with `notStarted` and the event was gone; tracking from a new `Task` was the workaround. Such a call now waits for `start()`'s first checks and is then accepted, or refused when the API key is missing or tracking is disabled. An event tracked without any `start()` call is still refused. The bug was present in 2.2.0.
- **Events tracked before the SKAN configuration arrives count** — they used to be left out of the conversion value when the configuration was not there yet. They now count, one at a time and in order, and the value they make goes out once the configuration is there; revenue tracked meanwhile is converted with the configuration's rates when it arrives.
- **AdShift's attribution answer reaches Apple reliably** — the window 1 conversion value carries whether AdShift attributed the install to a paid campaign, which the SDK asks AdShift about after the install. That answer could stick or come from a previous install: a provisional "pending" was stored, the stored answer survived a reinstall, and the asking ended with the first session. Now nothing provisional is stored, "not attributed" is final only once a second check ten minutes later confirms it, an answer written before this install's first launch is ignored, and the asking resumes when the app returns to the foreground and at later launches while the first window is open, backing off while the endpoint is unavailable or asks the SDK to wait. Once the answer is final, the value is sent again at each start and foreground, in case the launch that learned it ended before its update landed.
- **Conversion value updates go out in order** — one StoreKit call at a time for the whole process, and a value that does not beat the last one sent for its window is skipped, so an older, lower value can no longer land last.
- **SKAN on a locked device, and after `stop()`** — a launch while the device is locked, before its first unlock, sets SKAN up once it is unlocked or the app next becomes active, exactly once, and keeps the launch's first-install decision across a kill or a `stop()`/`start()`. `stop()` cancels a SKAN set-up or attribution request still running, and no conversion value update goes out after it.

### Upgrading
- Swift Package Manager: `from: "2.4.0"`. CocoaPods: `pod 'AdshiftSDK', '~> 2.4'`. Xcode 16.1 or later.
- Add `AttributionCopyEndpoint` next to `NSAdvertisingAttributionReportEndpoint` in `Info.plist`; see the [installation guide](https://dev.adshift.com/docs/ios-sdk/installation).
- If your code took `start()`'s completion for the moment ATT was answered, or tracked from a new `Task` to work around the `notStarted` race, neither is needed now.
- Google on-device conversion measurement is on in apps that ship Google's library or Firebase Analytics 11.14 or later; review your disclosures or set `.disabled`.

## [2.2.0] - 2026-09-15

### Changed
- **Non-GDPR users no longer report granted consent** — `forNonGDPRUser()` and `consentNotRequired()` state the scope and nothing else; the three consent flags come back as `nil` and go on the wire unset. **This supersedes the 2.0.0 note that said these flags report as granted**, so if you followed that note and branched on them, read this one. Nothing changes about what is gated: outside GDPR scope nothing was ever gated on those flags, and `isConsentGranted()` still answers `true`. The old values were a record claiming a consent nobody had collected, which is why they are gone. If you do collect consent outside GDPR scope and want it on record, state it with the `AdShiftConsent` initialiser, now public.
- **A link the user opened the app with always wins** — a deferred result no longer replaces it, whether or not that result has a destination of its own. Previously a deferred answer that arrived second overwrote the link the app was launched from.
- **"No deferred deep link" is delivered rather than only logged** — on the launch after an install that had no click before it, `onDeepLinkReceived` receives `status == .notFound` with `isDeferred == true`, so that case is no longer indistinguishable from a lookup still in flight. The same answer arrives when tracking authorization is denied or restricted, where there is no identifier to look anything up with. It is delivered at most once per launch and never after a destination, so an app that routes on every result is not sent back.

### Added
- **IAB GPP consent is forwarded** — a GPP string written by your CMP is read and sent with your events once you call `enableGPPDataCollection(true)`. It travels on its own axis, alongside a GDPR decision rather than instead of one, so an app that sets European consent by hand still forwards what its CMP wrote for US users. Every section the CMP wrote is forwarded, national and state alike.
- **Third-party sharing is a separate answer** — `setThirdPartySharing(AdShiftThirdPartySharing.optedOut())` records that the user asked you not to share their data onward, and `clearThirdPartySharing()` withdraws the declaration. Mind the polarity, which is the reverse of a consent flag: saying nothing means sharing is allowed, so `allowed()` is a statement you made, not a default to set at startup. The declaration is stored and reapplied on the next launch.
- **A snapshot tells "no CMP" apart from "a CMP nobody answered"** — `ConsentSnapshot.cmpDetected` reports whether a CMP is installed at all, independently of whether it has published a usable answer and of which axes you enabled. `cmpDetected == true` with no string means the user has not answered yet and will; `false` means no CMP is writing, which is worth checking against your integration.
- **`consentRequired` and `consentNotRequired`** — the same two factories as `forGDPRUser` and `forNonGDPRUser`, under names that say what they decide. The old names keep working.
- **The `AdShiftConsent` initialiser is public** — you can state scope and flags directly instead of going through a factory, which is what makes consent collected outside GDPR scope expressible.

### Removed
- **Types that were never meant to be callable are no longer public** — the SDK now carries a record of its public API, and setting it up showed that 28 of its 41 public types were public because of how the module is put together, not because an app needs them. They are internal as of this release. Nothing removed here appears in any documented signature; if you had reached for one, the compiler says so immediately.

  Two of them are worth calling out, because their absence is likely to help rather than hurt: importing the SDK used to put `Formatter` and `Logger` into your app at top level, contesting the names `Foundation` and `OSLog` use. Along with them went `Level`, `Theme`, `Component`, and the SKAN configuration models `Window1`, `Window2`, `Window3`, `Windows`, `W1Fine`, `LockBy`, `LockConfig`, `LockWindow`, `CoarseRule`, `FineRule`, `AnyCodable`, `CurrencyRates`, `SSOTConfig` and their neighbours, none of which the SDK ever accepted or returned. The wire event model and the networking protocol went with them.

  What stays public is what you call the SDK with: `Adshift`, `AdShiftConsent`, `AdShiftThirdPartySharing`, `ConsentSnapshot`, `ASInAppEventType`, `ASInAppEventParameterName`, `ASAdRevenueData`, `ASMediationNetwork`, the deep link result types and `AdShiftError`.

### Fixed
- **The privacy report lists two more data types** — the SDK's privacy manifest now declares `User ID` and `Advertising Data`. `User ID` covers the identifier you set with `setCustomerUserId`. `Advertising Data` covers ad revenue reported through `logAdRevenue` and also the campaign details and Apple attribution token that installs and app opens carry on their own, so treat it as collected by default. Check your App Privacy answers against the regenerated report.
- **A deferred result says that it is deferred** — a deep link resolved after install now carries `isDeferred` and `status` (`found` or `notFound`), the same two fields a direct link has always carried, instead of leaving both unset. A result that routes only through `deep_link_sub1`–`deep_link_sub5`, with no `deep_link_value`, counts as `found`. Code that inferred either field from the presence of a value can read them directly.

## [2.0.1] - 2026-09-10

### Fixed
- **Deep link listeners stay registered** — a closure passed to `onDeepLinkReceived` receives every subsequent deep link result, not only the first one; the most recent result is still delivered immediately on registration.

## [2.0.0] - 2026-09-10

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
