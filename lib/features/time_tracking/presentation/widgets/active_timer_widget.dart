import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../providers/time_entry_providers.dart';

class ActiveTimerWidget extends ConsumerStatefulWidget {
  final TimeEntry entry;

  const ActiveTimerWidget({super.key, required this.entry});

  @override
  ConsumerState<ActiveTimerWidget> createState() => _ActiveTimerWidgetState();
}

class _ActiveTimerWidgetState extends ConsumerState<ActiveTimerWidget> {
  late Timer _ticker;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateElapsed();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateElapsed();
    });
  }

  void _updateElapsed() {
    setState(() {
      _elapsed = DateTime.now().difference(widget.entry.startTime);
    });
  }

  @override
  void dispose() {
    _ticker.cancel();
    super.dispose();
  }

  Future<void> _clockOut() async {
    try {
      await ref
          .read(timerNotifierProvider.notifier)
          .clockOut(widget.entry.id);
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

    return Card(
      color: theme.colorScheme.primaryContainer,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.circle, color: Colors.red, size: 12),
                const SizedBox(width: 8),
                Text('Timer Running',
                    style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer)),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              formatDuration(_elapsed.inMinutes),
              style: theme.textTheme.headlineLarge?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.entry.description != null) ...[
              const SizedBox(height: 4),
              Text(
                widget.entry.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 16),
            FilledButton.tonalIcon(
              onPressed: _clockOut,
              icon: const Icon(Icons.stop),
              label: const Text('Clock Out'),
            ),
          ],
        ),
      ),
    );
  }
}
