# CodeLedger Database Schema

## Tables Overview
| Table | Purpose | PK | Notes |
|---|---|---|---|
| user_profiles | Singleton business profile | id (auto) | Always 1 row, seeded on create |
| clients | Client companies | id (auto) | name UNIQUE, soft-delete via isArchived |
| projects | Projects per client | id (auto) | UNIQUE(clientId, name) |
| time_entries | Clock in/out records | id (auto) | Overlap prevention in transactions |
| invoices | Generated invoices | id (auto) | invoiceNumber UNIQUE |
| invoice_line_items | Invoice breakdown | id (auto) | FK → invoices (CASCADE) |
| invoice_templates | PDF template config | id (auto) | 3 built-in seeded on create |
| app_settings | Key-value store | key (text) | JSON-encoded values |

## Foreign Key Relationships
```
user_profiles.defaultTemplateId → invoice_templates.id
clients.defaultTemplateId → invoice_templates.id
projects.clientId → clients.id
time_entries.clientId → clients.id
time_entries.projectId → projects.id (nullable)
time_entries.invoiceId → invoices.id (nullable)
invoices.clientId → clients.id
invoices.templateId → invoice_templates.id (nullable)
invoice_line_items.invoiceId → invoices.id
invoice_line_items.timeEntryId → time_entries.id (nullable)
invoice_line_items.projectId → projects.id (nullable)
```

## user_profiles (singleton)
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| businessName | text() | No | '' |
| ownerName | text() | No | '' |
| email | text() | Yes | null |
| phone | text() | Yes | null |
| addressLine1..country | text() | Yes | null |
| taxId | text() | Yes | null |
| showTaxId | boolean() | No | true |
| waBusinessLicense | text() | Yes | null |
| showWaLicense | boolean() | No | false |
| logoPath | text() | Yes | null |
| bankName | text() | Yes | null |
| bankAccountName | text() | Yes | null |
| bankAccountNumber | text() | Yes | null |
| bankRoutingNumber | text() | Yes | null |
| bankAccountType | text() | No | 'checking' |
| bankSwift | text() | Yes | null |
| bankIban | text() | Yes | null |
| showBankDetails | boolean() | No | true |
| stripePaymentLink | text() | Yes | null |
| showStripeLink | boolean() | No | false |
| paymentInstructions | text() | Yes | null |
| defaultCurrency | text() | No | 'USD' |
| defaultHourlyRate | real() | No | 0.0 |
| defaultTaxLabel | text() | No | 'Tax' |
| defaultTaxRate | real() | No | 0.0 |
| defaultPaymentTerms | text() | No | 'net_30' |
| defaultPaymentTermsDays | integer() | No | 30 |
| lateFeePercentage | real() | Yes | null |
| defaultTemplateId | integer() | Yes | null |
| defaultEmailSubjectFormat | text() | No | 'Invoice #{number} – {period}' |
| nextInvoiceNumber | integer() | No | 1 |
| invoiceNumberPrefix | text() | No | 'INV-' |
| createdAt / updatedAt | dateTime() | No | currentDateAndTime |

## clients
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| name | text().unique() | No | — |
| contactName | text() | Yes | null |
| email | text() | Yes | null |
| phone | text() | Yes | null |
| addressLine1..country | text() | Yes | null |
| hourlyRate | real() | Yes | null (use profile default) |
| currency | text() | No | 'USD' |
| taxRate | real() | Yes | null (use profile default) |
| defaultTemplateId | integer() | Yes | null |
| paymentTermsOverride | text() | Yes | null |
| paymentTermsDaysOverride | integer() | Yes | null |
| notes | text() | Yes | null |
| isArchived | boolean() | No | false |
| createdAt / updatedAt | dateTime() | No | currentDateAndTime |

**Computed (DAO queries, not stored):** uninvoiced hours, total billed, total paid

## projects
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| clientId | integer() FK→clients | No | — |
| name | text() | No | — |
| description | text() | Yes | null |
| hourlyRateOverride | real() | Yes | null |
| color | integer() | No | 0xFF2196F3 |
| isActive | boolean() | No | true |
| isArchived | boolean() | No | false |
| createdAt / updatedAt | dateTime() | No | currentDateAndTime |

**Unique constraint:** (clientId, name)

## time_entries
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| clientId | integer() FK→clients | No | — |
| projectId | integer() FK→projects | Yes | null |
| startTime | dateTime() | No | — |
| endTime | dateTime() | Yes | null (= running) |
| durationMinutes | integer() | Yes | null |
| description | text() | Yes | null |
| issueReference | text() | Yes | null |
| repository | text() | Yes | null |
| tags | text() | Yes | null (JSON array) |
| isManual | boolean() | No | false |
| hourlyRateSnapshot | real() | No | — |
| isInvoiced | boolean() | No | false |
| invoiceId | integer() FK→invoices | Yes | null |
| createdAt / updatedAt | dateTime() | No | currentDateAndTime |

## invoices
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| clientId | integer() FK→clients | No | — |
| invoiceNumber | text().unique() | No | — |
| status | text() | No | 'draft' |
| issueDate / dueDate | dateTime() | No | — |
| periodStart / periodEnd | dateTime() | Yes | null |
| subtotal | real() | No | 0.0 |
| taxRate | real() | No | 0.0 |
| taxLabel | text() | No | 'Tax' |
| taxAmount | real() | No | 0.0 |
| lateFeeAmount | real() | No | 0.0 |
| total | real() | No | 0.0 |
| amountPaid | real() | No | 0.0 |
| currency | text() | No | 'USD' |
| notes | text() | Yes | null |
| templateId | integer() FK→templates | Yes | null |
| templateType | text() | No | 'detailed' |
| pdfPath | text() | Yes | null |
| paymentMethod | text() | Yes | null |
| paidDate / sentDate | dateTime() | Yes | null |
| createdAt / updatedAt | dateTime() | No | currentDateAndTime |

**Status values:** draft, sent, paid, overdue, cancelled

## invoice_line_items
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| invoiceId | integer() FK→invoices | No | — |
| sortOrder | integer() | No | 0 |
| description | text() | No | — |
| quantity | real() | No | — |
| unitPrice | real() | No | — |
| total | real() | No | — |
| timeEntryId | integer() FK→time_entries | Yes | null |
| projectId | integer() FK→projects | Yes | null |
| createdAt | dateTime() | No | currentDateAndTime |

## invoice_templates
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| id | integer().autoIncrement() | No | auto |
| name | text() | No | — |
| templateKey | text().unique() | No | — |
| description | text() | Yes | null |
| isDefault | boolean() | No | false |
| primaryColor | integer() | No | 0xFF2196F3 |
| accentColor | integer() | No | 0xFF1565C0 |
| fontFamily | text() | No | 'Helvetica' |
| showLogo | boolean() | No | true |
| showPaymentInfo | boolean() | No | true |
| showTaxBreakdown | boolean() | No | true |
| showTaxId | boolean() | No | true |
| showBusinessLicense | boolean() | No | false |
| showBankDetails | boolean() | No | true |
| showStripeLink | boolean() | No | false |
| showDetailedBreakdown | boolean() | No | true |
| showPaymentTerms | boolean() | No | true |
| showLateFeeClause | boolean() | No | false |
| footerText | text() | Yes | null |
| isBuiltIn | boolean() | No | true |
| createdAt / updatedAt | dateTime() | No | currentDateAndTime |

**Seeded templates:** minimal, detailed, modern_developer

## app_settings (key-value)
| Column | Drift Type | Nullable | Default |
|---|---|---|---|
| key | text() | No | — (PK) |
| value | text() | No | — |
| updatedAt | dateTime() | No | currentDateAndTime |
