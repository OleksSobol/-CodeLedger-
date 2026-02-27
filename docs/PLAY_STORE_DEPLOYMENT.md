# CodeLedger — Google Play Store Deployment Guide

## Pre-Deployment Checklist

### 1. App Signing (REQUIRED)

The app currently uses debug keys. You must create a production keystore before publishing.

**Generate keystore:**
```bash
keytool -genkey -v -keystore codledger-release.keystore -alias codledger -keyalg RSA -keysize 2048 -validity 10000
```

**Create `android/key.properties`** (DO NOT commit this file):
```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=codledger
storeFile=../../codledger-release.keystore
```

**Add to `.gitignore`:**
```
android/key.properties
*.keystore
*.jks
```

**Update `android/app/build.gradle.kts`** — replace the release signing config:
```kotlin
// Add before android { block:
val keystoreProperties = java.util.Properties()
val keystoreFile = rootProject.file("key.properties")
if (keystoreFile.exists()) {
    keystoreProperties.load(java.io.FileInputStream(keystoreFile))
}

android {
    // ... existing config ...

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it as String) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

> **CRITICAL**: Back up the keystore file somewhere safe (USB drive, password manager). If you lose it, you cannot push updates to the same Play Store listing.

---

### 2. Build the Release Bundle

Play Store requires AAB (Android App Bundle), not APK:

```bash
# Clean first
flutter clean

# Regenerate code
dart run build_runner build --delete-conflicting-outputs

# Build release bundle
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

The build number auto-increments each build (via the Gradle task in build.gradle.kts). Every upload to Play Store must have a higher `versionCode` than the previous one.

---

### 3. Google Play Console Setup

#### a) Developer Account
- Register at https://play.google.com/console
- One-time $25 registration fee
- Requires valid ID verification

#### b) Create App Listing

| Field | Value |
|-------|-------|
| App name | CodeLedger |
| Default language | English (US) |
| App or Game | App |
| Free or Paid | Free (or Paid if you charge) |
| Category | Productivity / Business |

#### c) Store Listing Content

**Short description** (80 chars max):
```
Offline time tracking & invoicing for freelance developers.
```

**Full description** (4000 chars max):
```
CodeLedger is an offline-first time tracking and invoicing app built for freelance developers and contractors.

Key Features:
- Clock in/out timer with client and project assignment
- Manual time entry for past work
- Multi-client and multi-project management
- Professional PDF invoice generation with customizable templates
- Export timesheets to CSV and Excel
- Google Drive encrypted backup
- Track hourly rates per client with automatic earnings calculation
- Tag and categorize time entries by repository and issue reference
- Dark mode support

Your data stays on your device. No accounts, no cloud dependency, no subscriptions. Optional Google Drive backup with AES-256-GCM encryption for peace of mind.

Built by a developer, for developers.
```

#### d) Screenshots Required

| Type | Requirement |
|------|-------------|
| Phone screenshots | 2-8 screenshots, 16:9 or 9:16, min 320px, max 3840px |
| 7-inch tablet | Optional but recommended |
| 10-inch tablet | Optional but recommended |

**Recommended screenshots to capture:**
1. Dashboard with active timer and summary cards
2. Time entries list with entries grouped by date
3. Clock-in sheet with client/project selection
4. Invoice PDF preview
5. Client detail page with billing summary
6. Settings page / template designer
7. Export options (CSV/Excel)
8. Google Drive backup page

**Tip:** Use a clean device/emulator, populate with realistic sample data, and capture in both light and dark mode.

#### e) App Icon

| Asset | Spec |
|-------|------|
| Hi-res icon | 512x512 PNG, 32-bit, no alpha |

The adaptive icon is already configured (`#00897B` teal background). Export a 512x512 version of the app icon for the Play Store listing.

#### f) Feature Graphic
- 1024 x 500 PNG or JPG
- Displayed at the top of the store listing
- Design a banner showing the app name, tagline, and a device mockup

---

### 4. Privacy Policy (REQUIRED)

Google Play requires a privacy policy URL. Since CodeLedger is offline-first with no backend, the policy is straightforward. Host it on a simple web page (GitHub Pages, your domain, etc.).

**Key points to include:**
- App stores all data locally on device
- No data is collected or transmitted to any server
- Optional Google Drive backup is user-initiated and encrypted (AES-256-GCM)
- Google Sign-In is used solely for Drive backup authorization — no profile data is stored
- No analytics, no tracking, no ads
- Contact email for questions

**Hosting options:**
- GitHub Pages (free) — create a `privacy-policy.md` in a GitHub repo
- Your own domain at `osobol.com/codledger/privacy`
- Firebase Hosting (free tier)

---

### 5. Content Rating

Complete the content rating questionnaire in Play Console:
- Violence: None
- Sexuality: None
- Language: None
- Controlled substance: None
- ESRB: Everyone / PEGI 3

---

### 6. Data Safety Section

Play Console requires a Data Safety form. For CodeLedger:

| Question | Answer |
|----------|--------|
| Does your app collect or share user data? | No data shared with third parties |
| Data collected | None collected by developer |
| Is data encrypted in transit? | N/A (no transit) — backup uses AES-256-GCM |
| Can users request data deletion? | Yes (uninstall deletes all data, or delete within app) |
| Google Sign-In data | Authentication only, no profile data stored |

**Data types to declare:**
- Financial info (invoices, rates) — Stored locally only, not collected
- Files/docs (PDF invoices) — Generated locally, not collected

---

### 7. Permissions Declaration

The app currently declares no permissions in the main manifest. Verify at runtime:
- `INTERNET` — Only in debug/profile builds (for hot reload). Not in release.
- No storage permissions needed (uses app-scoped storage)
- Google Sign-In handles its own auth flow

If you add features later (camera for receipts, notifications, etc.), update this section.

---

### 8. Testing Before Release

```bash
# Run all tests
flutter test

# Analyze for issues
dart analyze lib

# Build release APK for local testing
flutter build apk --release

# Install on physical device
adb install build/app/outputs/flutter-apk/app-release.apk
```

**Manual test checklist:**
- [ ] Clock in/out works correctly
- [ ] Manual time entry saves properly
- [ ] Create client, edit client, delete/archive client
- [ ] Create project under client
- [ ] Generate invoice PDF — verify it opens and looks correct
- [ ] Export CSV and Excel — verify file is created and shareable
- [ ] Google Drive backup — sign in, backup, restore
- [ ] Template designer — change colors, toggles, verify PDF updates
- [ ] Settings — theme toggle, business profile, version displays correctly
- [ ] Dark mode — all pages render properly
- [ ] Rotate device — no crashes, layout adapts
- [ ] Kill app and reopen — data persists
- [ ] Edge cases: overlapping time entries blocked, invoiced entries locked

---

### 9. Release Tracks

| Track | Purpose |
|-------|---------|
| Internal testing | Up to 100 testers, instant publish |
| Closed testing | Invite-only, good for beta |
| Open testing | Anyone can join via link |
| Production | Public on Play Store |

**Recommended rollout:**
1. Upload AAB to **Internal testing** first
2. Test on multiple devices (different Android versions, screen sizes)
3. Fix any issues, rebuild, re-upload
4. Promote to **Production** when confident

---

### 10. Version Strategy

| Component | How it works |
|-----------|-------------|
| `version` in pubspec.yaml | `MAJOR.MINOR.PATCH+BUILD` e.g. `1.0.0+15` |
| `MAJOR.MINOR.PATCH` | Bump manually for releases (1.0.0 → 1.1.0) |
| `+BUILD` | Auto-incremented by Gradle on every build |
| `versionCode` (Play Store) | Must increase with every upload — the `+BUILD` number |
| `versionName` (Display) | The `MAJOR.MINOR.PATCH` shown to users |

---

## Quick Reference — Build & Upload

```bash
# 1. Ensure code is generated and clean
dart run build_runner build --delete-conflicting-outputs
dart analyze lib
flutter test

# 2. Build release bundle (build number auto-increments)
flutter build appbundle --release

# 3. Upload to Play Console
# → Go to Play Console → Release → Production → Create new release
# → Upload build/app/outputs/bundle/release/app-release.aab
# → Add release notes
# → Review and roll out
```

---

## Files Reference

| File | Purpose |
|------|---------|
| `android/key.properties` | Keystore credentials (create this, don't commit) |
| `codledger-release.keystore` | Signing key (create this, back it up) |
| `android/app/build.gradle.kts` | Build config, signing, auto-increment |
| `pubspec.yaml` | Version source of truth |
| `android/app/src/main/AndroidManifest.xml` | App manifest |
| `assets/images/app_icon.png` | Launcher icon source |
