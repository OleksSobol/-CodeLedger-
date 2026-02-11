# CodeLedger Package Dependencies

## Runtime Dependencies
| Package | Version | Purpose |
|---|---|---|
| flutter_riverpod | ^2.6.1 | State management |
| riverpod_annotation | ^2.6.1 | Code-gen annotations for Riverpod |
| drift | ^2.28.2 | SQLite ORM |
| drift_flutter | ^0.2.7 | Flutter platform integration for Drift |
| sqlite3_flutter_libs | ^0.5.41 | Native SQLite3 binaries |
| go_router | ^17.1.0 | Declarative routing |
| pdf | ^3.11.3 | PDF generation |
| printing | ^5.14.2 | PDF preview/print |
| flutter_email_sender | ^8.0.0 | Device email client |
| share_plus | ^12.0.1 | System share sheet (email fallback) |
| csv | ^6.0.0 | CSV export |
| excel | ^4.0.6 | XLSX export |
| google_sign_in | ^7.2.0 | Google auth for Drive |
| googleapis | ^16.0.0 | Google Drive API |
| googleapis_auth | ^2.0.0 | Google auth helpers |
| http | ^1.6.0 | HTTP client for googleapis |
| cryptography | ^2.9.0 | AES-256-GCM + PBKDF2 encryption |
| intl | ^0.20.2 | Date/number formatting |
| image_picker | ^1.2.1 | Logo image selection |
| flutter_colorpicker | ^1.1.0 | Project color picker |
| path_provider | ^2.1.5 | App documents directory |
| path | ^1.9.1 | Path manipulation |
| freezed_annotation | ^2.4.4 | Immutable data classes |
| json_annotation | ^4.9.0 | JSON serialization |
| equatable | ^2.0.8 | Value equality |
| collection | ^1.19.1 | Collection utilities |

## Dev Dependencies
| Package | Version | Purpose |
|---|---|---|
| build_runner | ^2.5.4 | Code generation runner |
| drift_dev | ^2.28.0 | Drift code generator |
| riverpod_generator | ^2.6.4 | Riverpod code generator |
| freezed | ^2.5.8 | Freezed code generator |
| json_serializable | ^6.9.5 | JSON code generator |
| mocktail | ^1.0.4 | Mocking for tests |

## Code Generation
Run after changing tables, DAOs, providers, or freezed classes:
```bash
dart run build_runner build --delete-conflicting-outputs
```
