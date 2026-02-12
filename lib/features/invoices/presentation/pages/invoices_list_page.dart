import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../providers/invoice_providers.dart';
import '../widgets/invoice_status_badge.dart';
import '../../../clients/presentation/providers/client_providers.dart';

class InvoicesListPage extends ConsumerWidget {
  const InvoicesListPage({super.key});

  static const _statuses = [null, 'draft', 'sent', 'paid', 'overdue'];
  static const _labels = ['All', 'Draft', 'Sent', 'Paid', 'Overdue'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(filteredInvoicesProvider);
    final currentFilter = ref.watch(invoiceStatusFilterProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/invoices/create'),
        icon: const Icon(Icons.add),
        label: const Text('New Invoice'),
      ),
      body: Column(
        children: [
          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: List.generate(_statuses.length, (i) {
                final isSelected = currentFilter == _statuses[i];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_labels[i]),
                    selected: isSelected,
                    onSelected: (_) {
                      ref.read(invoiceStatusFilterProvider.notifier).state =
                          _statuses[i];
                    },
                  ),
                );
              }),
            ),
          ),
          // Invoice list
          Expanded(
            child: invoicesAsync.when(
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (invoices) {
                if (invoices.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.receipt_long_outlined,
                            size: 64, color: theme.colorScheme.outline),
                        const SizedBox(height: 16),
                        Text('No invoices',
                            style: theme.textTheme.titleMedium),
                        const SizedBox(height: 8),
                        const Text('Create your first invoice'),
                      ],
                    ),
                  );
                }
                return _InvoiceListView(invoices: invoices);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _InvoiceListView extends ConsumerWidget {
  final List<Invoice> invoices;
  const _InvoiceListView({required this.invoices});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat.yMMMd();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        final inv = invoices[index];
        final clientAsync = ref.watch(clientByIdProvider(inv.clientId));
        final clientName = clientAsync.whenOrNull(
              data: (c) => c.name,
            ) ??
            '...';

        final balanceDue = inv.total - inv.amountPaid;

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            onTap: () => context.push('/invoices/${inv.id}'),
            title: Row(
              children: [
                Text(inv.invoiceNumber,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                InvoiceStatusBadge(status: inv.status),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '$clientName · Due ${dateFmt.format(inv.dueDate)}',
                style: theme.textTheme.bodySmall,
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatCurrency(inv.total, currency: inv.currency),
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                if (balanceDue > 0 && inv.status != 'draft')
                  Text(
                    'Due: ${formatCurrency(balanceDue, currency: inv.currency)}',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.error),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Provider to fetch a client by ID for display in the list.
final clientByIdProvider =
    FutureProvider.family<Client, int>((ref, clientId) async {
  return ref.watch(clientDaoProvider).getClient(clientId);
});
