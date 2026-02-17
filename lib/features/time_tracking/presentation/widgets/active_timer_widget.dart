import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/time_entry_dao.dart';
import '../../../../shared/widgets/spacing.dart';
import '../../../clients/presentation/providers/client_providers.dart';
import '../providers/time_entry_providers.dart';

class ActiveTimerWidget extends ConsumerStatefulWidget {
  final TimeEntry entry;

  const ActiveTimerWidget({super.key, required this.entry});

  @override
  ConsumerState<ActiveTimerWidget> createState() =>
      _ActiveTimerWidgetState();
}

class _ActiveTimerWidgetState extends ConsumerState<ActiveTimerWidget>
    with SingleTickerProviderStateMixin {
  Timer? _ticker;
  final _elapsed = ValueNotifier<Duration>(Duration.zero);

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _elapsed.value = DateTime.now().difference(widget.entry.startTime);
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed.value = DateTime.now().difference(widget.entry.startTime);
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
  void didUpdateWidget(covariant ActiveTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry.id != widget.entry.id) {
      _elapsed.value = DateTime.now().difference(widget.entry.startTime);
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _elapsed.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _clockOut() async {
    try {
      await ref
          .read(timerNotifierProvider.notifier)
          .clockOut(widget.entry.id);
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
              .clockOut(widget.entry.id, truncateOverlaps: true);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final clientAsync =
        ref.watch(clientByIdProvider(widget.entry.clientId));
    final clientName = clientAsync.valueOrNull?.name;
    final rate = widget.entry.hourlyRateSnapshot;

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            // Pulsing dot
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
                  // Isolated ticker — only this rebuilds every second
                  ValueListenableBuilder<Duration>(
                    valueListenable: _elapsed,
                    builder: (_, elapsed, __) {
                      final h = elapsed.inHours;
                      final m = elapsed.inMinutes.remainder(60);
                      final s = elapsed.inSeconds.remainder(60);
                      final display = h > 0
                          ? '${h}h ${m.toString().padLeft(2, '0')}m ${s.toString().padLeft(2, '0')}s'
                          : '${m}m ${s.toString().padLeft(2, '0')}s';
                      final earnings =
                          elapsed.inSeconds / 3600.0 * rate;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            display,
                            style:
                                theme.textTheme.headlineLarge?.copyWith(
                              color: theme
                                  .colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontFeatures: [
                                const FontFeature.tabularFigures()
                              ],
                            ),
                          ),
                          Text(
                            '\$${earnings.toStringAsFixed(2)} earned',
                            style:
                                theme.textTheme.bodySmall?.copyWith(
                              color: theme
                                  .colorScheme.onPrimaryContainer
                                  .withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  if (clientName != null ||
                      widget.entry.description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      clientName ?? widget.entry.description ?? '',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            FilledButton(
              onPressed: _clockOut,
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              child: const Text('Clock Out'),
            ),
          ],
        ),
      ),
    );
  }
}
