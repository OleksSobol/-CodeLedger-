import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dashboard_provider.dart';

class UninvoicedHoursCard extends ConsumerWidget {
  const UninvoicedHoursCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uninvoicedAsync = ref.watch(uninvoicedByClientProvider);
    final theme = Theme.of(context);

    return uninvoicedAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (items) {
        if (items.isEmpty) return const SizedBox.shrink();

        final totalHours =
            items.fold<double>(0, (sum, i) => sum + i.hours);

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.hourglass_empty,
                        size: 20, color: theme.colorScheme.tertiary),
                    const SizedBox(width: 8),
                    Text('Uninvoiced Hours',
                        style: theme.textTheme.titleSmall),
                    const Spacer(),
                    Text(
                      '${totalHours.toStringAsFixed(1)}h total',
                      style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.tertiary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...items.map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(item.client.name,
                                style: theme.textTheme.bodyMedium),
                          ),
                          Text(
                            '${item.hours.toStringAsFixed(1)}h',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
