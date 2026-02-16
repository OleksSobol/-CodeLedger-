import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../shared/widgets/spacing.dart';
import '../providers/dashboard_provider.dart';

/// Compact financial summary: monthly income, outstanding, overdue, uninvoiced.
///
/// Loads lazily — shows placeholder text while loading, never blocks the frame.
class FinancialSummaryRow extends ConsumerWidget {
  const FinancialSummaryRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final monthName = DateFormat.MMMM().format(DateTime.now());

    final incomeAsync = ref.watch(monthlyIncomeProvider);
    final outstandingAsync = ref.watch(outstandingInvoicesProvider);
    final overdueAsync = ref.watch(overdueInvoicesProvider);
    final uninvoicedAsync = ref.watch(uninvoicedByClientProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: Spacing.sm),

        // Top row: income + outstanding
        Row(
          children: [
            Expanded(
              child: _SummaryTile(
                label: '$monthName Income',
                value: incomeAsync.when(
                  loading: () => '...',
                  error: (_, __) => '--',
                  data: (v) => formatCurrency(v),
                ),
                icon: Icons.trending_up,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: _SummaryTile(
                label: 'Outstanding',
                value: outstandingAsync.when(
                  loading: () => '...',
                  error: (_, __) => '--',
                  data: (v) =>
                      v.count == 0 ? 'None' : formatCurrency(v.total),
                ),
                icon: Icons.send_outlined,
                color: theme.colorScheme.secondary,
                badge: outstandingAsync.whenOrNull(
                    data: (v) => v.count > 0 ? '${v.count}' : null),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.sm),

        // Bottom row: overdue + uninvoiced
        Row(
          children: [
            Expanded(
              child: overdueAsync.when(
                loading: () => _SummaryTile(
                  label: 'Overdue',
                  value: '...',
                  icon: Icons.warning_amber_rounded,
                  color: theme.colorScheme.outline,
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (v) {
                  if (v.count == 0) {
                    return _SummaryTile(
                      label: 'Overdue',
                      value: 'None',
                      icon: Icons.check_circle_outline,
                      color: theme.colorScheme.tertiary,
                    );
                  }
                  return _SummaryTile(
                    label: 'Overdue',
                    value: formatCurrency(v.total),
                    icon: Icons.warning_amber_rounded,
                    color: theme.colorScheme.error,
                    badge: '${v.count}',
                    isAlert: true,
                  );
                },
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: uninvoicedAsync.when(
                loading: () => _SummaryTile(
                  label: 'Uninvoiced',
                  value: '...',
                  icon: Icons.hourglass_empty,
                  color: theme.colorScheme.outline,
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (items) {
                  final totalHours =
                      items.fold<double>(0, (sum, i) => sum + i.hours);
                  return _SummaryTile(
                    label: 'Uninvoiced',
                    value: totalHours > 0
                        ? '${totalHours.toStringAsFixed(1)}h'
                        : 'All clear',
                    icon: totalHours > 0
                        ? Icons.hourglass_empty
                        : Icons.check_circle_outline,
                    color: theme.colorScheme.tertiary,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? badge;
  final bool isAlert;

  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.badge,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: isAlert ? theme.colorScheme.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md, vertical: Spacing.sm + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: Spacing.xs),
                Expanded(
                  child: Text(label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isAlert
                            ? theme.colorScheme.onErrorContainer
                            : theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.3,
                      )),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: isAlert
                          ? theme.colorScheme.error
                          : theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10,
                        color: isAlert
                            ? theme.colorScheme.onError
                            : theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontFeatures: [const FontFeature.tabularFigures()],
                color:
                    isAlert ? theme.colorScheme.onErrorContainer : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
