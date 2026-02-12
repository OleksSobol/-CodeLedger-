import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../providers/time_entry_providers.dart';

class DateRangeSelector extends ConsumerWidget {
  const DateRangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(dateRangeFilterProvider);
    final fmt = DateFormat.MMMd();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _Chip(
            label: 'Today',
            selected: _isToday(filter),
            onTap: () => ref.read(dateRangeFilterProvider.notifier).state =
                DateRangeFilter.today(),
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'This Week',
            selected: _isThisWeek(filter),
            onTap: () => ref.read(dateRangeFilterProvider.notifier).state =
                DateRangeFilter.thisWeek(),
          ),
          const SizedBox(width: 8),
          _Chip(
            label: 'This Month',
            selected: _isThisMonth(filter),
            onTap: () => ref.read(dateRangeFilterProvider.notifier).state =
                DateRangeFilter.thisMonth(),
          ),
          const Spacer(),
          Text(
            '${fmt.format(filter.start)} – ${fmt.format(filter.end.subtract(const Duration(days: 1)))}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  bool _isToday(DateRangeFilter f) {
    final today = DateRangeFilter.today();
    return f.start == today.start && f.end == today.end;
  }

  bool _isThisWeek(DateRangeFilter f) {
    final week = DateRangeFilter.thisWeek();
    return f.start == week.start && f.end == week.end;
  }

  bool _isThisMonth(DateRangeFilter f) {
    final month = DateRangeFilter.thisMonth();
    return f.start == month.start && f.end == month.end;
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
      visualDensity: VisualDensity.compact,
    );
  }
}
