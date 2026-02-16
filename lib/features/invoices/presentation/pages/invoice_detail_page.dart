import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../providers/invoice_providers.dart';
import '../widgets/invoice_status_badge.dart';
import '../widgets/record_payment_dialog.dart';
import '../../../clients/presentation/providers/client_providers.dart';
import '../../../pdf_generation/presentation/pages/pdf_preview_page.dart';
import '../../../pdf_generation/presentation/providers/pdf_providers.dart';
import '../../../email/presentation/providers/email_providers.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

class InvoiceDetailPage extends ConsumerWidget {
  final int invoiceId;
  const InvoiceDetailPage({super.key, required this.invoiceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoiceAsync = ref.watch(invoiceDetailProvider(invoiceId));
    final lineItemsAsync = ref.watch(invoiceLineItemsProvider(invoiceId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'View PDF',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PdfPreviewPage(
                    invoiceId: invoiceId,
                    invoiceNumber: invoiceAsync.value?.invoiceNumber ?? '',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined),
            tooltip: 'Email / Share',
            onPressed: () => _sendInvoice(context, ref, invoiceAsync.value),
          ),
        ],
      ),
      body: invoiceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (invoice) => _InvoiceDetailBody(
          invoice: invoice,
          lineItemsAsync: lineItemsAsync,
        ),
      ),
    );
  }

  Future<void> _sendInvoice(
      BuildContext context, WidgetRef ref, Invoice? invoice) async {
    if (invoice == null) return;

    try {
      // Generate PDF (refresh to pick up template/profile changes)
      final doc = await ref.refresh(invoicePdfProvider(invoiceId).future);
      final bytes = await doc.save();

      // Save to temp file
      final dir = await getTemporaryDirectory();
      final file = File(
          '${dir.path}/${invoice.invoiceNumber.replaceAll(RegExp(r'[^\w]'), '_')}.pdf');
      await file.writeAsBytes(bytes);

      // Build email subject from profile format
      final profile = await ref.read(userProfileDaoProvider).getProfile();
      final subject = profile.defaultEmailSubjectFormat
          .replaceAll('{number}', invoice.invoiceNumber)
          .replaceAll('{client}', '')
          .replaceAll('{period}', invoice.periodStart != null
              ? '${DateFormat.yMMMd().format(invoice.periodStart!)} – ${DateFormat.yMMMd().format(invoice.periodEnd!)}'
              : '');

      // Get client email
      final clientDao = ref.read(clientDaoProvider);
      final client = await clientDao.getClient(invoice.clientId);
      final recipients = <String>[if (client.email != null) client.email!];

      // Send
      final emailService = ref.read(emailServiceProvider);
      await emailService.sendInvoice(
        file: file,
        subject: subject,
        body: 'Please find attached invoice ${invoice.invoiceNumber}.',
        recipients: recipients,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}

class _InvoiceDetailBody extends ConsumerWidget {
  final Invoice invoice;
  final AsyncValue<List<InvoiceLineItem>> lineItemsAsync;

  const _InvoiceDetailBody({
    required this.invoice,
    required this.lineItemsAsync,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat.yMMMd();
    final clientAsync = ref.watch(clientByIdProvider(invoice.clientId));
    final clientName =
        clientAsync.whenOrNull(data: (c) => c.name) ?? '...';
    final balanceDue = invoice.total - invoice.amountPaid;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        invoice.invoiceNumber,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    InvoiceStatusBadge(status: invoice.status),
                  ],
                ),
                const SizedBox(height: 8),
                Text(clientName,
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                _InfoRow(
                    label: 'Issue Date',
                    value: dateFmt.format(invoice.issueDate)),
                _InfoRow(
                    label: 'Due Date',
                    value: dateFmt.format(invoice.dueDate)),
                if (invoice.periodStart != null && invoice.periodEnd != null)
                  _InfoRow(
                    label: 'Period',
                    value:
                        '${dateFmt.format(invoice.periodStart!)} – ${dateFmt.format(invoice.periodEnd!)}',
                  ),
                if (invoice.sentDate != null)
                  _InfoRow(
                      label: 'Sent',
                      value: dateFmt.format(invoice.sentDate!)),
                if (invoice.paidDate != null)
                  _InfoRow(
                      label: 'Paid',
                      value: dateFmt.format(invoice.paidDate!)),
                if (invoice.paymentMethod != null)
                  _InfoRow(
                      label: 'Method',
                      value: invoice.paymentMethod!),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Line items
        Text('Line Items',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        lineItemsAsync.when(
          loading: () =>
              const Center(child: CircularProgressIndicator()),
          error: (e, _) => Text('Error: $e'),
          data: (items) => Card(
            child: Column(
              children: [
                // Header row
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text('Description',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(fontWeight: FontWeight.bold))),
                      _ColHeader('Qty'),
                      _ColHeader('Rate'),
                      _ColHeader('Total'),
                    ],
                  ),
                ),
                ...items.map((item) => _LineItemRow(
                      item: item,
                      currency: invoice.currency,
                    )),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Totals card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _TotalRow(
                    label: 'Subtotal',
                    value: formatCurrency(invoice.subtotal,
                        currency: invoice.currency)),
                if (invoice.taxRate > 0) ...[
                  _TotalRow(
                      label:
                          '${invoice.taxLabel} (${invoice.taxRate.toStringAsFixed(1)}%)',
                      value: formatCurrency(invoice.taxAmount,
                          currency: invoice.currency)),
                ],
                if (invoice.lateFeeAmount > 0)
                  _TotalRow(
                      label: 'Late Fee',
                      value: formatCurrency(invoice.lateFeeAmount,
                          currency: invoice.currency)),
                const Divider(),
                _TotalRow(
                  label: 'Total',
                  value: formatCurrency(invoice.total,
                      currency: invoice.currency),
                  bold: true,
                ),
                if (invoice.amountPaid > 0)
                  _TotalRow(
                      label: 'Paid',
                      value: formatCurrency(invoice.amountPaid,
                          currency: invoice.currency),
                      color: Colors.green),
                if (balanceDue > 0 && invoice.status != 'draft')
                  _TotalRow(
                    label: 'Balance Due',
                    value: formatCurrency(balanceDue,
                        currency: invoice.currency),
                    bold: true,
                    color: theme.colorScheme.error,
                  ),
              ],
            ),
          ),
        ),

        // Notes
        if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Notes',
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(invoice.notes!),
            ),
          ),
        ],

        // Actions
        const SizedBox(height: 24),
        _buildActions(context, ref, invoice, balanceDue),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildActions(
      BuildContext context, WidgetRef ref, Invoice inv, double balanceDue) {
    final notifier = ref.read(invoiceNotifierProvider.notifier);

    return switch (inv.status) {
      'draft' => Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Delete Draft'),
                      content: const Text(
                          'This will delete the draft and unmark all linked time entries.'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(ctx, false),
                            child: const Text('Cancel')),
                        FilledButton(
                            onPressed: () => Navigator.pop(ctx, true),
                            child: const Text('Delete')),
                      ],
                    ),
                  );
                  if (confirm == true && context.mounted) {
                    await notifier.deleteDraft(inv.id);
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () async {
                  await notifier.updateStatus(inv.id, 'sent');
                },
                icon: const Icon(Icons.send),
                label: const Text('Mark Sent'),
              ),
            ),
          ],
        ),
      'sent' => Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () async {
                  final result = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => RecordPaymentDialog(
                      invoiceId: inv.id,
                      balanceDue: balanceDue,
                      currency: inv.currency,
                    ),
                  );
                  if (result == true) {
                    // Providers auto-invalidate
                  }
                },
                icon: const Icon(Icons.payment),
                label: const Text('Record Payment'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton.icon(
                onPressed: () async {
                  await notifier.recordPayment(
                    invoiceId: inv.id,
                    amount: balanceDue,
                    method: 'Other',
                  );
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Mark Paid'),
              ),
            ),
          ],
        ),
      'paid' => Column(
          children: [
            Chip(
              avatar: const Icon(Icons.check_circle, color: Colors.green),
              label: Text(
                  'Paid on ${DateFormat.yMMMd().format(inv.paidDate ?? inv.updatedAt)}'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmDelete(context, notifier, inv),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () async {
                      await notifier.archiveInvoice(inv.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invoice archived')),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.archive_outlined),
                    label: const Text('Archive'),
                  ),
                ),
              ],
            ),
          ],
        ),
      'archived' => Column(
          children: [
            Chip(
              avatar: const Icon(Icons.archive, color: Colors.grey),
              label: const Text('Archived'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmDelete(context, notifier, inv),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () async {
                      await notifier.unarchiveInvoice(inv.id);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invoice restored')),
                        );
                      }
                    },
                    icon: const Icon(Icons.unarchive_outlined),
                    label: const Text('Unarchive'),
                  ),
                ),
              ],
            ),
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }

  Future<void> _confirmDelete(
      BuildContext context, InvoiceNotifier notifier, Invoice inv) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Invoice'),
        content: Text(
          'Permanently delete ${inv.invoiceNumber}? '
          'Linked time entries will be unmarked.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true && context.mounted) {
      await notifier.deleteInvoice(inv.id);
      if (context.mounted) Navigator.of(context).pop();
    }
  }
}

// ── Helper widgets ─────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
              width: 100,
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

class _ColHeader extends StatelessWidget {
  final String text;
  const _ColHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: Text(text,
          textAlign: TextAlign.end,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

class _LineItemRow extends StatelessWidget {
  final InvoiceLineItem item;
  final String currency;
  const _LineItemRow({required this.item, required this.currency});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(item.description,
                style: theme.textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: 64,
            child: Text(item.quantity.toStringAsFixed(2),
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall),
          ),
          SizedBox(
            width: 64,
            child: Text(
                formatCurrency(item.unitPrice, currency: currency),
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall),
          ),
          SizedBox(
            width: 64,
            child: Text(formatCurrency(item.total, currency: currency),
                textAlign: TextAlign.end,
                style: theme.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  final Color? color;

  const _TotalRow({
    required this.label,
    required this.value,
    this.bold = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.bold, color: color)
        : Theme.of(context).textTheme.bodyMedium?.copyWith(color: color);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
