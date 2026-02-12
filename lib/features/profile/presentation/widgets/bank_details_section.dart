import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/profile_provider.dart';

class BankDetailsSection extends ConsumerStatefulWidget {
  final UserProfile profile;

  const BankDetailsSection({super.key, required this.profile});

  @override
  ConsumerState<BankDetailsSection> createState() =>
      _BankDetailsSectionState();
}

class _BankDetailsSectionState extends ConsumerState<BankDetailsSection> {
  late final TextEditingController _bankNameCtrl;
  late final TextEditingController _accountNameCtrl;
  late final TextEditingController _accountNumberCtrl;
  late final TextEditingController _routingNumberCtrl;
  late final TextEditingController _swiftCtrl;
  late final TextEditingController _ibanCtrl;
  late String _accountType;
  late bool _showBankDetails;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _bankNameCtrl = TextEditingController(text: p.bankName ?? '');
    _accountNameCtrl = TextEditingController(text: p.bankAccountName ?? '');
    _accountNumberCtrl =
        TextEditingController(text: p.bankAccountNumber ?? '');
    _routingNumberCtrl =
        TextEditingController(text: p.bankRoutingNumber ?? '');
    _swiftCtrl = TextEditingController(text: p.bankSwift ?? '');
    _ibanCtrl = TextEditingController(text: p.bankIban ?? '');
    _accountType = p.bankAccountType;
    _showBankDetails = p.showBankDetails;
  }

  @override
  void dispose() {
    _bankNameCtrl.dispose();
    _accountNameCtrl.dispose();
    _accountNumberCtrl.dispose();
    _routingNumberCtrl.dispose();
    _swiftCtrl.dispose();
    _ibanCtrl.dispose();
    super.dispose();
  }

  String? _trimOrNull(String text) {
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _save() async {
    await ref.read(profileNotifierProvider.notifier).updateBankDetails(
          bankName: _trimOrNull(_bankNameCtrl.text),
          bankAccountName: _trimOrNull(_accountNameCtrl.text),
          bankAccountNumber: _trimOrNull(_accountNumberCtrl.text),
          bankRoutingNumber: _trimOrNull(_routingNumberCtrl.text),
          bankAccountType: _accountType,
          bankSwift: _trimOrNull(_swiftCtrl.text),
          bankIban: _trimOrNull(_ibanCtrl.text),
          showBankDetails: _showBankDetails,
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bank details saved')),
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
            Text('ACH Bank Details',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bankNameCtrl,
              decoration: const InputDecoration(labelText: 'Bank Name'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _accountNameCtrl,
              decoration:
                  const InputDecoration(labelText: 'Account Holder Name'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _routingNumberCtrl,
              decoration:
                  const InputDecoration(labelText: 'Routing Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _accountNumberCtrl,
              decoration:
                  const InputDecoration(labelText: 'Account Number'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _accountType,
              decoration:
                  const InputDecoration(labelText: 'Account Type'),
              items: const [
                DropdownMenuItem(
                    value: 'checking', child: Text('Checking')),
                DropdownMenuItem(
                    value: 'savings', child: Text('Savings')),
              ],
              onChanged: (v) {
                if (v != null) setState(() => _accountType = v);
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _swiftCtrl,
              decoration: const InputDecoration(
                  labelText: 'SWIFT Code (international)'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ibanCtrl,
              decoration: const InputDecoration(
                  labelText: 'IBAN (international)'),
            ),
            SwitchListTile(
              title: const Text('Show bank details on invoices'),
              value: _showBankDetails,
              onChanged: (v) => setState(() => _showBankDetails = v),
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
