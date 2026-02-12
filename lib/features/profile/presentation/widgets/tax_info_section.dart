import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/profile_provider.dart';

class TaxInfoSection extends ConsumerStatefulWidget {
  final UserProfile profile;

  const TaxInfoSection({super.key, required this.profile});

  @override
  ConsumerState<TaxInfoSection> createState() => _TaxInfoSectionState();
}

class _TaxInfoSectionState extends ConsumerState<TaxInfoSection> {
  late final TextEditingController _taxIdCtrl;
  late final TextEditingController _waLicenseCtrl;
  late bool _showTaxId;
  late bool _showWaLicense;

  @override
  void initState() {
    super.initState();
    _taxIdCtrl = TextEditingController(text: widget.profile.taxId ?? '');
    _waLicenseCtrl =
        TextEditingController(text: widget.profile.waBusinessLicense ?? '');
    _showTaxId = widget.profile.showTaxId;
    _showWaLicense = widget.profile.showWaLicense;
  }

  @override
  void dispose() {
    _taxIdCtrl.dispose();
    _waLicenseCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await ref.read(profileNotifierProvider.notifier).updateTaxInfo(
          taxId: _taxIdCtrl.text.trim().isEmpty
              ? null
              : _taxIdCtrl.text.trim(),
          showTaxId: _showTaxId,
          waBusinessLicense: _waLicenseCtrl.text.trim().isEmpty
              ? null
              : _waLicenseCtrl.text.trim(),
          showWaLicense: _showWaLicense,
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tax info saved')),
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
            Text('Tax Information',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _taxIdCtrl,
              decoration: const InputDecoration(
                labelText: 'Tax ID (EIN/VAT/ABN)',
              ),
            ),
            SwitchListTile(
              title: const Text('Show Tax ID on invoices'),
              value: _showTaxId,
              onChanged: (v) => setState(() => _showTaxId = v),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _waLicenseCtrl,
              decoration: const InputDecoration(
                labelText: 'WA Business License',
              ),
            ),
            SwitchListTile(
              title: const Text('Show WA License on invoices'),
              value: _showWaLicense,
              onChanged: (v) => setState(() => _showWaLicense = v),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
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
