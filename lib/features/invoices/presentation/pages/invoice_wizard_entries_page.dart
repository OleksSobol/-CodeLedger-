import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../providers/invoice_providers.dart';

/// Wizard Step 2: Select time entries + add manual line items.
class InvoiceWizardEntriesPage extends ConsumerStatefulWidget {
  const InvoiceWizardEntriesPage({super.key});

  @override
  ConsumerState<InvoiceWizardEntriesPage> createState() =>
      _InvoiceWizardEntriesPageState();
}

class _InvoiceWizardEntriesPageState
    extends ConsumerState<InvoiceWizardEntriesPage> {
  @override
  Widget build(BuildContext context) {
    final wizard = ref.watch(invoiceWizardProvider);
    final theme = Theme.of(context);

    if (wizard.clientId == null) {
      // Shouldn't happen, but handle gracefully
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/invoices/create');
      });
      return const SizedBox.shrink();
    }

    final entriesAsync =
        ref.watch(uninvoicedEntriesProvider(wizard.clientId!));

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Invoice'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Step 2 of 3 — Select Entries',
                style: theme.textTheme.bodySmall),
          ),
        ),
      ),
      bottomNavigationBar: _BottomBar(wizard: wizard),
      body: entriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (entries) => _EntriesBody(
          entries: entries,
          wizard: wizard,
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final InvoiceWizardState wizard;
  const _BottomBar({required this.wizard});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasItems =
        wizard.selectedEntries.isNotEmpty || wizard.manualLineItems.isNotEmpty;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
            top: BorderSide(color: theme.colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Subtotal',
                      style: theme.textTheme.bodySmall),
                  Text(
                    formatCurrency(wizard.subtotal),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: hasItems
                  ? () => context.push('/invoices/create/review')
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Review'),
            ),
          ],
        ),
      ),
    );
  }
}

class _EntriesBody extends ConsumerWidget {
  final List<TimeEntry> entries;
  final InvoiceWizardState wizard;

  const _EntriesBody({required this.entries, required this.wizard});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final notifier = ref.read(invoiceWizardProvider.notifier);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Select all / deselect all
        if (entries.isNotEmpty)
          Row(
            children: [
              Text('Time Entries (${entries.length})',
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  if (wizard.selectedEntries.length == entries.length) {
                    notifier.deselectAll();
                  } else {
                    notifier.selectAll(entries);
                  }
                },
                child: Text(
                  wizard.selectedEntries.length == entries.length
                      ? 'Deselect All'
                      : 'Select All',
                ),
              ),
            ],
          ),

        // Time entries with checkboxes
        if (entries.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'No uninvoiced time entries for this client',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.outline),
              ),
            ),
          ),

        ...entries.map((entry) {
          final isSelected =
              wizard.selectedEntries.any((e) => e.id == entry.id);
          final dateFmt = DateFormat.yMMMd();
          final hours = (entry.durationMinutes ?? 0) / 60.0;
          final amount = hours * entry.hourlyRateSnapshot;

          return CheckboxListTile(
            value: isSelected,
            onChanged: (_) => notifier.toggleEntry(entry),
            title: Text(
              entry.description ?? 'Work session',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '${dateFmt.format(entry.startTime)} · ${formatDuration(entry.durationMinutes ?? 0)} · ${formatCurrency(amount)}',
              style: theme.textTheme.bodySmall,
            ),
            dense: true,
            controlAffinity: ListTileControlAffinity.leading,
          );
        }),

        const Divider(height: 32),

        // Manual line items section
        Row(
          children: [
            Text('Manual Line Items',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const Spacer(),
            TextButton.icon(
              onPressed: () => _showAddManualItemDialog(context, ref),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 8),

        if (wizard.manualLineItems.isEmpty)
          Text(
            'No manual line items',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.outline),
          ),

        ...wizard.manualLineItems.asMap().entries.map((e) {
          final idx = e.key;
          final item = e.value;
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(item.description),
              subtitle: Text(
                '${item.quantity} × ${formatCurrency(item.unitPrice)} = ${formatCurrency(item.total)}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: () => notifier.removeManualLineItem(idx),
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showAddManualItemDialog(BuildContext context, WidgetRef ref) {
    final descCtrl = TextEditingController();
    final qtyCtrl = TextEditingController(text: '1');
    final priceCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Line Item'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: descCtrl,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: qtyCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: priceCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Unit Price',
                        prefixText: '\$ ',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d{0,2}')),
                      ],
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ref.read(invoiceWizardProvider.notifier).addManualLineItem(
                      ManualLineItem(
                        description: descCtrl.text.trim(),
                        quantity: double.parse(qtyCtrl.text.trim()),
                        unitPrice: double.parse(priceCtrl.text.trim()),
                      ),
                    );
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
