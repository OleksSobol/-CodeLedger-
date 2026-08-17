# CodeLedger — System Report
*Snapshot: 2026-05-19 (pre-redesign baseline)*

---

## Stack

| Layer | Tech |
|-------|------|
| UI | Flutter 3.x, Material Design 3 |
| State | Riverpod v3 (AsyncNotifier, StreamProvider) |
| DB (native) | Drift + SQLite via `sqlite3_flutter_libs` |
| DB (web) | Drift + sqlite3.wasm + drift_worker.js (IndexedDB) |
| Auth (web) | Google Sign-In v7 — `renderButton()` + `authenticationEvents` |
| Auth (native) | Google Sign-In v7 — native flow |
| Backup encryption | AES-256-GCM, PBKDF2-HMAC-SHA256 |
| CI/CD | GitHub Actions → `flutter build web` → ghcr.io Docker → nginx |

---

## Features

### Dashboard (`/`)
Active Timer Card, Financial Summary Row (monthly income / outstanding / overdue), Quick Actions, Recent Activity, Uninvoiced Hours, Weekly Hours Summary. Responsive: max-width 960px on wide screens.

### Time Tracking (`/time-tracking`)
Entry list + date/client/tag filters, multi-timer support, Clock In, Manual Entry, Edit Entry, GitHub Issue Sync, CSV export, configurable field layout.

### Invoices (`/invoices`)
Status filter (All/Draft/Sent/Paid/Overdue/Archived), invoice wizard (from time entries), manual invoice, detail + line item editing, PDF generation + share, bulk email send, 3 built-in PDF templates (Minimal, Detailed, Modern Developer), custom template editor.

### Reports (`/reports`)
Timesheet PDF, Work Report PDF (grouped by day + issue refs), CSV export, Tax/Income summary, WA Excise (B&O) quarterly DOR-format CSV.

### Profile/Settings
Business info, tax info, bank details, payment links, invoice defaults, number prefix + counter, backup passphrase, theme (System/Light/Dark), default landing page, multi-company clock toggle, GitHub PAT.

### Backup (`/backup`)
- Native: create encrypted backup → share; restore from file; Google Drive sign-in + upload/download/list/delete
- Web: both local and Drive sections show "not available on web" placeholder
- All platforms: Erase All Data (DB wipe + reseed)

### GitHub Sync
Links GitHub commits (Issue-* branches) to time entries. Uses PAT + username. Preview page shows matches before applying.

---

## Web Status (per feature)

| Feature | Web |
|---------|-----|
| Auth gate | ✅ Google Sign-In via renderButton + authenticationEvents |
| Dashboard | ✅ |
| Time Tracking | ✅ (SQLite WASM) |
| Invoices | ✅ |
| PDF generation | ⚠️ Untested |
| CSV / file export | ⚠️ SharePlus web behavior untested |
| GitHub Sync | ✅ (pure HTTP) |
| Profile / Settings | ✅ |
| Local file backup | ❌ Hidden (dart:io incompatible) |
| Google Drive backup | ❌ Hidden (dart:io incompatible) |
| Erase All Data | ✅ |

---

## Database Schema (v4, Drift)

| Table | Notes |
|-------|-------|
| `user_profiles` | Singleton row; businessName, defaultHourlyRate, invoiceNumberPrefix, nextInvoiceNumber |
| `clients` | name unique; hourlyRate, currency, taxRate, isArchived |
| `projects` | name unique per client; githubRepo, isArchived |
| `time_entries` | startTime, endTime, durationMinutes, isInvoiced, tags (JSON) |
| `invoices` | invoiceNumber unique; status, subtotal, taxAmount, total, amountPaid |
| `invoice_line_items` | sortOrder, quantity, unitPrice, timeEntryId, issueReference |
| `invoice_templates` | templateKey unique; 3 built-in (minimal, detailed, modern_developer) |
| `app_settings` | KV store: theme_mode, default_landing_route, multi_timer_enabled, github_pat, github_username, backup passphrase |

Migrations: v2 (line_item_display_mode, issue_reference), v3 (github_repo), v4 (show_description on templates)

---

## CI/CD Pipeline

Trigger: push to `main`
1. Flutter pub get
2. Create google_credentials.dart stub (injects `GOOGLE_WEB_CLIENT_ID` secret)
3. build_runner
4. Download sqlite3.wasm (version from pubspec.lock)
5. dart compile js drift_worker.dart
6. flutter build web --release
7. Docker build → push ghcr.io/olekssobol/codeledger:latest + :sha

Required secret: `GOOGLE_WEB_CLIENT_ID`

---

## Known Issues (pre-redesign)

1. PDF/CSV export on web — untested
2. Local backup both directions blocked on web (dart:io)
3. Drive backup blocked on web
4. No sign-out button on web
5. Data is per-browser (IndexedDB) — no cross-device sync
6. Google 401 on fresh deploy until domain added to Cloud Console OAuth client
7. Single account only — no multi-user
