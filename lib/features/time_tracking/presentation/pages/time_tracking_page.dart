import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/time_entry_providers.dart';
import '../widgets/active_timer_widget.dart';
import '../widgets/time_entries_list.dart';
import '../widgets/date_range_selector.dart';
import '../widgets/time_summary_bar.dart';

class TimeTrackingPage extends ConsumerWidget {
  const TimeTrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final runningAsync = ref.watch(runningEntryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note),
            tooltip: 'Manual Entry',
            onPressed: () => context.push('/time-tracking/manual'),
          ),
        ],
      ),
      floatingActionButton: runningAsync.whenOrNull(
        data: (running) {
          if (running != null) return null; // Timer already running
          return FloatingActionButton.extended(
            onPressed: () => context.push('/time-tracking/clock-in'),
            icon: const Icon(Icons.play_arrow),
            label: const Text('Clock In'),
          );
        },
      ),
      body: Column(
        children: [
          // Active timer (if running)
          runningAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (running) {
              if (running == null) return const SizedBox.shrink();
              return ActiveTimerWidget(entry: running);
            },
          ),
          // Date range selector
          const DateRangeSelector(),
          // Summary bar
          const TimeSummaryBar(),
          // Entries list
          const Expanded(child: TimeEntriesList()),
        ],
      ),
    );
  }
}
