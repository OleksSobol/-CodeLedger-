import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../features/time_tracking/presentation/providers/time_entry_providers.dart';

class ShellScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const ShellScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = navigationShell.currentIndex;

    return Scaffold(
      body: navigationShell,
      floatingActionButton: _buildFab(context, ref, currentIndex),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Time',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Invoices',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget? _buildFab(BuildContext context, WidgetRef ref, int index) {
    switch (index) {
      case 0:
        // Home: show Clock In if no active timer
        final running = ref.watch(runningEntryProvider);
        final hasTimer = running.valueOrNull != null;
        if (hasTimer) return null;
        return FloatingActionButton.extended(
          onPressed: () => context.push('/time-tracking/clock-in'),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Clock In'),
        );
      case 1:
        // Time tab: Clock In (handled by the page itself)
        return null;
      case 2:
        // Invoices: New Invoice
        return FloatingActionButton.extended(
          onPressed: () => context.push('/invoices/create'),
          icon: const Icon(Icons.add),
          label: const Text('New Invoice'),
        );
      default:
        return null;
    }
  }
}
