# CodeLedger

Offline-first time tracking and invoicing app for freelance developers. Built with Flutter, backed by local SQLite via Drift, with encrypted Google Drive backups.

> **Latest release:** [v1.1.0](https://github.com/OleksSobol/-CodeLedger-/releases/tag/v1.1.0)

## Features
- **Time tracking** — Clock in/out timer with overlap detection, GitHub issue references, project tagging
- **Client & project management** — Archive/restore clients, per-client hourly rate and tax rate
- **Invoicing** — Create, edit, and send invoices; draft editing; mark paid/archived
- **PDF templates** — 3 built-in templates: Minimal, Detailed Breakdown, Modern Developer
- **Reports** — Tax/Income report (PDF + CSV), Timesheet, Work Report; optional archived invoice inclusion
- **Encrypted backups** — AES-256-GCM encrypted backups to local storage or Google Drive
- **Data management** — Erase all data with double-confirmation (passphrase preserved)
- **Dark mode** — System/Light/Dark theme switcher

## Tech Stack
- **Flutter** (Android, iOS, Web, Windows)
- **Drift** — SQLite ORM with reactive streams
- **Riverpod** — State management
- **GoRouter** — Navigation
- **pdf** / **printing** — Invoice PDF generation

## Setup

### Prerequisites
- Flutter SDK ≥ 3.9.2
- Android Studio or VS Code with Flutter extension
- For Android: Android SDK, USB debugging enabled on device

### Install & Run
```bash
cd code_ledger

# Install dependencies
flutter pub get

# Generate Drift/Riverpod/Freezed code
dart run build_runner build --delete-conflicting-outputs

# Run on connected device or emulator
flutter run
```

### Build APK for Android Phone
```bash
# Debug APK (fast, larger size, includes dev tools)
flutter build apk --debug

# Release APK (optimized, smaller, no dev tools)
flutter build apk --release

# The APK will be at:
# build/app/outputs/flutter-apk/app-debug.apk
# build/app/outputs/flutter-apk/app-release.apk
```

### Install APK on Phone
```bash
# With USB connected and USB debugging enabled:
flutter install

# Or manually transfer the APK file and open it on the phone
# (enable "Install from unknown sources" in Android settings)

# Or use adb directly:
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Run on Phone via USB (Development)
```bash
# 1. Enable Developer Options on your Android phone:
#    Settings → About Phone → tap "Build Number" 7 times
#
# 2. Enable USB Debugging:
#    Settings → Developer Options → USB Debugging → ON
#
# 3. Connect phone via USB, accept the debugging prompt
#
# 4. Verify device is detected:
flutter devices

# 5. Run the app on your phone:
flutter run
```

## Project Structure
See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for full architecture details.

```
lib/
├── main.dart / app.dart          # Entry points
├── core/                         # Database, theme, routing, utils
└── features/                     # Feature modules (clean architecture)
    ├── dashboard/
    ├── profile/
    ├── clients/
    ├── projects/
    ├── time_tracking/
    ├── invoices/
    ├── pdf_generation/
    └── ...
```

## Documentation
- [Architecture](docs/ARCHITECTURE.md)
- [Database Schema](docs/DATABASE_SCHEMA.md)
- [DAO Reference](docs/DAO_REFERENCE.md)
- [Business Logic](docs/BUSINESS_LOGIC.md)
- [Implementation Phases](docs/IMPLEMENTATION_PHASES.md)
- [Packages](docs/PACKAGES.md)
