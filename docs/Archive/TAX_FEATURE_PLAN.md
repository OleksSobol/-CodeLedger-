# CodeLedger — Tax Summary & Expense Tracking Feature

## Context

The user pays sales taxes quarterly and federal taxes annually. CodeLedger already tracks all invoice income with tax amounts, but has no way to see quarterly/annual tax liability or track business expenses. This feature adds a **Tax Summary tab** to the Reports page with quarterly income breakdowns, estimated tax calculations, and a simple expense tracker for deductions.

## What Already Exists
- Invoices with `total`, `taxAmount`, `paidDate`, `issueDate`, `status`, `amountPaid`
- `InvoiceDao.getByStatus('paid')` returns all paid invoices
- `AppSettingsDao` with `getValue`/`setValue` (key-value store) — provider at `theme_provider.dart:8`
- `image_picker: ^1.2.1` already in pubspec
- Reports page at `features/reports/presentation/pages/reports_page.dart` — single-page form
- Schema at version 1, migration stub ready in `app_database.dart:47`

---

## Phase 1: Database & Models

### 1a. New `expenses` table
**File:** `lib/core/database/tables/expenses_table.dart` (NEW)

| Column | Type | Notes |
|--------|------|-------|
| id | integer().autoIncrement() | PK |
| date | dateTime() | When expense was incurred (determines quarter) |
| amount | real() | Dollar amount |
| category | text() | Enum string: 'software', 'hardware', etc. |
| description | text().nullable() | Optional note |
| receiptPath | text().nullable() | Local file path from image_picker |
| isTaxDeductible | boolean().withDefault(true) | Can mark as non-deductible |
| createdAt / updatedAt | dateTime().withDefault(currentDateAndTime) | Timestamps |

No `clientId` — expenses are business-level, not per-client.

### 1b. Expense categories enum
**File:** `lib/core/constants/expense_categories.dart` (NEW)

Categories: software, hardware, office, internet, hosting, education, travel, meals, insurance, professional (accountant/lawyer), advertising, homeOffice, other — maps to Schedule C line items relevant to a solo dev.

### 1c. Schema migration
**File:** `lib/core/database/app_database.dart` (MODIFY)
- Add `Expenses` to `@DriftDatabase(tables: [...])`
- Bump `schemaVersion` to `2`
- Migration: `if (from < 2) await m.createTable(expenses);`

### 1d. Tax settings — stored in existing `AppSettings` table

| Key | Default | Description |
|-----|---------|-------------|
| `tax.federal_effective_rate` | `22.0` | User's marginal federal rate (%) |
| `tax.state_rate` | `0.0` | State income tax rate (0 for WA) |
| `tax.self_employment_rate` | `15.3` | SE tax (12.4% SS + 2.9% Medicare) |
| `tax.use_paid_date` | `true` | Cash basis (true) vs accrual (false) |

No new table needed — reuses `AppSettingsDao.getValue/setValue`.

### 1e. Run `dart run build_runner build` after creating table + DAO

---

## Phase 2: DAO & Service Layer

### 2a. ExpenseDao
**File:** `lib/core/database/daos/expense_dao.dart` (NEW)

Methods: `watchExpenses({int? year})`, `getExpensesForRange(start, end)`, `getDeductibleTotalForRange(start, end)`, `createExpense(companion)`, `updateExpense(id, companion)`, `deleteExpense(id)`

### 2b. Add `getIncomeForRange` to InvoiceDao
**File:** `lib/core/database/daos/invoice_dao.dart` (MODIFY)

```dart
Future<double> getIncomeForRange(DateTime start, DateTime end, {bool usePaidDate = true})
```
Queries paid invoices where the relevant date falls within range, returns sum of `total`.

### 2c. Tax models (pure Dart)
**File:** `lib/features/tax/data/models/tax_models.dart` (NEW)

- `TaxSettings` — federal rate, state rate, SE rate, use paid date
- `QuarterlyTaxEstimate` — year, quarter, period start/end, deadline, gross income, expenses, net income, SE tax, federal tax, state tax, total
- `AnnualTaxSummary` — year, list of quarters, totals, effective rate

### 2d. TaxCalculationService
**File:** `lib/features/tax/application/tax_calculation_service.dart` (NEW)

**IRS quarter boundaries (NOT equal calendar quarters):**
- Q1: Jan 1 – Mar 31, due Apr 15
- Q2: Apr 1 – May 31, due Jun 15
- Q3: Jun 1 – Aug 31, due Sep 15
- Q4: Sep 1 – Dec 31, due Jan 15+1yr

**Calculation per quarter:**
```
netIncome = grossIncome - deductibleExpenses
seBase = netIncome * 0.9235          // IRS deducts 7.65% before SE calc
seTax = seBase * seRate              // 15.3%
adjustedIncome = netIncome - (seTax / 2)  // Half SE tax deducted from AGI
federalTax = adjustedIncome * federalEffectiveRate
stateTax = adjustedIncome * stateRate
totalEstimatedTax = seTax + federalTax + stateTax
```

---

## Phase 3: Providers

**File:** `lib/features/tax/presentation/providers/tax_providers.dart` (NEW)

- `expenseDaoProvider` — Provider<ExpenseDao>
- `taxSettingsProvider` — FutureProvider<TaxSettings> (reads from AppSettingsDao)
- `annualTaxSummaryProvider` — FutureProvider.family<AnnualTaxSummary, int>(year)
- `yearExpensesProvider` — StreamProvider.family<List<Expense>, int>(year)
- `expenseNotifierProvider` — AsyncNotifierProvider for CRUD + invalidation

Reuses existing `appSettingsDaoProvider` from `theme_provider.dart` and `invoiceDaoProvider` from `dashboard_provider.dart`.

---

## Phase 4: UI

### 4a. Convert Reports page to tabbed layout
**File:** `lib/features/reports/presentation/pages/reports_page.dart` (MODIFY)

- Wrap in `DefaultTabController(length: 2)`
- Tab 1: "Work Reports" — extract existing content into `_WorkReportsTab`
- Tab 2: "Tax Summary" — new `TaxSummaryTab` widget

### 4b. Tax Summary Tab
**File:** `lib/features/tax/presentation/widgets/tax_summary_tab.dart` (NEW)

Layout (scrollable ListView):
1. **Year selector** — DropdownButton at top (current year, previous year)
2. **Annual summary header** — card row showing: Gross Income, Expenses, Net Income, Est. Total Tax, Effective Rate
3. **Quarterly cards** (4x) — each shows: quarter label + dates, income, expenses, estimated tax, payment deadline with color coding (green/amber/red)
4. **Expenses section** — total with "View All" button, top categories breakdown
5. **FAB** — "Add Expense"
6. **Tax settings** — collapsible section with rate inputs at bottom

### 4c. Expense entry bottom sheet
**File:** `lib/features/tax/presentation/widgets/expense_entry_sheet.dart` (NEW)

Fields: date picker, amount input, category chip selector (horizontal scroll), description (optional), receipt photo (take/choose), save button.

### 4d. Expense list page
**File:** `lib/features/tax/presentation/pages/expense_list_page.dart` (NEW)

- Grouped by month, sorted by date desc
- Category icon, description, amount per tile
- Swipe to delete, tap to edit
- Category filter chips
- Route: add to `app_router.dart`

### 4e. Supporting widgets
- `quarterly_card.dart` — single quarter display
- `annual_summary_header.dart` — top summary row
- `expense_tile.dart` — list tile for expenses
- `tax_settings_section.dart` — rate inputs, cash/accrual toggle

---

## Implementation Order

1. `expenses_table.dart`, `expense_categories.dart` — new table + enum
2. `app_database.dart` — add Expenses, bump schema to v2, migration
3. `expense_dao.dart` — CRUD methods
4. `dart run build_runner build` — regenerate all .g.dart files
5. `invoice_dao.dart` — add `getIncomeForRange()`
6. `tax_models.dart` — pure data classes
7. `tax_calculation_service.dart` — all formulas
8. `tax_providers.dart` — wire providers
9. `tax_summary_tab.dart` + `annual_summary_header.dart` + `quarterly_card.dart` — read-only display
10. `reports_page.dart` — convert to tabbed layout
11. `expense_entry_sheet.dart` — add expense form
12. `expense_tile.dart` + `expense_list_page.dart` — expense list
13. `app_router.dart` — add expense list route
14. `tax_settings_section.dart` — rate configuration UI

## Verification
1. `dart run build_runner build` succeeds
2. `dart analyze lib` — no errors
3. App launches, Reports page shows two tabs
4. Tax tab shows quarterly breakdown from existing paid invoices
5. Can add/edit/delete expenses with receipt photos
6. Changing tax rates in settings updates estimates
7. Expense totals reduce taxable income in quarterly cards

---

## State Management: Riverpod

**Why Riverpod over Bloc:**
- Single-user small dataset makes Bloc's event/state ceremony overkill
- Drift's reactive `watch()` streams map directly to Riverpod's `StreamProvider`/`AsyncNotifierProvider`
- ~3x less boilerplate per feature (1 Notifier vs Event + State + Bloc classes)
- No `BuildContext` needed for data access (critical for PDF generation, exports, backup in isolates)
- Compile-time provider dependency safety

---

## Database Schema

### `user_profile` (singleton - always 1 row)
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| business_name | TEXT | No | '' | |
| owner_name | TEXT | No | '' | |
| email | TEXT | Yes | null | |
| phone | TEXT | Yes | null | |
| address_line1 | TEXT | Yes | null | |
| address_line2 | TEXT | Yes | null | |
| city | TEXT | Yes | null | |
| state_province | TEXT | Yes | null | |
| postal_code | TEXT | Yes | null | |
| country | TEXT | Yes | null | |
| tax_id | TEXT | Yes | null | EIN/VAT/ABN |
| show_tax_id | INTEGER | No | true | Toggle visibility on invoices |
| wa_business_license | TEXT | Yes | null | WA state business license |
| show_wa_license | INTEGER | No | false | Toggle visibility on invoices |
| logo_path | TEXT | Yes | null | Local file path |
| bank_name | TEXT | Yes | null | |
| bank_account_name | TEXT | Yes | null | |
| bank_account_number | TEXT | Yes | null | |
| bank_routing_number | TEXT | Yes | null | ACH routing number |
| bank_account_type | TEXT | No | 'checking' | checking/savings |
| bank_swift | TEXT | Yes | null | |
| bank_iban | TEXT | Yes | null | |
| show_bank_details | INTEGER | No | true | Toggle visibility on invoices |
| stripe_payment_link | TEXT | Yes | null | Optional Stripe link |
| show_stripe_link | INTEGER | No | false | Toggle visibility on invoices |
| payment_instructions | TEXT | Yes | null | Free text (PayPal, Venmo, etc.) |
| default_currency | TEXT | No | 'USD' | ISO 4217 |
| default_hourly_rate | REAL | No | 0.0 | Global default rate |
| default_tax_label | TEXT | No | 'Tax' | "GST", "VAT", etc. |
| default_tax_rate | REAL | No | 0.0 | Percentage |
| default_payment_terms | TEXT | No | 'net_30' | net_7/net_14/net_30/custom |
| default_payment_terms_days | INTEGER | No | 30 | Used when terms = custom |
| late_fee_percentage | REAL | Yes | null | Optional late fee % |
| default_template_id | INTEGER | Yes | null | FK -> invoice_templates |
| default_email_subject_format | TEXT | No | 'Invoice #{number} – {period}' | Tokenized format |
| next_invoice_number | INTEGER | No | 1 | Auto-incrementing |
| invoice_number_prefix | TEXT | No | 'INV-' | |
| created_at | INTEGER | No | now | Unix timestamp |
| updated_at | INTEGER | No | now | Unix timestamp |

### `clients` (renamed from companies — developer-focused)
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| name | TEXT | No | | UNIQUE |
| contact_name | TEXT | Yes | null | |
| email | TEXT | Yes | null | |
| phone | TEXT | Yes | null | |
| address_line1 | TEXT | Yes | null | |
| address_line2 | TEXT | Yes | null | |
| city | TEXT | Yes | null | |
| state_province | TEXT | Yes | null | |
| postal_code | TEXT | Yes | null | |
| country | TEXT | Yes | null | |
| hourly_rate | REAL | Yes | null | null = use profile default |
| currency | TEXT | No | 'USD' | ISO 4217 |
| tax_rate | REAL | Yes | null | null = use profile default |
| default_template_id | INTEGER | Yes | null | FK -> invoice_templates |
| payment_terms_override | TEXT | Yes | null | null = use profile default |
| payment_terms_days_override | INTEGER | Yes | null | |
| notes | TEXT | Yes | null | |
| is_archived | INTEGER | No | false | Soft delete |
| created_at | INTEGER | No | now | |
| updated_at | INTEGER | No | now | |

**Computed views needed** (via DAO queries, not stored columns):
- Uninvoiced hours count
- Total billed amount (sum of invoice totals)
- Total paid amount (sum of paid invoice totals)

### `projects`
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| client_id | INTEGER | No | | FK -> clients (CASCADE) |
| name | TEXT | No | | UNIQUE(client_id, name) |
| description | TEXT | Yes | null | |
| hourly_rate_override | REAL | Yes | null | null = use client/profile rate |
| color | INTEGER | No | 0xFF2196F3 | ARGB for UI |
| is_active | INTEGER | No | true | |
| is_archived | INTEGER | No | false | |
| created_at | INTEGER | No | now | |
| updated_at | INTEGER | No | now | |

### `time_entries`
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| client_id | INTEGER | No | | FK -> clients (CASCADE) |
| project_id | INTEGER | Yes | null | FK -> projects (SET NULL), nullable |
| start_time | INTEGER | No | | Unix timestamp |
| end_time | INTEGER | Yes | null | null = currently running |
| duration_minutes | INTEGER | Yes | null | Computed on stop or manual |
| description | TEXT | Yes | null | Multi-line work description |
| issue_reference | TEXT | Yes | null | GitHub issue ref (e.g. "org/repo#42") |
| repository | TEXT | Yes | null | Repository name |
| tags | TEXT | Yes | null | JSON array of tag strings |
| is_manual | INTEGER | No | false | |
| hourly_rate_snapshot | REAL | No | | Rate resolved at creation |
| is_invoiced | INTEGER | No | false | |
| invoice_id | INTEGER | Yes | null | FK -> invoices (SET NULL) |
| created_at | INTEGER | No | now | |
| updated_at | INTEGER | No | now | |

**Indexes**: `(client_id, start_time)`, `(project_id, start_time)`, `(is_invoiced)`, `(start_time)`
**Overlap prevention**: Application-layer check in transaction before INSERT/UPDATE

### `invoices`
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| client_id | INTEGER | No | | FK -> clients (RESTRICT) |
| invoice_number | TEXT | No | | UNIQUE, e.g. "INV-0042" |
| status | TEXT | No | 'draft' | draft/sent/paid/overdue/cancelled |
| issue_date | INTEGER | No | | |
| due_date | INTEGER | No | | Auto-calc from payment terms |
| period_start | INTEGER | Yes | null | Service period start |
| period_end | INTEGER | Yes | null | Service period end |
| subtotal | REAL | No | 0.0 | |
| tax_rate | REAL | No | 0.0 | Snapshot |
| tax_label | TEXT | No | 'Tax' | |
| tax_amount | REAL | No | 0.0 | |
| late_fee_amount | REAL | No | 0.0 | Calculated if overdue |
| total | REAL | No | 0.0 | subtotal + tax + late_fee |
| amount_paid | REAL | No | 0.0 | For partial payment tracking |
| currency | TEXT | No | 'USD' | Snapshot |
| notes | TEXT | Yes | null | |
| template_id | INTEGER | Yes | null | FK -> invoice_templates (SET NULL) |
| template_type | TEXT | No | 'detailed' | detailed/summary/minimal |
| pdf_path | TEXT | Yes | null | Local path |
| payment_method | TEXT | Yes | null | ach/stripe/other |
| paid_date | INTEGER | Yes | null | |
| sent_date | INTEGER | Yes | null | |
| created_at | INTEGER | No | now | |
| updated_at | INTEGER | No | now | |

**Indexes**: `(client_id, status)`, `(issue_date)`, `(status)`

### `invoice_line_items`
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| invoice_id | INTEGER | No | | FK -> invoices (CASCADE) |
| sort_order | INTEGER | No | 0 | |
| description | TEXT | No | | |
| quantity | REAL | No | | Hours or units |
| unit_price | REAL | No | | Rate per unit |
| total | REAL | No | | quantity * unit_price |
| time_entry_id | INTEGER | Yes | null | FK -> time_entries (SET NULL) |
| project_id | INTEGER | Yes | null | FK -> projects (SET NULL) |
| created_at | INTEGER | No | now | |

### `invoice_templates`
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| id | INTEGER | No | autoIncrement | PK |
| name | TEXT | No | | |
| template_key | TEXT | No | | UNIQUE code identifier |
| description | TEXT | Yes | null | |
| is_default | INTEGER | No | false | |
| primary_color | INTEGER | No | 0xFF2196F3 | ARGB |
| accent_color | INTEGER | No | 0xFF1565C0 | |
| font_family | TEXT | No | 'Helvetica' | |
| show_logo | INTEGER | No | true | |
| show_payment_info | INTEGER | No | true | |
| show_tax_breakdown | INTEGER | No | true | |
| show_tax_id | INTEGER | No | true | |
| show_business_license | INTEGER | No | false | |
| show_bank_details | INTEGER | No | true | |
| show_stripe_link | INTEGER | No | false | |
| show_detailed_breakdown | INTEGER | No | true | Group by date |
| show_payment_terms | INTEGER | No | true | |
| show_late_fee_clause | INTEGER | No | false | |
| footer_text | TEXT | Yes | null | |
| is_built_in | INTEGER | No | true | |
| created_at | INTEGER | No | now | |
| updated_at | INTEGER | No | now | |

### `app_settings` (key-value store)
| Column | Type | Nullable | Default | Notes |
|---|---|---|---|---|
| key | TEXT | No | | PK |
| value | TEXT | No | | JSON-encoded |
| updated_at | INTEGER | No | now | |

---

## Drift Table Definitions

```dart
// tables/user_profiles_table.dart
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get businessName => text().withDefault(const Constant(''))();
  TextColumn get ownerName => text().withDefault(const Constant(''))();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get addressLine1 => text().nullable()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get stateProvince => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get taxId => text().nullable()();
  BoolColumn get showTaxId => boolean().withDefault(const Constant(true))();
  TextColumn get waBusinessLicense => text().nullable()();
  BoolColumn get showWaLicense => boolean().withDefault(const Constant(false))();
  TextColumn get logoPath => text().nullable()();
  TextColumn get bankName => text().nullable()();
  TextColumn get bankAccountName => text().nullable()();
  TextColumn get bankAccountNumber => text().nullable()();
  TextColumn get bankRoutingNumber => text().nullable()();
  TextColumn get bankAccountType => text().withDefault(const Constant('checking'))();
  TextColumn get bankSwift => text().nullable()();
  TextColumn get bankIban => text().nullable()();
  BoolColumn get showBankDetails => boolean().withDefault(const Constant(true))();
  TextColumn get stripePaymentLink => text().nullable()();
  BoolColumn get showStripeLink => boolean().withDefault(const Constant(false))();
  TextColumn get paymentInstructions => text().nullable()();
  TextColumn get defaultCurrency => text().withDefault(const Constant('USD'))();
  RealColumn get defaultHourlyRate => real().withDefault(const Constant(0.0))();
  TextColumn get defaultTaxLabel => text().withDefault(const Constant('Tax'))();
  RealColumn get defaultTaxRate => real().withDefault(const Constant(0.0))();
  TextColumn get defaultPaymentTerms => text().withDefault(const Constant('net_30'))();
  IntColumn get defaultPaymentTermsDays => integer().withDefault(const Constant(30))();
  RealColumn get lateFeePercentage => real().nullable()();
  IntColumn get defaultTemplateId => integer().nullable().references(InvoiceTemplates, #id)();
  TextColumn get defaultEmailSubjectFormat => text().withDefault(const Constant('Invoice #{number} – {period}'))();
  IntColumn get nextInvoiceNumber => integer().withDefault(const Constant(1))();
  TextColumn get invoiceNumberPrefix => text().withDefault(const Constant('INV-'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

```dart
// tables/clients_table.dart
class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get contactName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get addressLine1 => text().nullable()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get stateProvince => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get country => text().nullable()();
  RealColumn get hourlyRate => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  RealColumn get taxRate => real().nullable()();
  IntColumn get defaultTemplateId => integer().nullable().references(InvoiceTemplates, #id)();
  TextColumn get paymentTermsOverride => text().nullable()();
  IntColumn get paymentTermsDaysOverride => integer().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

```dart
// tables/projects_table.dart
class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get hourlyRateOverride => real().nullable()();
  IntColumn get color => integer().withDefault(const Constant(0xFF2196F3))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [{clientId, name}];
}
```

```dart
// tables/time_entries_table.dart
class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  IntColumn get projectId => integer().nullable().references(Projects, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get issueReference => text().nullable()();
  TextColumn get repository => text().nullable()();
  TextColumn get tags => text().nullable()(); // JSON array
  BoolColumn get isManual => boolean().withDefault(const Constant(false))();
  RealColumn get hourlyRateSnapshot => real()();
  BoolColumn get isInvoiced => boolean().withDefault(const Constant(false))();
  IntColumn get invoiceId => integer().nullable().references(Invoices, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

```dart
// tables/invoices_table.dart
class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get invoiceNumber => text().unique()();
  TextColumn get status => text().withDefault(const Constant('draft'))();
  DateTimeColumn get issueDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  DateTimeColumn get periodStart => dateTime().nullable()();
  DateTimeColumn get periodEnd => dateTime().nullable()();
  RealColumn get subtotal => real().withDefault(const Constant(0.0))();
  RealColumn get taxRate => real().withDefault(const Constant(0.0))();
  TextColumn get taxLabel => text().withDefault(const Constant('Tax'))();
  RealColumn get taxAmount => real().withDefault(const Constant(0.0))();
  RealColumn get lateFeeAmount => real().withDefault(const Constant(0.0))();
  RealColumn get total => real().withDefault(const Constant(0.0))();
  RealColumn get amountPaid => real().withDefault(const Constant(0.0))();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  TextColumn get notes => text().nullable()();
  IntColumn get templateId => integer().nullable().references(InvoiceTemplates, #id)();
  TextColumn get templateType => text().withDefault(const Constant('detailed'))();
  TextColumn get pdfPath => text().nullable()();
  TextColumn get paymentMethod => text().nullable()(); // ach/stripe/other
  DateTimeColumn get paidDate => dateTime().nullable()();
  DateTimeColumn get sentDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

```dart
// tables/invoice_line_items_table.dart
class InvoiceLineItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get description => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get total => real()();
  IntColumn get timeEntryId => integer().nullable().references(TimeEntries, #id)();
  IntColumn get projectId => integer().nullable().references(Projects, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
```

```dart
// tables/invoice_templates_table.dart
class InvoiceTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get templateKey => text().unique()();
  TextColumn get description => text().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  IntColumn get primaryColor => integer().withDefault(const Constant(0xFF2196F3))();
  IntColumn get accentColor => integer().withDefault(const Constant(0xFF1565C0))();
  TextColumn get fontFamily => text().withDefault(const Constant('Helvetica'))();
  BoolColumn get showLogo => boolean().withDefault(const Constant(true))();
  BoolColumn get showPaymentInfo => boolean().withDefault(const Constant(true))();
  BoolColumn get showTaxBreakdown => boolean().withDefault(const Constant(true))();
  BoolColumn get showTaxId => boolean().withDefault(const Constant(true))();
  BoolColumn get showBusinessLicense => boolean().withDefault(const Constant(false))();
  BoolColumn get showBankDetails => boolean().withDefault(const Constant(true))();
  BoolColumn get showStripeLink => boolean().withDefault(const Constant(false))();
  BoolColumn get showDetailedBreakdown => boolean().withDefault(const Constant(true))();
  BoolColumn get showPaymentTerms => boolean().withDefault(const Constant(true))();
  BoolColumn get showLateFeeclause => boolean().withDefault(const Constant(false))();
  TextColumn get footerText => text().nullable()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
```

```dart
// tables/app_settings_table.dart
class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}
```

---

## Folder Structure

```
lib/
├── main.dart
├── app.dart                              # MaterialApp.router
├── core/
│   ├── database/
│   │   ├── app_database.dart             # @DriftDatabase, migrations, seed
│   │   ├── tables/                       # 8 Drift table classes
│   │   └── daos/                         # 8 DAO classes
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── payment_terms.dart            # net_7, net_14, net_30, custom enum
│   │   └── invoice_status.dart           # draft, sent, paid, overdue, cancelled
│   ├── theme/
│   │   └── app_theme.dart                # Light + dark mode
│   ├── utils/
│   │   ├── date_utils.dart
│   │   ├── currency_formatter.dart
│   │   ├── duration_formatter.dart
│   │   ├── rate_resolver.dart            # Resolves rate: project -> client -> profile
│   │   └── validators.dart
│   ├── encryption/
│   │   └── encryption_service.dart       # AES-256-GCM + PBKDF2
│   ├── providers/
│   │   └── database_provider.dart
│   └── router/
│       └── app_router.dart               # GoRouter
├── features/
│   ├── dashboard/                        # Home screen with summary widgets
│   │   └── presentation/
│   │       ├── pages/dashboard_page.dart
│   │       ├── widgets/
│   │       │   ├── active_timer_card.dart
│   │       │   ├── uninvoiced_hours_card.dart
│   │       │   ├── monthly_income_card.dart
│   │       │   ├── outstanding_invoices_card.dart
│   │       │   └── overdue_invoices_card.dart
│   │       └── providers/dashboard_provider.dart
│   ├── profile/                          # Business info + payment config
│   │   ├── data/repositories/
│   │   ├── domain/entities/repositories/usecases/
│   │   └── presentation/pages/widgets/providers/
│   ├── clients/                          # Client CRUD + summaries
│   │   └── (same clean arch layers)
│   ├── projects/                         # Project CRUD linked to client
│   │   └── (same clean arch layers)
│   ├── time_tracking/                    # Timer, manual entry, summaries
│   │   └── (same clean arch layers)
│   │   # Includes: issue_reference, repository, tags fields
│   │   # Summaries: daily, weekly, monthly, uninvoiced view
│   ├── invoices/                         # Invoice builder + payment tracking
│   │   └── (same clean arch layers)
│   │   # Includes: payment method recording, late fee calc, partial payments
│   ├── pdf_generation/
│   │   ├── data/
│   │   │   ├── pdf_generator.dart        # Template registry
│   │   │   └── templates/
│   │   │       ├── base_invoice_template.dart
│   │   │       ├── minimal_template.dart
│   │   │       ├── detailed_breakdown_template.dart
│   │   │       └── modern_developer_template.dart
│   │   └── domain/entities/usecases/
│   ├── reports/                          # Work reports (non-financial)
│   │   ├── data/report_generator.dart
│   │   └── presentation/pages/providers/
│   ├── email/                            # Device email client integration
│   ├── export/                           # CSV, XLSX, PDF, monthly/yearly summaries
│   ├── backup/                           # Google Drive encrypted backup
│   └── settings/                         # App settings, dark mode toggle
└── shared/
    ├── widgets/
    └── extensions/
```

---

## Invoice Template Pattern (Strategy)

```dart
abstract class InvoiceTemplate {
  String get templateKey;
  String get templateName;

  Future<pw.Document> build({
    required PdfInvoiceData data,
    required InvoiceTemplateConfig config,
  });
}
```

Three built-in templates:
1. **Minimal** — Clean single-total-line, minimal detail
2. **Detailed Breakdown** — Grouped by date, shows each session with description + issue ref
3. **Modern Developer** — Styled for tech clients, shows repo/issue refs prominently

Each template respects toggle flags from `InvoiceTemplateConfig`:
- Show/hide: tax ID, business license, bank details, Stripe link, detailed breakdown, payment terms, late fee clause

**Payment section example rendered in PDF:**
```
Payment due within 14 days of invoice date.

Please remit payment via ACH to:
  Bank Name: First National
  Routing Number: 123456789
  Account Number: ****1234

Or pay securely online:
  https://pay.stripe.com/your-link
```

---

## Payment Tracking Logic

### Rate Resolution (cascading)
```
effective_rate = project.hourly_rate_override
                 ?? client.hourly_rate
                 ?? profile.default_hourly_rate
```

### Payment Terms Resolution
```
effective_terms = client.payment_terms_override
                  ?? profile.default_payment_terms
due_date = issue_date + resolved_terms_days
```

### Invoice Finalization (single transaction)
```dart
Future<void> finalizeInvoice(int invoiceId) {
  return transaction(() async {
    // 1. Calculate totals (subtotal + tax + late fee)
    // 2. Update invoice record
    // 3. Mark all associated time_entries as invoiced
    // 4. Increment next_invoice_number in user_profile
  });
}
```

### Payment Recording (single transaction)
```dart
Future<void> recordPayment({
  required int invoiceId,
  required double amount,
  required String method, // 'ach', 'stripe', 'other'
}) {
  return transaction(() async {
    // 1. Update invoice.amount_paid += amount
    // 2. Set invoice.payment_method = method
    // 3. If amount_paid >= total: set status='paid', paid_date=now
    // 4. Else: keep status as-is (partial payment, future-ready)
  });
}
```

### Late Fee Calculation
```dart
double calculateLateFee(Invoice invoice) {
  if (invoice.status == 'overdue' && lateFeePercentage != null) {
    return invoice.subtotal * (lateFeePercentage! / 100);
  }
  return 0.0;
}
```

---

## Work Report Generator (Non-Financial)

Generates a PDF report for a date range:
- Grouped by date
- Shows: hours worked, description, GitHub issue reference, repository
- **No pricing information** — suitable for sharing with project managers
- Uses `pdf` package, same template pattern as invoices

---

## Dashboard Requirements

The home screen must show:
- **Active timer** (if running) with project/client name and elapsed time
- **Uninvoiced hours per client** — quick summary cards
- **This month's total income** — sum of paid invoices in current month
- **Outstanding invoices** — count + total of sent/unpaid
- **Overdue invoices** — count + total past due date

---

## Email Sending

Use `flutter_email_sender` to open device email client with:
- **Recipient**: client email
- **Subject**: formatted from `default_email_subject_format` (e.g. "Invoice #102 – Jan 2026")
- **Body**: template including payment instructions auto-filled from profile
- **Attachment**: generated PDF

Fallback to `share_plus` if no email client installed.

---

## Export Features

| Export | Format | Contents |
|---|---|---|
| Time entries | CSV | All entries for date range, with client/project/issue/repo |
| Time entries | XLSX | Same, formatted worksheets |
| Invoice | PDF | Generated invoice document |
| Monthly income summary | CSV/XLSX | Per-client totals for month |
| Yearly summary | CSV/XLSX | Per-client/per-month totals for year |

---

## Encryption for Backups

**Algorithm**: AES-256-GCM with PBKDF2-HMAC-SHA256 key derivation
**Package**: `cryptography`

- Salt: 32 bytes, random per backup
- PBKDF2 iterations: 100,000
- Encrypted file format: `salt (32B) + nonce (12B) + MAC (16B) + ciphertext`
- Drive folder: `/CodeLedger/`
- File naming: `codeledger_backup_YYYYMMDD_HHmmss.enc`
- Optional automatic daily backup
- Integrity validation via `PRAGMA integrity_check` before overwrite on restore

---

## Data Corruption Prevention

1. **WAL mode**: `PRAGMA journal_mode = WAL` in `beforeOpen`
2. **Foreign keys**: `PRAGMA foreign_keys = ON` in `beforeOpen`
3. **Transactions**: All multi-table ops (invoice finalization, payment recording, time entry marking)
4. **Overlap prevention**: SELECT + INSERT in same transaction
5. **Pre-migration backup**: Copy DB file before schema upgrades
6. **Integrity check on restore**: `PRAGMA integrity_check` after decryption
7. **Background isolate**: `NativeDatabase.createInBackground`

---

## Key Packages

| Category | Package |
|---|---|
| State management | flutter_riverpod, riverpod_annotation |
| Database | drift, drift_flutter, sqlite3_flutter_libs |
| Routing | go_router |
| PDF | pdf, printing |
| Email | flutter_email_sender, share_plus |
| Export | csv, excel |
| Backup | google_sign_in, googleapis, googleapis_auth |
| Encryption | cryptography |
| UI | intl, image_picker, flutter_colorpicker |
| Utils | path_provider, path, equatable, freezed_annotation |
| Dev | drift_dev, build_runner, riverpod_generator, freezed, mocktail |

---

## Implementation Phases

### Phase 1: Foundation
- `flutter create --org com.yourname --project-name code_ledger code_ledger`
- Folder structure, all packages, Drift tables + DAOs, database with seed
- Riverpod database provider, GoRouter, app theme (light + dark)

### Phase 2: Core CRUD
- User Profile with all payment fields + visibility toggles
- Clients CRUD with archive + computed summaries
- Projects CRUD linked to clients
- Invoice templates seeding (3 built-in)
- Rate resolver utility

### Phase 3: Time Tracking
- Timer provider with persistence across app kills
- Clock in/out, overlap detection
- Manual entry with GitHub issue ref + repository + tags
- Time entries list (filterable by client, project, date, invoiced status)
- Daily, weekly, monthly summaries
- Uninvoiced hours view

### Phase 4: Dashboard
- Active timer card
- Uninvoiced hours per client
- Monthly income, outstanding invoices, overdue invoices

### Phase 5: Invoice Builder
- Creation wizard: select client -> select mode (date range/project/all uninvoiced) -> select entries -> review
- Detailed breakdown mode (group by date) vs summary mode (single line)
- Manual line items, tax calculation, late fee calculation
- Invoice numbering, due date auto-calc from payment terms
- Status management (Draft -> Sent -> Paid -> Overdue)
- Payment recording (method, amount, partial support)
- Mark entries as invoiced in same transaction

### Phase 6: PDF Generation
- Base template + 3 implementations (minimal, detailed, modern developer)
- Payment section with ACH details + optional Stripe link
- Payment terms + late fee clause rendering
- PDF preview, save locally, store path in DB

### Phase 7: Work Reports
- Non-financial PDF report generator
- Date range, grouped by date, hours + description + issue ref

### Phase 8: Email & Export
- Email with PDF attachment via device client, pre-filled subject from format template
- CSV/XLSX time entry export
- Monthly/yearly income summaries
- Invoice PDF export

### Phase 9: Backup & Restore
- EncryptionService (AES-256-GCM + PBKDF2)
- Google Sign-In + Drive integration (`/CodeLedger/` folder)
- Backup/restore flow with passphrase
- Optional automatic daily backup

### Phase 10: Polish
- Unit/widget/integration tests
- Empty states, error handling, loading states
- Edge cases (midnight spanning, timezones)
- Dark mode refinement
- App icon, splash screen
- Fast clock-in UX optimization

---

## Verification

- After Phase 1: `flutter run` launches app, DB created with seed data
- After Phase 2: CRUD works for profile/clients/projects, visibility toggles save
- After Phase 3: Clock in/out works, timer survives restart, overlaps rejected, summaries correct
- After Phase 4: Dashboard shows live data for all 5 summary cards
- After Phase 5: Invoice generates from entries, numbering increments, payment recording works, late fees calculate
- After Phase 6: PDF renders with all 3 templates, payment section shows ACH + Stripe correctly
- After Phase 7: Work report PDF generates without financial data
- After Phase 8: Email opens with attachment, CSV/XLSX exports open correctly
- After Phase 9: Backup encrypts + uploads to Drive `/CodeLedger/`, restore works
- Run `flutter test` after each phase
