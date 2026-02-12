import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/profile_provider.dart';

class InvoiceSettingsSection extends ConsumerStatefulWidget {
  final UserProfile profile;

  const InvoiceSettingsSection({super.key, required this.profile});

  @override
  ConsumerState<InvoiceSettingsSection> createState() =>
      _InvoiceSettingsSectionState();
}

class _InvoiceSettingsSectionState
    extends ConsumerState<InvoiceSettingsSection> {
  late final TextEditingController _prefixCtrl;
  late final TextEditingController _emailSubjectCtrl;

  @override
  void initState() {
    super.initState();
    _prefixCtrl =
        TextEditingController(text: widget.profile.invoiceNumberPrefix);
    _emailSubjectCtrl = TextEditingController(
        text: widget.profile.defaultEmailSubjectFormat);
  }

  @override
  void dispose() {
    _prefixCtrl.dispose();
    _emailSubjectCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await ref.read(profileNotifierProvider.notifier).updateInvoiceSettings(
          invoiceNumberPrefix: _prefixCtrl.text.trim(),
          defaultEmailSubjectFormat: _emailSubjectCtrl.text.trim(),
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invoice settings saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invoice Settings',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prefixCtrl,
              decoration: const InputDecoration(
                labelText: 'Invoice Number Prefix',
                hintText: 'INV-',
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Next invoice: ${widget.profile.invoiceNumberPrefix}${widget.profile.nextInvoiceNumber.toString().padLeft(4, '0')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _emailSubjectCtrl,
              decoration: const InputDecoration(
                labelText: 'Email Subject Format',
                hintText: 'Invoice #{number} – {period}',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Tokens: {number}, {period}, {client}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
