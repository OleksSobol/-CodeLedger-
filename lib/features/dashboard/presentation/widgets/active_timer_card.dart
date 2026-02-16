import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/time_entry_dao.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../shared/widgets/spacing.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';
import '../../../clients/presentation/providers/client_providers.dart';

class ActiveTimerCard extends ConsumerStatefulWidget {
  const ActiveTimerCard({super.key});

  @override
  ConsumerState<ActiveTimerCard> createState() => _ActiveTimerCardState();
}

class _ActiveTimerCardState extends ConsumerState<ActiveTimerCard>
    with SingleTickerProviderStateMixin {
  Timer? _ticker;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {});
    });
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _pulseController.dispose();
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
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.timer_outlined,
                    size: 24, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: Spacing.sm),
                Expanded(
                  child: Text('No active timer',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ),
                FilledButton.icon(
                  onPressed: () => context.push('/time-tracking/clock-in'),
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: const Text('Clock In'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.md, vertical: Spacing.sm),
                  ),
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
        return Padding(
          padding: const EdgeInsets.only(top: Spacing.sm),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => _quickClockIn(lastEntry),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm + 4, vertical: Spacing.sm),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.replay, size: 16,
                      color: theme.colorScheme.primary),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      'Repeat: ${client.name}',
                      style: theme.textTheme.labelMedium?.copyWith(
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

  Future<void> _clockOut(BuildContext context, int entryId) async {
    try {
      await ref.read(timerNotifierProvider.notifier).clockOut(entryId);
    } on OverlappingTimeEntryException catch (e) {
      if (!mounted) return;
      final timeFmt = DateFormat.jm();
      final overlap = e.existing;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Overlapping Entry'),
          content: Text(
            'Clocking out now overlaps with an entry from '
            '${timeFmt.format(overlap.startTime)} – '
            '${timeFmt.format(overlap.endTime!)}.\n\n'
            'Adjust the conflicting entry to make room?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Adjust & Clock Out'),
            ),
          ],
        ),
      );
      if (confirmed == true && mounted) {
        try {
          await ref
              .read(timerNotifierProvider.notifier)
              .clockOut(entryId, truncateOverlaps: true);
        } catch (e2) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e2')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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
    final clientAsync = ref.watch(clientByIdProvider(running.clientId));
    final clientName = clientAsync.valueOrNull?.name;

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            // Pulsing recording dot
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (_, __) => Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.error
                      .withValues(alpha: _pulseAnimation.value),
                ),
              ),
            ),
            const SizedBox(width: Spacing.sm + 4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatDuration(elapsed.inMinutes),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                      fontFeatures: [const FontFeature.tabularFigures()],
                    ),
                  ),
                  if (clientName != null || running.description != null)
                    Text(
                      clientName ?? running.description ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            FilledButton.tonalIcon(
              onPressed: () => _clockOut(context, running.id),
              icon: const Icon(Icons.stop),
              label: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
