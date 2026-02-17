import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/spacing.dart';
import '../providers/time_entry_providers.dart';
import 'time_entry_tile.dart';

/// Sliver-based entries list with sticky date headers.
class TimeEntriesSliver extends ConsumerWidget {
  const TimeEntriesSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(filteredEntriesProvider);

    return entriesAsync.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => SliverFillRemaining(
        child: Center(child: Text('Error: $e')),
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.access_time_outlined,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: Spacing.md),
                  Text('No time entries',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    'Start a timer or add a manual entry',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          );
        }

        // Build flat list of date headers + entry items
        final items = _buildFlatList(entries);

        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return switch (item) {
              _DateHeader() => _DateHeaderWidget(
                  dateLabel: item.label,
                  totalMinutes: item.totalMinutes,
                  totalEarnings: item.totalEarnings,
                ),
              _EntryItem() => TimeEntryTile(entry: item.entry),
            };
          },
        );
      },
    );
  }

  List<_ListItem> _buildFlatList(List<TimeEntry> entries) {
    final dateFmt = DateFormat.yMMMEd();
    final grouped = <String, List<TimeEntry>>{};

    for (final entry in entries) {
      final key = dateFmt.format(entry.startTime);
      grouped.putIfAbsent(key, () => []).add(entry);
    }

    final items = <_ListItem>[];
    for (final dateKey in grouped.keys) {
      final dayEntries = grouped[dateKey]!;
      final completed = dayEntries.where((e) => e.endTime != null);
      final dayMinutes = completed.fold<int>(
          0, (sum, e) => sum + (e.durationMinutes ?? 0));
      final dayEarnings = completed.fold<double>(
          0,
          (sum, e) =>
              sum + (e.durationMinutes ?? 0) / 60.0 * e.hourlyRateSnapshot);

      items.add(_DateHeader(
        label: dateKey,
        totalMinutes: dayMinutes,
        totalEarnings: dayEarnings,
      ));
      for (final entry in dayEntries) {
        items.add(_EntryItem(entry: entry));
      }
    }

    return items;
  }
}

sealed class _ListItem {}

class _DateHeader extends _ListItem {
  final String label;
  final int totalMinutes;
  final double totalEarnings;

  _DateHeader({
    required this.label,
    required this.totalMinutes,
    required this.totalEarnings,
  });
}

class _EntryItem extends _ListItem {
  final TimeEntry entry;
  _EntryItem({required this.entry});
}

class _DateHeaderWidget extends StatelessWidget {
  final String dateLabel;
  final int totalMinutes;
  final double totalEarnings;

  const _DateHeaderWidget({
    required this.dateLabel,
    required this.totalMinutes,
    required this.totalEarnings,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          Spacing.md, Spacing.sm + 4, Spacing.md, 4),
      child: Row(
        children: [
          Text(
            dateLabel,
            style: theme.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            '${formatDuration(totalMinutes)} · ${formatCurrency(totalEarnings)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
