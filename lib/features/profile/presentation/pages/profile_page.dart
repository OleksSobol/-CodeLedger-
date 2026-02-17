import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import '../widgets/business_info_section.dart';
import '../widgets/tax_info_section.dart';
import '../widgets/bank_details_section.dart';
import '../widgets/payment_links_section.dart';
import '../widgets/defaults_section.dart';
import '../widgets/invoice_settings_section.dart';
import '../widgets/backup_settings_section.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Profile'),
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (profile) => ListView(
          padding: const EdgeInsets.only(bottom: 32),
          children: [
            BusinessInfoSection(profile: profile),
            TaxInfoSection(profile: profile),
            BankDetailsSection(profile: profile),
            PaymentLinksSection(profile: profile),
            DefaultsSection(profile: profile),
            InvoiceSettingsSection(profile: profile),
            const BackupSettingsSection(),
          ],
        ),
      ),
    );
  }
}
