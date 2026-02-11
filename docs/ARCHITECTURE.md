# CodeLedger Architecture

## Overview
Offline-first time tracking & invoicing Flutter app for freelance developers.
- **Org**: com.osobol
- **Platforms**: Android (primary), iOS, Web, Windows
- **Database**: SQLite via Drift (WAL mode, foreign keys)
- **State**: Riverpod (not Bloc)
- **Routing**: GoRouter
- **No backend** — fully local, Google Drive backup only

## Project Root
`e:\workspace\personal_projects\webtimeclock\code_ledger\`

## Key Architectural Decisions
1. **Riverpod over Bloc** — less boilerplate, no BuildContext needed for isolate work (PDF, backup)
2. **Drift reactive streams** → `StreamProvider` / `AsyncNotifierProvider`
3. **Clean Architecture** — feature-first: data/domain/presentation layers per feature
4. **Strategy Pattern** for invoice PDF templates
5. **Rate cascade**: project override → client rate → profile default
6. **Payment terms cascade**: client override → profile default

## Folder Structure
```
lib/
├── main.dart                           # Entry point, ProviderScope
├── app.dart                            # MaterialApp.router
├── core/
│   ├── constants/                      # app_constants, invoice_status, payment_terms
│   ├── database/
│   │   ├── app_database.dart           # @DriftDatabase, migrations, seed
│   │   ├── tables/                     # 8 table definitions
│   │   └── daos/                       # 7 DAO classes
│   ├── encryption/                     # AES-256-GCM + PBKDF2
│   ├── providers/                      # database_provider.dart
│   ├── router/                         # GoRouter config
│   ├── theme/                          # Light + dark Material 3
│   └── utils/                          # rate_resolver, currency/duration formatters
├── features/
│   ├── dashboard/                      # Home: timer, uninvoiced, income, outstanding
│   ├── profile/                        # Business info + payment config
│   ├── clients/                        # Client CRUD + summaries
│   ├── projects/                       # Project CRUD
│   ├── time_tracking/                  # Timer, manual entry, summaries
│   ├── invoices/                       # Builder, payment tracking
│   ├── pdf_generation/                 # 3 templates (minimal, detailed, modern)
│   ├── reports/                        # Non-financial work reports
│   ├── email/                          # Device email client
│   ├── export/                         # CSV, XLSX, PDF
│   ├── backup/                         # Google Drive encrypted
│   └── settings/                       # App settings, dark mode
└── shared/
    ├── widgets/
    └── extensions/
```

## Data Flow
```
UI Widget
  ↓ reads via ref.watch(provider)
Riverpod Provider (StreamProvider / AsyncNotifierProvider)
  ↓ calls
DAO (Drift DatabaseAccessor)
  ↓ queries
SQLite (via Drift, WAL mode)
```

## Build Commands
```bash
# Generate Drift/Riverpod/Freezed code
dart run build_runner build --delete-conflicting-outputs

# Analyze
dart analyze lib/

# Run
flutter run

# Test
flutter test
```
