import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../providers/time_entry_providers.dart';
import 'time_entry_tile.dart';

class TimeEntriesList extends ConsumerWidget {
  const TimeEntriesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(filteredEntriesProvider);

    return entriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (entries) {
        if (entries.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline),
                const SizedBox(height: 16),
                Text('No time entries',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                const Text('Clock in or add a manual entry'),
              ],
            ),
          );
        }

        // Group entries by date
        final grouped = <String, List<TimeEntry>>{};
        final dateFmt = DateFormat.yMMMEd();
        for (final entry in entries) {
          final key = dateFmt.format(entry.startTime);
          grouped.putIfAbsent(key, () => []).add(entry);
        }

        return ListView.builder(
          itemCount: grouped.length,
          itemBuilder: (context, index) {
            final dateKey = grouped.keys.elementAt(index);
            final dayEntries = grouped[dateKey]!;
            final dayMinutes = dayEntries
                .where((e) => e.endTime != null)
                .fold<int>(0, (sum, e) => sum + (e.durationMinutes ?? 0));
            final dayEarnings = dayEntries
                .where((e) => e.endTime != null)
                .fold<double>(
                    0,
                    (sum, e) =>
                        sum +
                        (e.durationMinutes ?? 0) /
                            60.0 *
                            e.hourlyRateSnapshot);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: Row(
                    children: [
                      Text(dateKey,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Text(
                        '${formatDuration(dayMinutes)} · ${formatCurrency(dayEarnings)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                ...dayEntries.map((e) => TimeEntryTile(entry: e)),
              ],
            );
          },
        );
      },
    );
  }
}
