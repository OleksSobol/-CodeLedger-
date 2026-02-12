import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/invoice_dao.dart';
import '../../../../core/constants/payment_terms.dart';
import '../../../../core/constants/payment_terms.dart';
import '../../../clients/presentation/providers/client_providers.dart';
import '../../../dashboard/presentation/providers/dashboard_provider.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

// ── Status filter ──────────────────────────────────────────────────
final invoiceStatusFilterProvider = StateProvider<String?>((ref) => null);

// ── All invoices stream ────────────────────────────────────────────
final allInvoicesProvider = StreamProvider<List<Invoice>>((ref) {
  return ref.watch(invoiceDaoProvider).watchInvoices();
});

// ── Filtered invoices ──────────────────────────────────────────────
final filteredInvoicesProvider = Provider<AsyncValue<List<Invoice>>>((ref) {
  final allAsync = ref.watch(allInvoicesProvider);
  final statusFilter = ref.watch(invoiceStatusFilterProvider);

  return allAsync.whenData((invoices) {
    if (statusFilter == null) return invoices;
    return invoices.where((i) => i.status == statusFilter).toList();
  });
});

// ── Single invoice by ID ───────────────────────────────────────────
final invoiceDetailProvider =
    FutureProvider.family<Invoice, int>((ref, id) async {
  return ref.watch(invoiceDaoProvider).getInvoice(id);
});

// ── Line items for invoice ─────────────────────────────────────────
final invoiceLineItemsProvider =
    StreamProvider.family<List<InvoiceLineItem>, int>((ref, invoiceId) {
  return ref.watch(invoiceDaoProvider).watchLineItems(invoiceId);
});

// ── Uninvoiced entries for a client ────────────────────────────────
final uninvoicedEntriesProvider =
    FutureProvider.family<List<TimeEntry>, int>((ref, clientId) async {
  return ref.watch(timeEntryDaoProvider).getUninvoicedForClient(clientId);
});

// ── Invoice wizard state ───────────────────────────────────────────

class InvoiceWizardState {
  final int? clientId;
  final List<TimeEntry> selectedEntries;
  final List<ManualLineItem> manualLineItems;
  final String? notes;
  final double? taxRateOverride;

  const InvoiceWizardState({
    this.clientId,
    this.selectedEntries = const [],
    this.manualLineItems = const [],
    this.notes,
    this.taxRateOverride,
  });

  InvoiceWizardState copyWith({
    int? clientId,
    List<TimeEntry>? selectedEntries,
    List<ManualLineItem>? manualLineItems,
    String? notes,
    double? taxRateOverride,
  }) {
    return InvoiceWizardState(
      clientId: clientId ?? this.clientId,
      selectedEntries: selectedEntries ?? this.selectedEntries,
      manualLineItems: manualLineItems ?? this.manualLineItems,
      notes: notes ?? this.notes,
      taxRateOverride: taxRateOverride ?? this.taxRateOverride,
    );
  }

  double get subtotal {
    final entriesTotal = selectedEntries.fold<double>(0, (sum, e) {
      final hours = (e.durationMinutes ?? 0) / 60.0;
      return sum + hours * e.hourlyRateSnapshot;
    });
    final manualTotal =
        manualLineItems.fold<double>(0, (sum, m) => sum + m.total);
    return entriesTotal + manualTotal;
  }
}

class ManualLineItem {
  final String description;
  final double quantity;
  final double unitPrice;

  const ManualLineItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get total => quantity * unitPrice;
}

final invoiceWizardProvider =
    StateNotifierProvider<InvoiceWizardNotifier, InvoiceWizardState>(
        (ref) => InvoiceWizardNotifier());

class InvoiceWizardNotifier extends StateNotifier<InvoiceWizardState> {
  InvoiceWizardNotifier() : super(const InvoiceWizardState());

  void setClient(int clientId) {
    state = InvoiceWizardState(clientId: clientId);
  }

  void setSelectedEntries(List<TimeEntry> entries) {
    state = state.copyWith(selectedEntries: entries);
  }

  void toggleEntry(TimeEntry entry) {
    final current = List<TimeEntry>.from(state.selectedEntries);
    final idx = current.indexWhere((e) => e.id == entry.id);
    if (idx >= 0) {
      current.removeAt(idx);
    } else {
      current.add(entry);
    }
    state = state.copyWith(selectedEntries: current);
  }

  void selectAll(List<TimeEntry> entries) {
    state = state.copyWith(selectedEntries: entries);
  }

  void deselectAll() {
    state = state.copyWith(selectedEntries: []);
  }

  void addManualLineItem(ManualLineItem item) {
    state = state.copyWith(
      manualLineItems: [...state.manualLineItems, item],
    );
  }

  void removeManualLineItem(int index) {
    final items = List<ManualLineItem>.from(state.manualLineItems);
    items.removeAt(index);
    state = state.copyWith(manualLineItems: items);
  }

  void setNotes(String? notes) {
    state = state.copyWith(notes: notes);
  }

  void setTaxRateOverride(double? rate) {
    state = state.copyWith(taxRateOverride: rate);
  }

  void reset() {
    state = const InvoiceWizardState();
  }
}

// ── Invoice notifier — create, update status, record payment ───────
final invoiceNotifierProvider =
    AsyncNotifierProvider<InvoiceNotifier, void>(InvoiceNotifier.new);

class InvoiceNotifier extends AsyncNotifier<void> {
  late InvoiceDao _invoiceDao;
  late UserProfileDao _profileDao;

  @override
  Future<void> build() async {
    _invoiceDao = ref.watch(invoiceDaoProvider);
    _profileDao = ref.watch(userProfileDaoProvider);
  }

  /// Create an invoice from the wizard state.
  Future<int> createInvoice() async {
    final wizard = ref.read(invoiceWizardProvider);
    if (wizard.clientId == null) throw Exception('No client selected');
    if (wizard.selectedEntries.isEmpty && wizard.manualLineItems.isEmpty) {
      throw Exception('No entries or line items selected');
    }

    final profile = await _profileDao.getProfile();
    final client =
        await ref.read(clientDaoProvider).getClient(wizard.clientId!);

    // Resolve payment terms
    final termsStr =
        client.paymentTermsOverride ?? profile.defaultPaymentTerms;
    final terms = PaymentTerms.fromString(termsStr);
    final termsDays = terms.resolveDays(
      customDays:
          client.paymentTermsDaysOverride ?? profile.defaultPaymentTermsDays,
    );

    // Resolve tax rate
    final taxRate =
        wizard.taxRateOverride ?? client.taxRate ?? profile.defaultTaxRate;
    final taxLabel = profile.defaultTaxLabel;

    // Get invoice number
    final invoiceNumber = await _profileDao.getNextInvoiceNumber();

    // Calculate totals
    final subtotal = wizard.subtotal;
    final taxAmount = subtotal * (taxRate / 100);
    final total = subtotal + taxAmount;

    // Determine period
    DateTime? periodStart;
    DateTime? periodEnd;
    if (wizard.selectedEntries.isNotEmpty) {
      periodStart = wizard.selectedEntries
          .map((e) => e.startTime)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      periodEnd = wizard.selectedEntries
          .map((e) => e.endTime ?? e.startTime)
          .reduce((a, b) => a.isAfter(b) ? a : b);
    }

    final now = DateTime.now();
    final dueDate = now.add(Duration(days: termsDays));

    // Build line items from time entries
    final lineItems = <InvoiceLineItemsCompanion>[];
    var sortOrder = 0;

    for (final entry in wizard.selectedEntries) {
      final hours = (entry.durationMinutes ?? 0) / 60.0;
      final desc = entry.description ?? 'Work session';
      lineItems.add(InvoiceLineItemsCompanion.insert(
        invoiceId: 0, // will be set by DAO
        description: desc,
        quantity: hours,
        unitPrice: entry.hourlyRateSnapshot,
        total: hours * entry.hourlyRateSnapshot,
        sortOrder: Value(sortOrder++),
        timeEntryId: Value(entry.id),
        projectId: Value(entry.projectId),
      ));
    }

    for (final manual in wizard.manualLineItems) {
      lineItems.add(InvoiceLineItemsCompanion.insert(
        invoiceId: 0,
        description: manual.description,
        quantity: manual.quantity,
        unitPrice: manual.unitPrice,
        total: manual.total,
        sortOrder: Value(sortOrder++),
      ));
    }

    final invoiceId = await _invoiceDao.createInvoice(
      invoice: InvoicesCompanion.insert(
        clientId: wizard.clientId!,
        invoiceNumber: invoiceNumber,
        issueDate: now,
        dueDate: dueDate,
        periodStart: Value(periodStart),
        periodEnd: Value(periodEnd),
        subtotal: Value(subtotal),
        taxRate: Value(taxRate),
        taxLabel: Value(taxLabel),
        taxAmount: Value(taxAmount),
        total: Value(total),
        currency: Value(client.currency),
        notes: Value(wizard.notes),
      ),
      lineItems: lineItems,
      timeEntryIds: wizard.selectedEntries.map((e) => e.id).toList(),
    );

    // Reset wizard & invalidate dependent providers
    ref.read(invoiceWizardProvider.notifier).reset();
    ref.invalidate(allInvoicesProvider);
    ref.invalidate(uninvoicedByClientProvider);
    ref.invalidate(monthlyIncomeProvider);

    return invoiceId;
  }

  /// Update invoice status (draft -> sent -> paid / overdue / cancelled).
  Future<void> updateStatus(int invoiceId, String status) async {
    await _invoiceDao.updateStatus(invoiceId, status);
    ref.invalidate(allInvoicesProvider);
    ref.invalidate(invoiceDetailProvider(invoiceId));
    ref.invalidate(outstandingInvoicesProvider);
    ref.invalidate(overdueInvoicesProvider);
    ref.invalidate(monthlyIncomeProvider);
  }

  /// Record a payment on an invoice.
  Future<void> recordPayment({
    required int invoiceId,
    required double amount,
    required String method,
  }) async {
    await _invoiceDao.recordPayment(
      invoiceId: invoiceId,
      amount: amount,
      method: method,
    );
    ref.invalidate(allInvoicesProvider);
    ref.invalidate(invoiceDetailProvider(invoiceId));
    ref.invalidate(outstandingInvoicesProvider);
    ref.invalidate(overdueInvoicesProvider);
    ref.invalidate(monthlyIncomeProvider);
  }

  /// Delete a draft invoice.
  Future<void> deleteDraft(int invoiceId) async {
    await _invoiceDao.deleteDraftInvoice(invoiceId);
    ref.invalidate(allInvoicesProvider);
    ref.invalidate(uninvoicedByClientProvider);
  }
}
