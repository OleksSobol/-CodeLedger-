# CodeLedger Implementation Phases

## Phase 1: Foundation ✅ COMPLETE
- [x] `flutter create --org com.osobol`
- [x] Folder structure (clean architecture)
- [x] pubspec.yaml with all dependencies
- [x] 8 Drift table definitions
- [x] AppDatabase with migrations + seed (3 templates + default profile)
- [x] 7 DAO classes
- [x] Riverpod database provider
- [x] GoRouter config
- [x] App theme (light + dark, Material 3, seed color 0xFF1565C0)
- [x] main.dart + app.dart entry points
- [x] build_runner generates all .g.dart files
- [x] `dart analyze lib/` — 0 issues

**Verify:** `flutter run` launches app, DB created with seed data

## Phase 2: Core CRUD
- [x] User Profile page — all payment fields + visibility toggles
- [x] Clients CRUD — list, add, edit, archive + computed summaries
- [x] Projects CRUD — linked to clients
- [x] Invoice templates seeding already done (Phase 1)
- [x] Rate resolver utility already done (Phase 1)

**Verify:** CRUD works for profile/clients/projects, visibility toggles save

## Phase 3: Time Tracking ✅ COMPLETE
- [x] Timer provider with persistence across app kills
- [x] Clock in/out with overlap detection
- [x] Manual entry with GitHub issue ref + repository + tags
- [x] Time entries list (filterable: client, project, date, invoiced status)
- [x] Daily, weekly, monthly summaries
- [x] Uninvoiced hours view

**Verify:** Clock in/out works, timer survives restart, overlaps rejected

## Phase 4: Dashboard ✅ COMPLETE
- [x] Active timer card (project/client name + elapsed time)
- [x] Uninvoiced hours per client cards
- [x] This month's total income (sum of paid invoices)
- [x] Outstanding invoices (count + total of sent/unpaid)
- [x] Overdue invoices (count + total past due date)

**Verify:** Dashboard shows live data for all 5 summary cards

## Phase 5: Invoice Builder ✅ COMPLETE
- [x] Creation wizard: client → mode (date range/project/all uninvoiced) → entries → review
- [x] Detailed breakdown mode (group by date) vs summary mode (single line)
- [x] Manual line items, tax calculation, late fee calculation
- [x] Invoice numbering (auto-increment), due date auto-calc from payment terms
- [x] Status management: Draft → Sent → Paid → Overdue
- [x] Payment recording (method: ACH/Stripe/Other, amount, partial support)
- [x] Mark entries as invoiced in same transaction

**Verify:** Invoice generates, numbering increments, payment recording works

## Phase 6: PDF Generation ✅ COMPLETE
- [x] Base abstract template + 3 implementations
  - Minimal: clean single-line
  - Detailed Breakdown: grouped by date, session descriptions + issue refs
  - Modern Developer: tech-focused, repo/issue refs prominent
- [x] Payment section: ACH details + optional Stripe link
- [x] Payment terms + late fee clause rendering
- [x] PDF preview, save locally, store path in DB

**Verify:** PDF renders with all 3 templates, payment section correct

## Phase 7: Work Reports
- [x] Non-financial PDF report generator
- [x] Date range, grouped by date
- [x] Shows: hours, description, GitHub issue ref, repository
- [x] No pricing info (safe for project managers)

**Verify:** Report PDF generates without financial data

## Phase 8: Email & Export
- [ ] Email with PDF attachment via `flutter_email_sender`
- [ ] Subject from `defaultEmailSubjectFormat` (e.g. "Invoice #102 – Jan 2026")
- [ ] Body with payment instructions from profile
- [ ] Fallback to `share_plus` if no email client
- [ ] CSV/XLSX time entry export (date range, client/project/issue/repo)
- [ ] Monthly/yearly income summaries

**Verify:** Email opens with attachment, CSV/XLSX exports work

## Phase 9: Backup & Restore
- [ ] EncryptionService: AES-256-GCM + PBKDF2 (100k iterations)
- [ ] File format: salt(32B) + nonce(12B) + MAC(16B) + ciphertext
- [ ] Google Sign-In + Drive integration (`/CodeLedger/` folder)
- [ ] Naming: `codeledger_backup_YYYYMMDD_HHmmss.enc`
- [ ] Backup/restore flow with passphrase
- [ ] `PRAGMA integrity_check` before overwrite on restore
- [ ] Optional automatic daily backup

**Verify:** Backup encrypts + uploads, restore works

## Phase 10: Polish
- [ ] Unit/widget/integration tests
- [ ] Empty states, error handling, loading states
- [ ] Edge cases (midnight spanning, timezones)
- [ ] Dark mode refinement
- [ ] App icon, splash screen
- [ ] Fast clock-in UX optimization

**Verify:** `flutter test` passes
