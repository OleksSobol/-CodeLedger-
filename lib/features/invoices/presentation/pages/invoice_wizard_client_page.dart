import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../clients/presentation/providers/client_providers.dart';
import '../providers/invoice_providers.dart';

/// Wizard Step 1: Select a client.
class InvoiceWizardClientPage extends ConsumerWidget {
  const InvoiceWizardClientPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(activeClientsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Invoice'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Step 1 of 3 — Select Client',
                style: theme.textTheme.bodySmall),
          ),
        ),
      ),
      body: clientsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (clients) {
          if (clients.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline,
                      size: 64, color: theme.colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('No clients', style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text('Add a client before creating an invoice'),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => context.push('/clients/add'),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Client'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              return _ClientSelectionTile(client: client);
            },
          );
        },
      ),
    );
  }
}

class _ClientSelectionTile extends ConsumerWidget {
  final Client client;
  const _ClientSelectionTile({required this.client});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uninvoicedAsync = ref.watch(uninvoicedEntriesProvider(client.id));
    final entryCount = uninvoicedAsync.whenOrNull(
          data: (entries) => entries.length,
        ) ??
        0;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(client.name[0].toUpperCase()),
        ),
        title: Text(client.name),
        subtitle: Text(
          entryCount > 0
              ? '$entryCount uninvoiced entries'
              : 'No uninvoiced entries',
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ref.read(invoiceWizardProvider.notifier).setClient(client.id);
          context.push('/invoices/create/entries');
        },
      ),
    );
  }
}
