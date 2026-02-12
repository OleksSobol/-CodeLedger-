import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/profile_provider.dart';

class BusinessInfoSection extends ConsumerStatefulWidget {
  final UserProfile profile;

  const BusinessInfoSection({super.key, required this.profile});

  @override
  ConsumerState<BusinessInfoSection> createState() =>
      _BusinessInfoSectionState();
}

class _BusinessInfoSectionState extends ConsumerState<BusinessInfoSection> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _businessNameCtrl;
  late final TextEditingController _ownerNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _addressLine1Ctrl;
  late final TextEditingController _addressLine2Ctrl;
  late final TextEditingController _cityCtrl;
  late final TextEditingController _stateCtrl;
  late final TextEditingController _postalCodeCtrl;
  late final TextEditingController _countryCtrl;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _businessNameCtrl = TextEditingController(text: p.businessName);
    _ownerNameCtrl = TextEditingController(text: p.ownerName);
    _emailCtrl = TextEditingController(text: p.email ?? '');
    _phoneCtrl = TextEditingController(text: p.phone ?? '');
    _addressLine1Ctrl = TextEditingController(text: p.addressLine1 ?? '');
    _addressLine2Ctrl = TextEditingController(text: p.addressLine2 ?? '');
    _cityCtrl = TextEditingController(text: p.city ?? '');
    _stateCtrl = TextEditingController(text: p.stateProvince ?? '');
    _postalCodeCtrl = TextEditingController(text: p.postalCode ?? '');
    _countryCtrl = TextEditingController(text: p.country ?? '');
  }

  @override
  void dispose() {
    _businessNameCtrl.dispose();
    _ownerNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressLine1Ctrl.dispose();
    _addressLine2Ctrl.dispose();
    _cityCtrl.dispose();
    _stateCtrl.dispose();
    _postalCodeCtrl.dispose();
    _countryCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(profileNotifierProvider.notifier);
    await notifier.updateBusinessInfo(
      businessName: _businessNameCtrl.text.trim(),
      ownerName: _ownerNameCtrl.text.trim(),
      email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
      addressLine1: _addressLine1Ctrl.text.trim().isEmpty
          ? null
          : _addressLine1Ctrl.text.trim(),
      addressLine2: _addressLine2Ctrl.text.trim().isEmpty
          ? null
          : _addressLine2Ctrl.text.trim(),
      city: _cityCtrl.text.trim().isEmpty ? null : _cityCtrl.text.trim(),
      stateProvince:
          _stateCtrl.text.trim().isEmpty ? null : _stateCtrl.text.trim(),
      postalCode: _postalCodeCtrl.text.trim().isEmpty
          ? null
          : _postalCodeCtrl.text.trim(),
      country:
          _countryCtrl.text.trim().isEmpty ? null : _countryCtrl.text.trim(),
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Business info saved')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Business Information',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 16),
              TextFormField(
                controller: _businessNameCtrl,
                decoration:
                    const InputDecoration(labelText: 'Business Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ownerNameCtrl,
                decoration: const InputDecoration(labelText: 'Owner Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressLine1Ctrl,
                decoration:
                    const InputDecoration(labelText: 'Address Line 1'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _addressLine2Ctrl,
                decoration:
                    const InputDecoration(labelText: 'Address Line 2'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityCtrl,
                      decoration:
                          const InputDecoration(labelText: 'City'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _stateCtrl,
                      decoration:
                          const InputDecoration(labelText: 'State'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _postalCodeCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Postal Code'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _countryCtrl,
                      decoration:
                          const InputDecoration(labelText: 'Country'),
                    ),
                  ),
                ],
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
      ),
    );
  }
}
