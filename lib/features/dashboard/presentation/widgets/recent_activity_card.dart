import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/time_entry_dao.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../clients/presentation/providers/client_providers.dart';

/// Provides the 5 most recent completed time entries.
final recentEntriesProvider = StreamProvider<List<TimeEntry>>((ref) {
  final dao = TimeEntryDao(ref.watch(databaseProvider));
  final now = DateTime.now();
  final weekAgo = now.subtract(const Duration(days: 7));
  return dao.watchEntriesForDateRange(weekAgo, now);
});

class RecentActivityCard extends ConsumerWidget {
  const RecentActivityCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final recentAsync = ref.watch(recentEntriesProvider);

    return recentAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (entries) {
        // Take only completed entries, max 5
        final completed =
            entries.where((e) => e.endTime != null).take(5).toList();
        if (completed.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activity',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  for (var i = 0; i < completed.length; i++) ...[
                    _EntryTile(entry: completed[i]),
                    if (i < completed.length - 1)
                      const Divider(height: 1, indent: 56),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _EntryTile extends ConsumerWidget {
  final TimeEntry entry;
  const _EntryTile({required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final clientAsync = ref.watch(clientByIdProvider(entry.clientId));
    final clientName =
        clientAsync.whenOrNull(data: (c) => c.name) ?? '...';

    final hours = (entry.durationMinutes ?? 0) / 60.0;
    final desc = entry.description ?? 'Work session';
    final timeAgo = _formatTimeAgo(entry.startTime);

    return ListTile(
      dense: true,
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(
          hours.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      title: Text(
        desc,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '$clientName - $timeAgo',
        style: theme.textTheme.bodySmall
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      ),
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat.MMMd().format(dt);
  }
}
