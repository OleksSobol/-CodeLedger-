# CodeLedger DAO Reference

## Files
All DAOs in `lib/core/database/daos/`

## UserProfileDao (`user_profile_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `getProfile()` | `Future<UserProfile>` | Gets single row (always exists) |
| `watchProfile()` | `Stream<UserProfile>` | Reactive stream |
| `updateProfile(UserProfilesCompanion)` | `Future<bool>` | Updates row id=1 |
| `getNextInvoiceNumber()` | `Future<String>` | Returns "INV-0042", auto-increments in transaction |

## ClientDao (`client_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `watchActiveClients()` | `Stream<List<Client>>` | Non-archived, sorted by name |
| `watchAllClients()` | `Stream<List<Client>>` | Including archived |
| `getClient(int id)` | `Future<Client>` | |
| `insertClient(ClientsCompanion)` | `Future<int>` | Returns new id |
| `updateClient(int id, ClientsCompanion)` | `Future<bool>` | Auto-sets updatedAt |
| `archiveClient(int id)` | `Future<bool>` | Soft delete |
| `getUninvoicedMinutes(int clientId)` | `Future<int>` | Sum of duration_minutes |
| `getTotalBilled(int clientId)` | `Future<double>` | Sum of invoice totals |
| `getTotalPaid(int clientId)` | `Future<double>` | Sum of paid invoice totals |

## ProjectDao (`project_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `watchProjectsForClient(int clientId)` | `Stream<List<Project>>` | Active, non-archived |
| `getProjectsForClient(int clientId)` | `Future<List<Project>>` | |
| `watchAllActiveProjects()` | `Stream<List<Project>>` | Across all clients |
| `getProject(int id)` | `Future<Project>` | |
| `insertProject(ProjectsCompanion)` | `Future<int>` | |
| `updateProject(int id, ProjectsCompanion)` | `Future<bool>` | |
| `archiveProject(int id)` | `Future<bool>` | |

## TimeEntryDao (`time_entry_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `getRunningEntry()` | `Future<TimeEntry?>` | endTime is null |
| `watchRunningEntry()` | `Stream<TimeEntry?>` | Reactive |
| `insertWithOverlapCheck(companion)` | `Future<int>` | Transaction with overlap detection |
| `clockOut(int id, {String? desc})` | `Future<bool>` | Sets endTime + duration |
| `watchEntriesForDateRange(start, end)` | `Stream<List<TimeEntry>>` | Sorted desc by startTime |
| `getUninvoicedForClient(int clientId)` | `Future<List<TimeEntry>>` | Completed, not invoiced |
| `getUninvoicedForProject(int projectId)` | `Future<List<TimeEntry>>` | |
| `markAsInvoiced(List<int> ids, int invoiceId)` | `Future<void>` | |
| `unmarkInvoiced(int invoiceId)` | `Future<void>` | For draft deletion |
| `getAllEntries({from, to, clientId, projectId})` | `Future<List<TimeEntry>>` | For export |

**Exception:** `OverlappingTimeEntryException` thrown on overlap

## InvoiceDao (`invoice_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `watchInvoices({int? clientId})` | `Stream<List<Invoice>>` | Sorted desc by issueDate |
| `getInvoice(int id)` | `Future<Invoice>` | |
| `getLineItems(int invoiceId)` | `Future<List<InvoiceLineItem>>` | Sorted by sortOrder |
| `watchLineItems(int invoiceId)` | `Stream<List<InvoiceLineItem>>` | |
| `createInvoice({invoice, lineItems, timeEntryIds})` | `Future<int>` | Transaction: insert + mark entries |
| `updateStatus(int id, String status)` | `Future<bool>` | Auto-sets sentDate for 'sent' |
| `recordPayment({invoiceId, amount, method})` | `Future<bool>` | Transaction: partial payment support |
| `deleteDraftInvoice(int invoiceId)` | `Future<void>` | Transaction: unmark entries + delete |
| `getByStatus(String status)` | `Future<List<Invoice>>` | |
| `getOverdueInvoices()` | `Future<List<Invoice>>` | sent + past dueDate |
| `updatePdfPath(int invoiceId, String path)` | `Future<bool>` | |

## InvoiceTemplateDao (`invoice_template_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `watchAll()` | `Stream<List<InvoiceTemplate>>` | Sorted by name |
| `getAll()` | `Future<List<InvoiceTemplate>>` | |
| `getById(int id)` | `Future<InvoiceTemplate>` | |
| `getByKey(String key)` | `Future<InvoiceTemplate>` | e.g. 'minimal', 'detailed' |
| `getDefault()` | `Future<InvoiceTemplate?>` | isDefault = true |

## AppSettingsDao (`app_settings_dao.dart`)
| Method | Returns | Notes |
|---|---|---|
| `getValue(String key)` | `Future<String?>` | |
| `setValue(String key, String value)` | `Future<void>` | Upsert |
| `deleteKey(String key)` | `Future<void>` | |
