# CodeLedger — Full Redesign Plan
*Decisions locked: 2026-05-19*

---

## Context

CodeLedger currently runs as a pure client-side app: SQLite via Drift on native, SQLite WASM on web.
Goals for the redesign:
- **Cloud backend**: Supabase (PostgreSQL + RLS) as shared source of truth
- **Web**: drop SQLite WASM, call Supabase directly
- **Mobile (Android)**: stay offline-first (local Drift/SQLite) + sync to Supabase
- **Auth**: Supabase Auth with Google provider — replaces current dual `GoogleSignIn` setup
- **Per-user isolation**: Supabase Row Level Security (each row carries `user_id = auth.uid()`)
- **Multi-user growth path**: schema is ready for teams; UI stays single-user for now
- **UI/UX**: full visual + layout overhaul (direction TBD — get design references before Phase 6)
- **Web feature parity**: backup, PDF, CSV export via browser + Supabase Storage

---

## Architecture Target

```
┌──────────────────────────────────────────────────────────────┐
│                     Flutter App                              │
│                                                              │
│  ┌──────────┐   ┌────────────┐   ┌─────────────────────┐   │
│  │  Web     │   │  Android   │   │  Future platforms   │   │
│  │          │   │ (offline)  │   │                     │   │
│  │Supabase  │   │Local Drift │   │                     │   │
│  │  direct  │   │+ Powersync │   │                     │   │
│  └────┬─────┘   └─────┬──────┘   └──────────┬──────────┘   │
│       │               │                      │              │
│  Repository Layer (platform-aware abstractions)             │
│  Riverpod providers stay the same shape                     │
└───────┼───────────────┼──────────────────────┼─────────────┘
        │               │                      │
        ▼               ▼                      ▼
   ┌─────────────────────────────────────────────┐
   │           Supabase                           │
   │  PostgreSQL + RLS + Realtime + Storage       │
   │  Auth: Google OAuth                          │
   └─────────────────────────────────────────────┘
```

---

## Tech Decisions

| Decision | Choice | Reason |
|----------|--------|--------|
| Backend | Supabase | PostgreSQL (relational, matches invoice model), RLS for user isolation, Google OAuth built-in, `supabase_flutter` SDK, self-hostable |
| Web data | Supabase client direct | No WASM needed; realtime via Supabase `.stream()` |
| Mobile data | Drift (offline) + Powersync sync | Powersync = OSS offline-first sync for Flutter+Supabase; handles conflict resolution |
| Auth | Supabase Auth (Google provider) | Replaces `google_sign_in` v7 on web and native |
| Backup | Supabase Storage (encrypted .enc files) | Replaces local share + Google Drive; works on all platforms |
| PDF/CSV on web | `printing` package + browser download trigger | Browser download instead of SharePlus |
| Visual design | TBD — need design references | Defer until Phase 6 kickoff |

---

## New Dependencies

```yaml
# Replace / add in pubspec.yaml
supabase_flutter: ^2.x          # Auth + DB client + Storage
powersync: ^1.x                 # Offline sync for Android
# Remove (no longer needed):
# google_sign_in_web, google_sign_in_platform_interface (replaced by Supabase Auth)
# sqlite3 WASM build steps in CI
```

---

## Supabase Schema

All tables add `user_id UUID NOT NULL REFERENCES auth.users(id)`.
RLS policy on every table:
```sql
CREATE POLICY "users see own rows" ON <table>
  USING (auth.uid() = user_id);
```

Tables mirror current Drift schema:
- `user_profiles`, `clients`, `projects`, `time_entries`, `invoices`, `invoice_line_items`, `invoice_templates`, `app_settings`

`app_settings` becomes per-user KV: `(user_id, key, value)`.

---

## Implementation Phases

### Phase 1 — Supabase Project Setup (self-hosted on Coolify)

**Hosting decision:** Self-hosted on personal Coolify server. App already at `https://ledger.lab.osobol.com/`. Supabase deployed as a new Coolify resource on the same server.

**Powersync note:** Powersync Cloud works with self-hosted Supabase (no need to self-host Powersync). Evaluate in Phase 4.

#### 1. Deploy Supabase on Coolify

##### 1a. Generate secrets first (do this before touching Coolify)

Run on any machine with Node.js or use the Supabase secret generator.

**JWT_SECRET** — any random 40+ character string:
```bash
openssl rand -base64 40
# example output: 2tq8XvLmNpRkJ3YcHwAoDfEbTzUsQiGn7MVjCyBe+hI=
```

**ANON_KEY and SERVICE_ROLE_KEY** — these are JWTs signed with JWT_SECRET.  
Easiest: use the online generator at https://supabase.com/docs/guides/self-hosting/docker#generate-api-keys

Paste your JWT_SECRET into the generator → it outputs both keys. **Save all three values now** — you'll paste them into Coolify.

---

##### 1b. Create the Supabase service in Coolify

1. Coolify sidebar → pick your **Server** (the one hosting `ledger.lab.osobol.com`)
2. Click **+ New Resource**
3. Tab: **Services** (not "Applications")
4. Search / scroll to **Supabase** → click it
5. Pick the same **Project** as your existing app (or create a new one)
6. Click **Create Service**

Coolify now shows the Supabase service page with multiple expandable sections.

---

##### 1c. Configure environment variables

Click **Environment Variables** tab (or the env section on the service page).

Set these values (replace placeholders):

| Variable | Value |
|----------|-------|
| `POSTGRES_PASSWORD` | strong random password (e.g. `openssl rand -base64 24`) |
| `JWT_SECRET` | the value from step 1a |
| `ANON_KEY` | the anon JWT from step 1a |
| `SERVICE_ROLE_KEY` | the service_role JWT from step 1a |
| `SITE_URL` | `https://ledger.lab.osobol.com` (your Flutter web app URL) |
| `ADDITIONAL_REDIRECT_URLS` | `https://ledger.lab.osobol.com` |
| `SMTP_HOST` | your SMTP host (or leave blank to disable email auth) |
| `SMTP_PORT` | `587` (or your SMTP port) |
| `SMTP_USER` | SMTP username |
| `SMTP_PASS` | SMTP password |
| `SMTP_SENDER_NAME` | `CodeLedger` |

Leave everything else at defaults for now.

---

##### 1d. Set domains

In the **Domains** section of the service, Coolify shows one domain field per exposed service. Set:

| Service | Domain |
|---------|--------|
| **Kong** (API gateway — this is your Supabase URL) | `https://supabase.lab.osobol.com` |
| **Studio** (admin UI) | `https://supabase-studio.lab.osobol.com` (or same host with different path — Coolify may combine them) |

Coolify auto-provisions Let's Encrypt certs for any domain ending in your server's base domain. If you're using a custom subdomain, make sure the DNS A record points to your server IP first.

---

##### 1e. Deploy

Click **Deploy** (or **Start**). Coolify pulls ~10 Docker images and starts the stack. Takes 2–5 minutes on first run.

Watch the **Logs** tab — wait until you see Kong and Studio reporting healthy. Studio container logs "Listening on 0.0.0.0:3000" when ready.

---

##### 1f. Verify

1. Open `https://supabase-studio.lab.osobol.com` → should show Supabase Studio UI
2. In Studio → **Settings → API** → confirm **Project URL** = `https://supabase.lab.osobol.com`
3. Copy the **anon key** shown there (should match what you set; if it shows placeholder, check env vars)
4. Studio → **Table Editor** → no tables yet (expected — schema is in step 2)

#### 2. Run SQL Schema

Connect to Supabase Studio → SQL Editor, then run:

```sql
-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- user_profiles
CREATE TABLE user_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name TEXT,
  business_name TEXT,
  email TEXT,
  address TEXT,
  phone TEXT,
  tax_id TEXT,
  bank_details TEXT,
  stripe_link TEXT,
  business_license TEXT,
  default_hourly_rate DOUBLE PRECISION NOT NULL DEFAULT 0,
  default_tax_rate DOUBLE PRECISION NOT NULL DEFAULT 0,
  default_tax_label TEXT NOT NULL DEFAULT 'Tax',
  default_currency TEXT NOT NULL DEFAULT 'USD',
  default_template_id UUID,
  invoice_number_prefix TEXT NOT NULL DEFAULT 'INV-',
  invoice_number_counter INTEGER NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- clients
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  email TEXT,
  address TEXT,
  hourly_rate DOUBLE PRECISION NOT NULL DEFAULT 0,
  tax_rate DOUBLE PRECISION NOT NULL DEFAULT 0,
  currency TEXT NOT NULL DEFAULT 'USD',
  is_archived BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- invoice_templates
CREATE TABLE invoice_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  template_key TEXT NOT NULL,
  description TEXT,
  is_default BOOLEAN NOT NULL DEFAULT false,
  is_built_in BOOLEAN NOT NULL DEFAULT false,
  primary_color INTEGER NOT NULL DEFAULT 0,
  accent_color INTEGER NOT NULL DEFAULT 0,
  font_family TEXT NOT NULL DEFAULT 'Helvetica',
  show_logo BOOLEAN NOT NULL DEFAULT true,
  show_payment_info BOOLEAN NOT NULL DEFAULT true,
  show_tax_breakdown BOOLEAN NOT NULL DEFAULT true,
  show_tax_id BOOLEAN NOT NULL DEFAULT false,
  show_business_license BOOLEAN NOT NULL DEFAULT false,
  show_bank_details BOOLEAN NOT NULL DEFAULT false,
  show_stripe_link BOOLEAN NOT NULL DEFAULT false,
  show_detailed_breakdown BOOLEAN NOT NULL DEFAULT false,
  show_payment_terms BOOLEAN NOT NULL DEFAULT false,
  show_late_fee_clause BOOLEAN NOT NULL DEFAULT false,
  footer_text TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- projects
CREATE TABLE projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  description TEXT,
  hourly_rate DOUBLE PRECISION,
  github_repo TEXT,
  is_archived BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- invoices
CREATE TABLE invoices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id),
  template_id UUID REFERENCES invoice_templates(id),
  invoice_number TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'draft',
  issue_date TIMESTAMPTZ NOT NULL,
  due_date TIMESTAMPTZ NOT NULL,
  sent_date TIMESTAMPTZ,
  paid_date TIMESTAMPTZ,
  period_start TIMESTAMPTZ,
  period_end TIMESTAMPTZ,
  subtotal DOUBLE PRECISION NOT NULL DEFAULT 0,
  tax_rate DOUBLE PRECISION NOT NULL DEFAULT 0,
  tax_label TEXT NOT NULL DEFAULT 'Tax',
  tax_amount DOUBLE PRECISION NOT NULL DEFAULT 0,
  late_fee_amount DOUBLE PRECISION NOT NULL DEFAULT 0,
  total DOUBLE PRECISION NOT NULL DEFAULT 0,
  amount_paid DOUBLE PRECISION NOT NULL DEFAULT 0,
  currency TEXT NOT NULL DEFAULT 'USD',
  notes TEXT,
  pdf_path TEXT,
  payment_method TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- time_entries
CREATE TABLE time_entries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  client_id UUID NOT NULL REFERENCES clients(id),
  project_id UUID REFERENCES projects(id),
  invoice_id UUID REFERENCES invoices(id),
  description TEXT,
  start_time TIMESTAMPTZ NOT NULL,
  end_time TIMESTAMPTZ,
  hourly_rate_snapshot DOUBLE PRECISION NOT NULL DEFAULT 0,
  is_invoiced BOOLEAN NOT NULL DEFAULT false,
  issue_reference TEXT,
  repository TEXT,
  tags TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- invoice_line_items
CREATE TABLE invoice_line_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  invoice_id UUID NOT NULL REFERENCES invoices(id) ON DELETE CASCADE,
  time_entry_id UUID REFERENCES time_entries(id),
  project_id UUID REFERENCES projects(id),
  description TEXT NOT NULL,
  quantity DOUBLE PRECISION NOT NULL DEFAULT 1,
  unit_price DOUBLE PRECISION NOT NULL DEFAULT 0,
  total DOUBLE PRECISION NOT NULL DEFAULT 0,
  sort_order INTEGER NOT NULL DEFAULT 0,
  issue_reference TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- app_settings (KV per user)
CREATE TABLE app_settings (
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  key TEXT NOT NULL,
  value TEXT,
  PRIMARY KEY (user_id, key)
);

-- RLS: enable on all tables
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoice_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoices ENABLE ROW LEVEL SECURITY;
ALTER TABLE time_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE invoice_line_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE app_settings ENABLE ROW LEVEL SECURITY;

-- RLS policies (own rows only)
CREATE POLICY "own rows" ON user_profiles USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON clients USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON invoice_templates USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON projects USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON invoices USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON time_entries USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON invoice_line_items USING (auth.uid() = user_id);
CREATE POLICY "own rows" ON app_settings USING (auth.uid() = user_id);
```

#### 3. Enable Google OAuth

In Supabase Studio → Authentication → Providers → Google:
1. Enable Google provider
2. Paste **Client ID** and **Client Secret** from Google Cloud Console
3. Set **redirect URL** to `https://supabase.lab.osobol.com/auth/v1/callback` (your Supabase domain)
4. In Google Cloud Console → OAuth Client → add `https://supabase.lab.osobol.com` to authorized origins and `https://supabase.lab.osobol.com/auth/v1/callback` to redirect URIs
5. Also add `https://ledger.lab.osobol.com` to authorized origins (the Flutter web app origin)

#### 4. Collect Credentials

From Supabase Studio → Settings → API:
- **Project URL**: `https://supabase.lab.osobol.com` (your custom domain)
- **anon key**: the `anon`/`public` JWT
- **service_role key**: keep secret, CI only

Add to Coolify environment variables for the Flutter web deployment:
```
SUPABASE_URL=https://supabase.lab.osobol.com
SUPABASE_ANON_KEY=<anon key>
```

These will be passed as `--dart-define` flags in the Flutter build command (Phase 2).

**Deliverable:** Supabase running at custom domain, schema + RLS applied, Google OAuth configured, credentials collected.

---

### Phase 2 — Auth Migration

**Files to change:**
- `pubspec.yaml` — add `supabase_flutter`, remove `google_sign_in_web`, `google_sign_in_platform_interface`
- `lib/main.dart` — add `Supabase.initialize(url, anonKey)` before runApp
- `lib/core/providers/supabase_provider.dart` *(new)* — `Provider<SupabaseClient>` wrapping `Supabase.instance.client`
- `lib/core/providers/auth_provider.dart` *(new)* — replaces `web_auth_provider.dart`; watches `supabase.auth.onAuthStateChange`, exposes `Session?`
- `lib/features/auth/presentation/pages/login_page.dart` *(rename/rewrite)* — `signInWithOAuth(OAuthProvider.google)` for both web + native; remove `buildGoogleSignInButton` conditional export
- `lib/app.dart` — replace `webAuthProvider` gate with `authProvider` (works on all platforms now)
- **Delete:** `lib/core/providers/web_auth_provider.dart`, `lib/core/widgets/google_sign_in_button*.dart`, `lib/core/utils/google_sign_in_utils.dart`, `lib/core/constants/google_credentials.dart`

**Web behavior after:** `signInWithOAuth` opens Google consent in popup/redirect; Supabase handles token exchange.
**Native behavior after:** Same call — Supabase Auth handles Google on Android via custom tab.

---

### Phase 3 — Repository Abstraction Layer

Currently: UI providers call DAOs directly (Drift-specific).
After: UI providers call **Repositories** (platform-agnostic interface).
Platform implementations:
- `SupabaseClientRepository` (web) — calls Supabase PostgREST
- `LocalDriftRepository` (Android) — calls existing DAOs; Powersync syncs behind the scenes

**Pattern:**
```dart
// lib/core/repositories/client_repository.dart (interface)
abstract class ClientRepository {
  Stream<List<Client>> watchActiveClients();
  Future<int> insertClient(ClientsCompanion c);
  Future<bool> updateClient(ClientsCompanion c);
  Future<void> archiveClient(int id);
}

// Riverpod selects implementation:
final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  if (kIsWeb) return SupabaseClientRepository(ref.watch(supabaseProvider));
  return DriftClientRepository(ref.watch(clientDaoProvider));
});
```

**Files to create:**
- `lib/core/repositories/{entity}_repository.dart` × 6
- `lib/core/repositories/supabase/*.dart` × 6
- `lib/core/repositories/drift/*.dart` × 6 (thin wrappers over existing DAOs)

Existing feature providers keep the same signature — they watch `clientRepositoryProvider` instead of `clientDaoProvider`.

---

### Phase 4 — Mobile Sync (Powersync)

**Files to change:**
- `pubspec.yaml` — add `powersync`
- `lib/core/database/app_database.dart` — integrate Powersync schema + sync client alongside Drift
- `lib/core/providers/sync_provider.dart` *(new)* — initializes Powersync client, exposes sync status
- `lib/features/settings/presentation/pages/settings_page.dart` — add sync status indicator

**Powersync flow:**
- Sync rules YAML specifies which tables sync, filtered by `user_id`
- Supabase Edge Function generates Powersync JWT from Supabase session
- Changes made offline get pushed when connectivity restored

**Deliverable:** Android app works offline, auto-syncs when online.

---

### Phase 5 — Web Feature Parity

#### Backup
Replace `BackupService` + `DriveBackupService` with `CloudBackupService`:
- `createBackup(passphrase)` → encrypt data → upload to `supabase.storage.from('backups')/{user_id}/{filename}`
- `listBackups()` → list user's bucket folder
- `restoreBackup(fileId, passphrase)` → download → decrypt → apply

On web: data export as JSON (all rows) rather than raw SQLite file copy.
On Android: SQLite file bytes (existing logic preserved).

`backup_page.dart` — remove all web/native branches; single unified UI.

#### PDF / CSV on web
- `printing` package supports web via `Printing.layoutPdf()` → browser print dialog
- CSV: build `Blob` + `AnchorElement` download as fallback if `share_plus` doesn't trigger download

---

### Phase 6 — UI / UX Redesign

**Prerequisite:** Design references / mockups needed before coding starts.

**Scope:**
- New color palette + typography (replace current teal M3 scheme)
- Shell navigation — sidebar vs. top nav decision for web
- Dashboard card redesign
- Form page layouts
- Invoice template visual polish
- Dark mode

**Key files:**
- `lib/core/theme/app_theme.dart`
- `lib/core/router/shell_scaffold.dart`
- Feature pages as needed

---

## CI/CD Changes

`.github/workflows/deploy-web.yml`:
- Remove: sqlite3.wasm download, `dart compile js drift_worker.dart`
- Remove: `google_credentials.dart` stub generation
- Add: `SUPABASE_URL` + `SUPABASE_ANON_KEY` as compile-time `--dart-define` flags

---

## Files Deleted

| File | Reason |
|------|--------|
| `lib/core/providers/web_auth_provider.dart` | Replaced by `auth_provider.dart` (all platforms) |
| `lib/core/widgets/google_sign_in_button*.dart` (3 files) | Supabase handles sign-in |
| `lib/core/utils/google_sign_in_utils.dart` | No longer needed |
| `lib/core/constants/google_credentials.dart` | No longer needed |
| `web/drift_worker.dart` | No Drift on web |

---

## Risks / Open Questions

| Risk | Mitigation |
|------|-----------|
| Powersync licensing/complexity | Evaluate OSS tier limits; fallback: manual push-on-save sync |
| Web DB export — can't copy raw SQLite file | Use JSON (row-by-row) for web backup; SQLite file path for native |
| `printing` web PDF quality | Test early in Phase 5 |
| Data migration: existing Android SQLite → Supabase | First-run tool: read local Drift DB, push all rows with `user_id` |
| Supabase Android auth needs deep link config | Standard `supabase_flutter` setup; document in README |

---

## Phase Order & Dependencies

```
Phase 1 (Supabase setup)  ← no code, start immediately
Phase 2 (Auth)            ← needs Phase 1 done
Phase 3 (Repositories)    ← needs Phase 2 (auth.uid() available)
Phase 4 (Sync)            ← needs Phase 3
Phase 5 (Web parity)      ← needs Phase 3
Phase 6 (UI redesign)     ← independent; can run in parallel after Phase 2
```

---

## Current System Snapshot (baseline)

See `docs/system-report-2026-05-19.md` for full feature inventory and current web status.
