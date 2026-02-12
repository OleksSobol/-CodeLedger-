import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/constants/payment_terms.dart';
import '../providers/profile_provider.dart';

class DefaultsSection extends ConsumerStatefulWidget {
  final UserProfile profile;

  const DefaultsSection({super.key, required this.profile});

  @override
  ConsumerState<DefaultsSection> createState() => _DefaultsSectionState();
}

class _DefaultsSectionState extends ConsumerState<DefaultsSection> {
  late final TextEditingController _currencyCtrl;
  late final TextEditingController _hourlyRateCtrl;
  late final TextEditingController _taxLabelCtrl;
  late final TextEditingController _taxRateCtrl;
  late final TextEditingController _customDaysCtrl;
  late final TextEditingController _lateFeeCtrl;
  late PaymentTerms _paymentTerms;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _currencyCtrl = TextEditingController(text: p.defaultCurrency);
    _hourlyRateCtrl =
        TextEditingController(text: p.defaultHourlyRate.toString());
    _taxLabelCtrl = TextEditingController(text: p.defaultTaxLabel);
    _taxRateCtrl = TextEditingController(text: p.defaultTaxRate.toString());
    _paymentTerms = PaymentTerms.fromString(p.defaultPaymentTerms);
    _customDaysCtrl =
        TextEditingController(text: p.defaultPaymentTermsDays.toString());
    _lateFeeCtrl = TextEditingController(
        text: p.lateFeePercentage?.toString() ?? '');
  }

  @override
  void dispose() {
    _currencyCtrl.dispose();
    _hourlyRateCtrl.dispose();
    _taxLabelCtrl.dispose();
    _taxRateCtrl.dispose();
    _customDaysCtrl.dispose();
    _lateFeeCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final rate = double.tryParse(_hourlyRateCtrl.text) ?? 0.0;
    final taxRate = double.tryParse(_taxRateCtrl.text) ?? 0.0;
    final customDays = int.tryParse(_customDaysCtrl.text) ?? 30;
    final lateFee = _lateFeeCtrl.text.trim().isEmpty
        ? null
        : double.tryParse(_lateFeeCtrl.text);

    await ref.read(profileNotifierProvider.notifier).updateDefaults(
          defaultCurrency: _currencyCtrl.text.trim().toUpperCase(),
          defaultHourlyRate: rate,
          defaultTaxLabel: _taxLabelCtrl.text.trim(),
          defaultTaxRate: taxRate,
          defaultPaymentTerms: _paymentTerms.value,
          defaultPaymentTermsDays:
              _paymentTerms.resolveDays(customDays: customDays),
          lateFeePercentage: lateFee,
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Defaults saved')),
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
            Text('Defaults',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _currencyCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Currency (ISO)'),
                    textCapitalization: TextCapitalization.characters,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _hourlyRateCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Hourly Rate'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _taxLabelCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Tax Label (e.g. Tax, GST)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _taxRateCtrl,
                    decoration:
                        const InputDecoration(labelText: 'Tax Rate %'),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<PaymentTerms>(
              initialValue: _paymentTerms,
              decoration:
                  const InputDecoration(labelText: 'Payment Terms'),
              items: PaymentTerms.values
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(t.label),
                      ))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _paymentTerms = v);
              },
            ),
            if (_paymentTerms == PaymentTerms.custom) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _customDaysCtrl,
                decoration:
                    const InputDecoration(labelText: 'Custom Days'),
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 12),
            TextFormField(
              controller: _lateFeeCtrl,
              decoration: const InputDecoration(
                labelText: 'Late Fee % (optional)',
                hintText: 'e.g. 1.5',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
