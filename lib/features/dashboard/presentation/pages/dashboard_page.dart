import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/theme_provider.dart';
import '../widgets/active_timer_card.dart';
import '../widgets/uninvoiced_hours_card.dart';
import '../widgets/monthly_income_card.dart';
import '../widgets/outstanding_invoices_card.dart';
import '../widgets/overdue_invoices_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  static IconData _themeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.system => Icons.brightness_auto,
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeLedger'),
        actions: [
          IconButton(
            icon: Icon(_themeIcon(themeMode)),
            tooltip: 'Theme: ${themeMode.name}',
            onPressed: () {
              final next = switch (themeMode) {
                ThemeMode.system => ThemeMode.light,
                ThemeMode.light => ThemeMode.dark,
                ThemeMode.dark => ThemeMode.system,
              };
              ref.read(themeModeProvider.notifier).setThemeMode(next);
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Business Profile',
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Providers auto-refresh via Riverpod; this just gives UX feedback
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            16, 16, 16, 16 + MediaQuery.of(context).padding.bottom,
          ),
          children: [
            // 1. Active timer
            const ActiveTimerCard(),
            const SizedBox(height: 8),

            // 2. Monthly income
            const MonthlyIncomeCard(),
            const SizedBox(height: 8),

            // 3. Uninvoiced hours per client
            const UninvoicedHoursCard(),
            const SizedBox(height: 8),

            // 4. Outstanding invoices
            const OutstandingInvoicesCard(),
            const SizedBox(height: 8),

            // 5. Overdue invoices
            const OverdueInvoicesCard(),
            const SizedBox(height: 16),

            // Quick nav
            const Divider(),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.people_outline),
                title: const Text('Clients'),
                subtitle: const Text('Manage clients and projects'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/clients'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.access_time_outlined),
                title: const Text('Time Tracking'),
                subtitle: const Text('Entries, summaries, manual entry'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/time-tracking'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Invoices'),
                subtitle: const Text('Create and manage invoices'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/invoices'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.summarize_outlined),
                title: const Text('Reports'),
                subtitle: const Text('Generate non-financial work reports'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/reports'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: const Icon(Icons.cloud_outlined),
                title: const Text('Backup & Restore'),
                subtitle: const Text('Encrypted local & Google Drive backups'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/backup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
