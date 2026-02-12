import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../providers/time_entry_providers.dart';

class TimeSummaryBar extends ConsumerWidget {
  const TimeSummaryBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(filteredEntriesProvider);

    return entriesAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (entries) {
        final completed = entries.where((e) => e.endTime != null);
        final totalMinutes = completed.fold<int>(
            0, (sum, e) => sum + (e.durationMinutes ?? 0));
        final totalEarnings = completed.fold<double>(
            0,
            (sum, e) =>
                sum +
                (e.durationMinutes ?? 0) / 60.0 * e.hourlyRateSnapshot);
        final uninvoicedCount =
            completed.where((e) => !e.isInvoiced).length;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .surfaceContainerHighest
                .withValues(alpha: 0.5),
          ),
          child: Row(
            children: [
              _SummaryItem(
                label: 'Total',
                value: formatDuration(totalMinutes),
              ),
              const SizedBox(width: 24),
              _SummaryItem(
                label: 'Earnings',
                value: formatCurrency(totalEarnings),
              ),
              const SizedBox(width: 24),
              _SummaryItem(
                label: 'Entries',
                value: '${completed.length}',
              ),
              if (uninvoicedCount > 0) ...[
                const SizedBox(width: 24),
                _SummaryItem(
                  label: 'Uninvoiced',
                  value: '$uninvoicedCount',
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
