import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Placeholder cards for Phase 4
          Card(
            child: ListTile(
              leading: const Icon(Icons.timer_outlined),
              title: const Text('No active timer'),
              subtitle: const Text('Clock in from Time Tracking'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.people_outline),
              title: const Text('Clients'),
              subtitle: const Text('Manage your clients and projects'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/clients'),
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('Invoices'),
              subtitle: const Text('Coming in Phase 5'),
              enabled: false,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.access_time_outlined),
              title: const Text('Time Tracking'),
              subtitle: const Text('Coming in Phase 3'),
              enabled: false,
            ),
          ),
        ],
      ),
    );
  }
}
