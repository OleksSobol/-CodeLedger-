import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/time_entry_providers.dart';
import '../widgets/active_timer_widget.dart';
import '../widgets/time_entries_list.dart';
import '../widgets/date_range_selector.dart';
import '../widgets/time_summary_bar.dart';
import '../../../clients/presentation/providers/client_providers.dart';
import '../../../projects/presentation/providers/project_providers.dart';
import '../../../export/presentation/providers/export_providers.dart';

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
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export CSV',
            onPressed: () => _exportCsv(context, ref),
          ),
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

  Future<void> _exportCsv(BuildContext context, WidgetRef ref) async {
    try {
      final filter = ref.read(dateRangeFilterProvider);
      final timeDao = ref.read(timeEntryDaoProvider);
      final entries = await timeDao.getAllEntries(
        from: filter.start,
        to: filter.end,
      );

      if (entries.isEmpty) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No entries to export')),
          );
        }
        return;
      }

      // Resolve client and project names
      final clientDao = ref.read(clientDaoProvider);
      final projectDao = ref.read(projectDaoProvider);

      final clientIds = entries.map((e) => e.clientId).toSet();
      final clientNames = <int, String>{};
      for (final id in clientIds) {
        try {
          final c = await clientDao.getClient(id);
          clientNames[id] = c.name;
        } catch (_) {
          clientNames[id] = 'Unknown';
        }
      }

      final projectIds =
          entries.map((e) => e.projectId).whereType<int>().toSet();
      final projectNames = <int, String>{};
      for (final id in projectIds) {
        try {
          final p = await projectDao.getProject(id);
          projectNames[id] = p.name;
        } catch (_) {
          projectNames[id] = 'Unknown';
        }
      }

      final exportService = ref.read(exportServiceProvider);
      final file = await exportService.generateTimeEntriesCsv(
        entries: entries,
        projectNames: projectNames,
        clientNames: clientNames,
      );

      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)]),
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export error: $e')),
        );
      }
    }
  }
}
