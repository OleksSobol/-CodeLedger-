import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/time_entry_dao.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../providers/time_entry_providers.dart';

class EditTimeEntryPage extends ConsumerStatefulWidget {
  final TimeEntry entry;

  const EditTimeEntryPage({super.key, required this.entry});

  @override
  ConsumerState<EditTimeEntryPage> createState() => _EditTimeEntryPageState();
}

class _EditTimeEntryPageState extends ConsumerState<EditTimeEntryPage> {
  late final TextEditingController _descriptionCtrl;
  late final TextEditingController _issueRefCtrl;
  late final TextEditingController _repoCtrl;
  late final TextEditingController _tagsCtrl;
  late final TextEditingController _rateCtrl;
  late DateTime _date;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.entry;
    _descriptionCtrl = TextEditingController(text: e.description ?? '');
    _issueRefCtrl = TextEditingController(text: e.issueReference ?? '');
    _repoCtrl = TextEditingController(text: e.repository ?? '');
    _tagsCtrl = TextEditingController(text: _parseTags(e.tags));
    _rateCtrl = TextEditingController(
        text: e.hourlyRateSnapshot.toStringAsFixed(2));
    _date = DateTime(e.startTime.year, e.startTime.month, e.startTime.day);
    _startTime = TimeOfDay.fromDateTime(e.startTime);
    _endTime = e.endTime != null
        ? TimeOfDay.fromDateTime(e.endTime!)
        : TimeOfDay.fromDateTime(DateTime.now());
  }

  String _parseTags(String? tagsJson) {
    if (tagsJson == null || tagsJson.isEmpty) return '';
    // Simple parse: remove brackets and quotes
    return tagsJson
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .trim();
  }

  @override
  void dispose() {
    _descriptionCtrl.dispose();
    _issueRefCtrl.dispose();
    _repoCtrl.dispose();
    _tagsCtrl.dispose();
    _rateCtrl.dispose();
    super.dispose();
  }

  DateTime _buildDateTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String? _trimOrNull(String text) {
    final trimmed = text.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) setState(() => _startTime = picked);
  }

  Future<void> _pickEndTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) setState(() => _endTime = picked);
  }

  Future<void> _save() async {
    final start = _buildDateTime(_date, _startTime);
    final end = _buildDateTime(_date, _endTime);

    if (!end.isAfter(start)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time must be after start time')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final tagsText = _tagsCtrl.text.trim();
      String? tagsJson;
      if (tagsText.isNotEmpty) {
        final tagList = tagsText
            .split(',')
            .map((t) => t.trim())
            .where((t) => t.isNotEmpty);
        tagsJson = '[${tagList.map((t) => '"$t"').join(',')}]';
      }

      final parsedRate = double.tryParse(_rateCtrl.text);
      await ref.read(timerNotifierProvider.notifier).updateEntryTimes(
            entryId: widget.entry.id,
            startTime: start,
            endTime: end,
            description: _trimOrNull(_descriptionCtrl.text),
            issueReference: _trimOrNull(_issueRefCtrl.text),
            repository: _trimOrNull(_repoCtrl.text),
            tags: tagsJson,
            hourlyRateSnapshot: parsedRate,
          );
      if (mounted) context.pop(true);
    } on OverlappingTimeEntryException catch (e) {
      if (mounted) {
        final overlapping = e.existing;
        final timeFmt = DateFormat.jm();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Overlaps with entry: '
              '${timeFmt.format(overlapping.startTime)} – '
              '${timeFmt.format(overlapping.endTime!)}',
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat.yMMMEd();
    final duration = _buildDateTime(_date, _endTime)
        .difference(_buildDateTime(_date, _startTime));
    final isCompleted = widget.entry.endTime != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Time Entry'),
        actions: [
          if (!widget.entry.isInvoiced)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Entry'),
                    content:
                        const Text('Are you sure you want to delete this entry?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true && mounted) {
                  await ref
                      .read(timerNotifierProvider.notifier)
                      .deleteEntry(widget.entry.id);
                  if (mounted) context.pop(true);
                }
              },
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Invoiced warning
          if (widget.entry.isInvoiced) ...[
            Card(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.lock_outline,
                        color:
                            Theme.of(context).colorScheme.onTertiaryContainer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'This entry is invoiced. Only description and metadata can be edited.',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onTertiaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Date picker
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.calendar_today),
            title: Text(dateFmt.format(_date)),
            trailing: const Icon(Icons.chevron_right),
            onTap: widget.entry.isInvoiced ? null : _pickDate,
          ),

          // Time pickers
          if (isCompleted)
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.login),
                    title: Text(_startTime.format(context)),
                    subtitle: const Text('Start'),
                    onTap: widget.entry.isInvoiced ? null : _pickStartTime,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.logout),
                    title: Text(_endTime.format(context)),
                    subtitle: const Text('End'),
                    onTap: widget.entry.isInvoiced ? null : _pickEndTime,
                  ),
                ),
              ],
            ),
          if (isCompleted && duration.inMinutes > 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Duration: ${formatDuration(duration.inMinutes)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),

          const SizedBox(height: 8),
          TextFormField(
            controller: _rateCtrl,
            decoration: const InputDecoration(
              labelText: 'Hourly Rate (\$)',
              hintText: 'e.g. 30.00',
            ),
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            enabled: !widget.entry.isInvoiced,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionCtrl,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'What did you work on?',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _repoCtrl,
            decoration: const InputDecoration(
              labelText: 'Repository',
              hintText: 'e.g. org/repo',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _issueRefCtrl,
            decoration: const InputDecoration(
              labelText: 'Issue Reference',
              hintText: 'e.g. org/repo#42',
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _tagsCtrl,
            decoration: const InputDecoration(
              labelText: 'Tags (comma separated)',
              hintText: 'e.g. bugfix, frontend, review',
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}
