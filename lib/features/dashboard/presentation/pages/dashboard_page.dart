import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../shared/widgets/spacing.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';
import '../widgets/active_timer_card.dart';
import '../widgets/financial_summary_row.dart';
import '../widgets/recent_activity_card.dart';

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
          ref.invalidate(recentEntriesProvider);
          await Future.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            Spacing.md, Spacing.md, Spacing.md, Spacing.md + bottomInset,
          ),
          children: const [
            // 1. Active timer (always first, loads from stream)
            ActiveTimerCard(),
            SizedBox(height: Spacing.md),

            // 2. Financial summary (lazy loaded)
            FinancialSummaryRow(),
            SizedBox(height: Spacing.lg),

            // 3. Recent activity
            RecentActivityCard(),
          ],
        ),
      ),
    );
  }
}
