import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/profile_provider.dart';
import '../../../invoices/presentation/providers/template_providers.dart';

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
  late final TextEditingController _counterCtrl;
  late final TextEditingController _emailSubjectCtrl;
  int? _selectedTemplateId;

  @override
  void initState() {
    super.initState();
    _prefixCtrl =
        TextEditingController(text: widget.profile.invoiceNumberPrefix);
    _counterCtrl = TextEditingController(
        text: widget.profile.nextInvoiceNumber.toString());
    _emailSubjectCtrl = TextEditingController(
        text: widget.profile.defaultEmailSubjectFormat);
    _selectedTemplateId = widget.profile.defaultTemplateId;
  }

  @override
  void dispose() {
    _prefixCtrl.dispose();
    _counterCtrl.dispose();
    _emailSubjectCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final counterValue = int.tryParse(_counterCtrl.text.trim());
    if (counterValue == null || counterValue < 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Next invoice number must be at least 1')),
      );
      return;
    }
    await ref.read(profileNotifierProvider.notifier).updateInvoiceSettings(
          invoiceNumberPrefix: _prefixCtrl.text.trim(),
          defaultEmailSubjectFormat: _emailSubjectCtrl.text.trim(),
          defaultTemplateId: _selectedTemplateId,
          nextInvoiceNumber: counterValue,
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invoice settings saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final templatesAsync = ref.watch(allTemplatesProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Invoice Settings', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prefixCtrl,
              decoration: const InputDecoration(
                labelText: 'Invoice Number Prefix',
                hintText: 'INV-',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _counterCtrl,
              decoration: InputDecoration(
                labelText: 'Next Invoice Number',
                helperText:
                    'Preview: ${_prefixCtrl.text}${(int.tryParse(_counterCtrl.text) ?? 1).toString().padLeft(4, '0')}',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
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
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            // Default invoice template picker
            templatesAsync.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, __) =>
                  Text('Could not load templates', style: theme.textTheme.bodySmall),
              data: (templates) {
                return DropdownButtonFormField<int?>(
                  initialValue: _selectedTemplateId,
                  decoration: const InputDecoration(
                    labelText: 'Default Invoice Template',
                  ),
                  items: templates
                      .map((t) => DropdownMenuItem<int?>(
                            value: t.id,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(t.name),
                                if (t.description != null)
                                  Text(t.description!,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: 0.6))),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedTemplateId = v),
                );
              },
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
