import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/active_timer_card.dart';
import '../widgets/uninvoiced_hours_card.dart';
import '../widgets/monthly_income_card.dart';
import '../widgets/outstanding_invoices_card.dart';
import '../widgets/overdue_invoices_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeLedger'),
        actions: [
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
          padding: const EdgeInsets.all(16),
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
          ],
        ),
      ),
    );
  }
}
