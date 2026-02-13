import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';
import '../../../clients/presentation/providers/client_providers.dart';

class ActiveTimerCard extends ConsumerStatefulWidget {
  const ActiveTimerCard({super.key});

  @override
  ConsumerState<ActiveTimerCard> createState() => _ActiveTimerCardState();
}

class _ActiveTimerCardState extends ConsumerState<ActiveTimerCard> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {}); // Rebuild to update elapsed time
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final runningAsync = ref.watch(runningEntryProvider);
    final theme = Theme.of(context);

    return runningAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (running) {
        if (running == null) {
          return _buildIdleCard(context, theme);
        }
        return _buildRunningCard(context, theme, running);
      },
    );
  }

  Widget _buildIdleCard(BuildContext context, ThemeData theme) {
    final lastEntryAsync = ref.watch(lastCompletedEntryProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timer_outlined),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('No active timer'),
                    ],
                  ),
                ),
                FilledButton.icon(
                  onPressed: () => context.push('/time-tracking/clock-in'),
                  icon: const Icon(Icons.play_arrow, size: 18),
                  label: const Text('Clock In'),
                ),
              ],
            ),
            // Quick repeat last entry
            lastEntryAsync.whenOrNull(
                  data: (lastEntry) {
                    if (lastEntry == null) return null;
                    return _buildQuickRepeat(context, theme, lastEntry);
                  },
                ) ??
                const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickRepeat(
      BuildContext context, ThemeData theme, TimeEntry lastEntry) {
    final clientAsync = ref.watch(clientByIdProvider(lastEntry.clientId));

    return clientAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (client) {
        final label = client.name;
        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _quickClockIn(lastEntry),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.replay, size: 16,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Quick: $label',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.play_arrow, size: 16,
                      color: theme.colorScheme.primary),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _quickClockIn(TimeEntry lastEntry) async {
    try {
      await ref.read(timerNotifierProvider.notifier).clockIn(
            clientId: lastEntry.clientId,
            projectId: lastEntry.projectId,
            description: lastEntry.description,
            repository: lastEntry.repository,
            issueReference: lastEntry.issueReference,
          );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _buildRunningCard(
      BuildContext context, ThemeData theme, TimeEntry running) {
    final elapsed = DateTime.now().difference(running.startTime);
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.circle, color: Colors.red, size: 12),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDuration(elapsed.inMinutes),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (running.description != null)
                    Text(
                      running.description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: () async {
                await ref
                    .read(timerNotifierProvider.notifier)
                    .clockOut(running.id);
              },
              icon: const Icon(Icons.stop),
              label: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
