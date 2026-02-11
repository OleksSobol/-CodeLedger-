# CodeLedger Business Logic

## Rate Resolution (cascading)
```
effective_rate = project.hourlyRateOverride
                 ?? client.hourlyRate
                 ?? profile.defaultHourlyRate
```
Implemented in `lib/core/utils/rate_resolver.dart`

## Payment Terms Resolution
```
effective_terms = client.paymentTermsOverride ?? profile.defaultPaymentTerms
effective_days  = client.paymentTermsDaysOverride ?? profile.defaultPaymentTermsDays
due_date        = issue_date + effective_days
```

## Invoice Statuses
| Status | Meaning |
|---|---|
| draft | Created, not sent |
| sent | Sent to client (sentDate auto-set) |
| paid | amountPaid >= total (paidDate auto-set) |
| overdue | sent + past dueDate |
| cancelled | Voided |

Defined in `lib/core/constants/invoice_status.dart`

## Payment Terms
| Key | Days |
|---|---|
| net_7 | 7 |
| net_14 | 14 |
| net_30 | 30 |
| custom | user-defined |

Defined in `lib/core/constants/payment_terms.dart`

## Invoice Creation (single transaction)
1. Insert invoice record
2. Insert all line items with invoiceId
3. Mark selected time entries as invoiced (isInvoiced=true, invoiceId=X)

## Payment Recording (single transaction)
1. Fetch current invoice
2. newPaid = amountPaid + payment amount
3. Update amountPaid, paymentMethod
4. If newPaid >= total → set status='paid', paidDate=now

## Late Fee Calculation
```
if status == 'overdue' && lateFeePercentage != null:
    lateFee = subtotal * (lateFeePercentage / 100)
```

## Draft Invoice Deletion (single transaction)
1. Unmark time entries (isInvoiced=false, invoiceId=null)
2. Delete line items
3. Delete invoice

## Time Entry Overlap Prevention
- Application-layer check in transaction before INSERT/UPDATE
- Query: `existing.startTime < new.endTime AND existing.endTime > new.startTime`
- Throws `OverlappingTimeEntryException`

## Invoice Numbering
- `nextInvoiceNumber` stored in user_profiles
- Format: `{prefix}{number padded to 4}` → "INV-0042"
- Auto-incremented in transaction via `getNextInvoiceNumber()`

## Invoice Templates (Strategy Pattern)
Three built-in:
1. **minimal** — Clean single-line, no detailed breakdown
2. **detailed** — Grouped by date, session descriptions + issue refs
3. **modern_developer** — Tech-focused, repo/issue refs prominent, teal color scheme

Each template respects toggle flags:
- showLogo, showPaymentInfo, showTaxBreakdown, showTaxId
- showBusinessLicense, showBankDetails, showStripeLink
- showDetailedBreakdown, showPaymentTerms, showLateFeeClause

## Visibility Toggles (user_profiles)
| Toggle | Controls |
|---|---|
| showTaxId | Tax ID / EIN on invoices |
| showWaLicense | WA state business license on invoices |
| showBankDetails | ACH bank info section |
| showStripeLink | Stripe payment link |

## Email Subject Format
Tokenized: `'Invoice #{number} – {period}'`
Tokens replaced at send time with actual invoice number and period.

## Backup Encryption
- AES-256-GCM with PBKDF2-HMAC-SHA256
- Salt: 32 bytes random per backup
- PBKDF2: 100,000 iterations
- File: `salt(32B) + nonce(12B) + MAC(16B) + ciphertext`
- Drive folder: `/CodeLedger/`
- Naming: `codeledger_backup_YYYYMMDD_HHmmss.enc`
- Integrity check on restore: `PRAGMA integrity_check`

## Data Safety
- WAL mode: `PRAGMA journal_mode = WAL`
- Foreign keys: `PRAGMA foreign_keys = ON`
- All multi-table ops wrapped in transactions
- Pre-migration backup of DB file before schema upgrades
