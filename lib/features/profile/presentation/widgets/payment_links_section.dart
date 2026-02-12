import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../providers/profile_provider.dart';

class PaymentLinksSection extends ConsumerStatefulWidget {
  final UserProfile profile;

  const PaymentLinksSection({super.key, required this.profile});

  @override
  ConsumerState<PaymentLinksSection> createState() =>
      _PaymentLinksSectionState();
}

class _PaymentLinksSectionState extends ConsumerState<PaymentLinksSection> {
  late final TextEditingController _stripeLinkCtrl;
  late final TextEditingController _instructionsCtrl;
  late bool _showStripeLink;

  @override
  void initState() {
    super.initState();
    _stripeLinkCtrl =
        TextEditingController(text: widget.profile.stripePaymentLink ?? '');
    _instructionsCtrl =
        TextEditingController(text: widget.profile.paymentInstructions ?? '');
    _showStripeLink = widget.profile.showStripeLink;
  }

  @override
  void dispose() {
    _stripeLinkCtrl.dispose();
    _instructionsCtrl.dispose();
    super.dispose();
  }

  String? _trimOrNull(String text) {
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _save() async {
    await ref.read(profileNotifierProvider.notifier).updatePaymentLinks(
          stripePaymentLink: _trimOrNull(_stripeLinkCtrl.text),
          showStripeLink: _showStripeLink,
          paymentInstructions: _trimOrNull(_instructionsCtrl.text),
        );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment links saved')),
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
            Text('Payment Links',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stripeLinkCtrl,
              decoration: const InputDecoration(
                labelText: 'Stripe Payment Link',
                hintText: 'https://pay.stripe.com/...',
              ),
              keyboardType: TextInputType.url,
            ),
            SwitchListTile(
              title: const Text('Show Stripe link on invoices'),
              value: _showStripeLink,
              onChanged: (v) => setState(() => _showStripeLink = v),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _instructionsCtrl,
              decoration: const InputDecoration(
                labelText: 'Other Payment Instructions',
                hintText: 'PayPal, Venmo, Zelle, etc.',
              ),
              maxLines: 3,
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
