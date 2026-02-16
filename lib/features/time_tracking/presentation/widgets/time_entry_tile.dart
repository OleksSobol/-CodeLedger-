import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../providers/time_entry_providers.dart';

class TimeEntryTile extends ConsumerWidget {
  final TimeEntry entry;

  const TimeEntryTile({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeFmt = DateFormat.jm();
    final isRunning = entry.endTime == null;
    final minutes = entry.durationMinutes ?? 0;
    final earnings = minutes / 60.0 * entry.hourlyRateSnapshot;

    return Dismissible(
      key: ValueKey(entry.id),
      direction: entry.isInvoiced
          ? DismissDirection.none
          : DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Theme.of(context).colorScheme.error,
        child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete Entry'),
            content: const Text('Delete this time entry?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text('Cancel')),
              FilledButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text('Delete')),
            ],
          ),
        );
      },
      onDismissed: (_) {
        ref.read(timerNotifierProvider.notifier).deleteEntry(entry.id);
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.pushNamed('editTimeEntry', extra: entry),
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time range + duration row
              Row(
                children: [
                  Text(
                    isRunning
                        ? '${timeFmt.format(entry.startTime)} – ...'
                        : '${timeFmt.format(entry.startTime)} – ${timeFmt.format(entry.endTime!)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  if (!isRunning) ...[
                    Text(
                      formatDuration(minutes),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatCurrency(earnings),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ] else
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('Running',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                    ),
                ],
              ),

              // Description
              if (entry.description != null &&
                  entry.description!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(entry.description!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ],

              // Metadata row (issue ref, repo, tags, invoiced badge)
              if (entry.issueReference != null ||
                  entry.repository != null ||
                  entry.isInvoiced ||
                  entry.isManual) ...[
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (entry.repository != null)
                      _MetaBadge(
                          icon: Icons.folder_outlined,
                          text: entry.repository!),
                    if (entry.issueReference != null)
                      _MetaBadge(
                          icon: Icons.tag,
                          text: entry.issueReference!),
                    if (entry.isManual)
                      _MetaBadge(
                          icon: Icons.edit_outlined, text: 'Manual'),
                    if (entry.isInvoiced)
                      _MetaBadge(
                          icon: Icons.receipt_outlined,
                          text: 'Invoiced'),
                  ],
                ),
              ],
            ],
          ),
        ),
        ),
      ),
    );
  }
}

class _MetaBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Theme.of(context).colorScheme.outline),
        const SizedBox(width: 2),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Theme.of(context).colorScheme.outline)),
      ],
    );
  }
}
