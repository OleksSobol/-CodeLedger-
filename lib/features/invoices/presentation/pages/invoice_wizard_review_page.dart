import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../providers/invoice_providers.dart';
import '../providers/template_providers.dart';
import '../../../clients/presentation/providers/client_providers.dart';

/// Wizard Step 3: Review and create the invoice.
class InvoiceWizardReviewPage extends ConsumerStatefulWidget {
  const InvoiceWizardReviewPage({super.key});

  @override
  ConsumerState<InvoiceWizardReviewPage> createState() =>
      _InvoiceWizardReviewPageState();
}

class _InvoiceWizardReviewPageState
    extends ConsumerState<InvoiceWizardReviewPage> {
  final _notesCtrl = TextEditingController();
  final _taxCtrl = TextEditingController();
  bool _creating = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill tax from client/profile defaults — user can override here
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _taxCtrl.dispose();
    super.dispose();
  }

  Future<void> _createInvoice() async {
    setState(() => _creating = true);

    // Apply overrides from the review form
    final notifier = ref.read(invoiceWizardProvider.notifier);
    final notesText = _notesCtrl.text.trim();
    if (notesText.isNotEmpty) notifier.setNotes(notesText);

    final taxText = _taxCtrl.text.trim();
    if (taxText.isNotEmpty) {
      final rate = double.tryParse(taxText);
      if (rate != null) notifier.setTaxRateOverride(rate);
    }

    try {
      await ref.read(invoiceNotifierProvider.notifier).createInvoice();
      if (mounted) {
        // Reset wizard state so re-entering starts fresh
        ref.read(invoiceWizardProvider.notifier).reset();
        // Navigate to invoices tab — go() replaces the root stack and
        // activates the correct StatefulShellRoute branch
        context.go('/invoices');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _creating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wizard = ref.watch(invoiceWizardProvider);
    final theme = Theme.of(context);

    if (wizard.clientId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go('/invoices/create');
      });
      return const SizedBox.shrink();
    }

    final clientAsync = ref.watch(clientByIdProvider(wizard.clientId!));
    final clientName =
        clientAsync.whenOrNull(data: (c) => c.name) ?? '...';

    final totalHours = wizard.selectedEntries.fold<int>(
        0, (sum, e) => sum + (e.durationMinutes ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Invoice'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('Step 3 of 3 — Review',
                style: theme.textTheme.bodySmall),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Summary card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Invoice Summary',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _SummaryRow(label: 'Client', value: clientName),
                  _SummaryRow(
                      label: 'Time Entries',
                      value: '${wizard.selectedEntries.length}'),
                  if (wizard.selectedEntries.isNotEmpty)
                    _SummaryRow(
                        label: 'Total Hours',
                        value: formatDuration(totalHours)),
                  if (wizard.manualLineItems.isNotEmpty)
                    _SummaryRow(
                        label: 'Manual Items',
                        value: '${wizard.manualLineItems.length}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Line items preview
          Text('Line Items',
              style: theme.textTheme.titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

          ...wizard.selectedEntries.map((entry) {
            final hours = (entry.durationMinutes ?? 0) / 60.0;
            return ListTile(
              dense: true,
              title: Text(entry.description ?? 'Work session',
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: Text(formatCurrency(hours * entry.hourlyRateSnapshot)),
            );
          }),
          ...wizard.manualLineItems.map((item) => ListTile(
                dense: true,
                title: Text(item.description,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                trailing: Text(formatCurrency(item.total)),
              )),

          const Divider(height: 32),

          // Invoice template picker
          ref.watch(allTemplatesProvider).when(
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const SizedBox.shrink(),
                data: (templates) {
                  return DropdownButtonFormField<int?>(
                    initialValue: wizard.templateId,
                    decoration: const InputDecoration(
                      labelText: 'Invoice Template',
                      border: OutlineInputBorder(),
                    ),
                    items: templates
                        .map((t) => DropdownMenuItem<int?>(
                              value: t.id,
                              child: Text(t.name),
                            ))
                        .toList(),
                    onChanged: (v) => ref
                        .read(invoiceWizardProvider.notifier)
                        .setTemplate(v),
                  );
                },
              ),
          const SizedBox(height: 16),

          // Tax override
          TextFormField(
            controller: _taxCtrl,
            decoration: const InputDecoration(
              labelText: 'Tax Rate Override (%)',
              hintText: 'Leave blank for default',
              border: OutlineInputBorder(),
              suffixText: '%',
            ),
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),

          // Notes
          TextFormField(
            controller: _notesCtrl,
            decoration: const InputDecoration(
              labelText: 'Notes',
              hintText: 'Optional notes for the invoice',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          // Totals
          Card(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal',
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(
                    formatCurrency(wizard.subtotal),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Create button
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              onPressed: _creating ? null : _createInvoice,
              icon: _creating
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.receipt),
              label: Text(_creating ? 'Creating...' : 'Create Invoice'),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label,
                  style: Theme.of(context).textTheme.bodySmall)),
          Expanded(
              child: Text(value,
                  style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
