import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../shared/widgets/spacing.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';
import '../widgets/active_timer_card.dart';
import '../widgets/financial_summary_row.dart';
import '../widgets/quick_action_chips.dart';

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
    final bottomInset = MediaQuery.of(context).padding.bottom;

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
          ref.invalidate(runningEntryProvider);
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            Spacing.md, Spacing.md, Spacing.md, Spacing.md + bottomInset,
          ),
          children: [
            // 1. Active timer (always first, loads from stream)
            const ActiveTimerCard(),
            const SizedBox(height: Spacing.md),

            // 2. Quick action buttons
            const QuickActionChips(),
            const SizedBox(height: Spacing.lg),

            // 3. Financial summary (lazy loaded)
            const FinancialSummaryRow(),
            const SizedBox(height: Spacing.lg),

            // 4. Navigation
            const _NavigationSection(),
          ],
        ),
      ),
    );
  }
}

/// Navigation section — Card with ListTile rows.
/// Uses a single Card instead of a grid to avoid text wrapping issues.
class _NavigationSection extends StatelessWidget {
  const _NavigationSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Navigate',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: Spacing.sm),
        Card(
          child: Column(
            children: [
              _NavRow(
                icon: Icons.people_outline,
                label: 'Clients',
                subtitle: 'Manage clients & projects',
                onTap: () => context.push('/clients'),
              ),
              const Divider(height: 1, indent: 56),
              _NavRow(
                icon: Icons.access_time_outlined,
                label: 'Time Tracking',
                subtitle: 'Entries, summaries, clock in',
                onTap: () => context.push('/time-tracking'),
              ),
              const Divider(height: 1, indent: 56),
              _NavRow(
                icon: Icons.receipt_long_outlined,
                label: 'Invoices',
                subtitle: 'Create & manage invoices',
                onTap: () => context.push('/invoices'),
              ),
              const Divider(height: 1, indent: 56),
              _NavRow(
                icon: Icons.summarize_outlined,
                label: 'Reports',
                subtitle: 'Non-financial work reports',
                onTap: () => context.push('/reports'),
              ),
              const Divider(height: 1, indent: 56),
              _NavRow(
                icon: Icons.cloud_outlined,
                label: 'Backup',
                subtitle: 'Encrypted local & Drive backups',
                onTap: () => context.push('/backup'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _NavRow({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(label, style: theme.textTheme.titleSmall),
      subtitle: Text(subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant)),
      trailing: Icon(Icons.chevron_right,
          size: 20, color: theme.colorScheme.outline),
      onTap: onTap,
    );
  }
}
