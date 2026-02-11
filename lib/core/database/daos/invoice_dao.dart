import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/invoices_table.dart';
import '../tables/invoice_line_items_table.dart';
import '../tables/time_entries_table.dart';

part 'invoice_dao.g.dart';

@DriftAccessor(tables: [Invoices, InvoiceLineItems, TimeEntries])
class InvoiceDao extends DatabaseAccessor<AppDatabase>
    with _$InvoiceDaoMixin {
  InvoiceDao(super.db);

  /// Watch all invoices, optionally filtered by client.
  Stream<List<Invoice>> watchInvoices({int? clientId}) {
    final query = select(invoices);
    if (clientId != null) {
      query.where((t) => t.clientId.equals(clientId));
    }
    query.orderBy([(t) => OrderingTerm.desc(t.issueDate)]);
    return query.watch();
  }

  Future<Invoice> getInvoice(int id) {
    return (select(invoices)..where((t) => t.id.equals(id))).getSingle();
  }

  /// Get line items for an invoice.
  Future<List<InvoiceLineItem>> getLineItems(int invoiceId) {
    return (select(invoiceLineItems)
          ..where((t) => t.invoiceId.equals(invoiceId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Stream<List<InvoiceLineItem>> watchLineItems(int invoiceId) {
    return (select(invoiceLineItems)
          ..where((t) => t.invoiceId.equals(invoiceId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  /// Create an invoice with line items in a transaction.
  Future<int> createInvoice({
    required InvoicesCompanion invoice,
    required List<InvoiceLineItemsCompanion> lineItems,
    required List<int> timeEntryIds,
  }) {
    return transaction(() async {
      final invoiceId = await into(invoices).insert(invoice);

      // Insert line items
      for (final item in lineItems) {
        await into(invoiceLineItems).insert(
          item.copyWith(invoiceId: Value(invoiceId)),
        );
      }

      // Mark time entries as invoiced
      if (timeEntryIds.isNotEmpty) {
        await (update(timeEntries)
              ..where((t) => t.id.isIn(timeEntryIds)))
            .write(TimeEntriesCompanion(
              isInvoiced: const Value(true),
              invoiceId: Value(invoiceId),
              updatedAt: Value(DateTime.now()),
            ));
      }

      return invoiceId;
    });
  }

  /// Update invoice status.
  Future<bool> updateStatus(int id, String status) {
    final companion = InvoicesCompanion(
      status: Value(status),
      updatedAt: Value(DateTime.now()),
    );

    // Auto-set sent_date when marking as sent
    if (status == 'sent') {
      return (update(invoices)..where((t) => t.id.equals(id)))
          .write(companion.copyWith(sentDate: Value(DateTime.now())))
          .then((rows) => rows > 0);
    }

    return (update(invoices)..where((t) => t.id.equals(id)))
        .write(companion)
        .then((rows) => rows > 0);
  }

  /// Record a payment.
  Future<bool> recordPayment({
    required int invoiceId,
    required double amount,
    required String method,
  }) {
    return transaction(() async {
      final invoice = await getInvoice(invoiceId);
      final newPaid = invoice.amountPaid + amount;
      final isPaid = newPaid >= invoice.total;

      return (update(invoices)..where((t) => t.id.equals(invoiceId)))
          .write(InvoicesCompanion(
            amountPaid: Value(newPaid),
            paymentMethod: Value(method),
            status: isPaid ? const Value('paid') : const Value.absent(),
            paidDate: isPaid ? Value(DateTime.now()) : const Value.absent(),
            updatedAt: Value(DateTime.now()),
          ))
          .then((rows) => rows > 0);
    });
  }

  /// Delete a draft invoice and unmark its time entries.
  Future<void> deleteDraftInvoice(int invoiceId) {
    return transaction(() async {
      // Unmark time entries
      await (update(timeEntries)
            ..where((t) => t.invoiceId.equals(invoiceId)))
          .write(const TimeEntriesCompanion(
            isInvoiced: Value(false),
            invoiceId: Value(null),
          ));

      // Delete line items (cascade should handle this, but explicit is safer)
      await (delete(invoiceLineItems)
            ..where((t) => t.invoiceId.equals(invoiceId)))
          .go();

      // Delete invoice
      await (delete(invoices)..where((t) => t.id.equals(invoiceId))).go();
    });
  }

  /// Get invoices by status (for dashboard).
  Future<List<Invoice>> getByStatus(String status) {
    return (select(invoices)
          ..where((t) => t.status.equals(status))
          ..orderBy([(t) => OrderingTerm.desc(t.issueDate)]))
        .get();
  }

  /// Get overdue invoices (sent + past due date).
  Future<List<Invoice>> getOverdueInvoices() {
    return (select(invoices)
          ..where((t) =>
              t.status.equals('sent') &
              t.dueDate.isSmallerThanValue(DateTime.now())))
        .get();
  }

  /// Update invoice PDF path.
  Future<bool> updatePdfPath(int invoiceId, String path) {
    return (update(invoices)..where((t) => t.id.equals(invoiceId)))
        .write(InvoicesCompanion(
          pdfPath: Value(path),
          updatedAt: Value(DateTime.now()),
        ))
        .then((rows) => rows > 0);
  }
}
