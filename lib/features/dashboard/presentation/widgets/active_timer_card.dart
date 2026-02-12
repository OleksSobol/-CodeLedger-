import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';

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
          return Card(
            child: ListTile(
              leading: const Icon(Icons.timer_outlined),
              title: const Text('No active timer'),
              subtitle: const Text('Tap to clock in'),
              trailing: FilledButton.icon(
                onPressed: () => context.push('/time-tracking/clock-in'),
                icon: const Icon(Icons.play_arrow, size: 18),
                label: const Text('Clock In'),
              ),
            ),
          );
        }

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
      },
    );
  }
}
