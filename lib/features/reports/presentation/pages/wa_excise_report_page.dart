import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../../core/providers/theme_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../invoices/presentation/providers/invoice_providers.dart';

// ── Submission model ───────────────────────────────────────────────────────────

class _WaSubmission {
  final String period;
  final String submittedAt;
  final double grossAmount;
  final String fileContent;
  final String? notes;

  const _WaSubmission({
    required this.period,
    required this.submittedAt,
    required this.grossAmount,
    required this.fileContent,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'period': period,
        'submittedAt': submittedAt,
        'grossAmount': grossAmount,
        'fileContent': fileContent,
        if (notes != null) 'notes': notes,
      };

  factory _WaSubmission.fromJson(Map<String, dynamic> json) => _WaSubmission(
        period: json['period'] as String,
        submittedAt: json['submittedAt'] as String,
        grossAmount: (json['grossAmount'] as num).toDouble(),
        fileContent: json['fileContent'] as String,
        notes: json['notes'] as String?,
      );
}

// ── Quarter helpers ────────────────────────────────────────────────────────────

int _quarterOf(DateTime d) => ((d.month - 1) ~/ 3) + 1;

DateTimeRange _quarterRange(int year, int quarter) {
  final startMonth = (quarter - 1) * 3 + 1;
  final start = DateTime(year, startMonth);
  final end = DateTime(year, startMonth + 3);
  return DateTimeRange(start: start, end: end);
}

String _periodCode(int year, int quarter) => 'Q$quarter$year';

// ── Page ───────────────────────────────────────────────────────────────────────

class WaExciseReportPage extends ConsumerStatefulWidget {
  const WaExciseReportPage({super.key});

  @override
  ConsumerState<WaExciseReportPage> createState() =>
      _WaExciseReportPageState();
}

class _WaExciseReportPageState extends ConsumerState<WaExciseReportPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  final _traCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  int _selectedYear = DateTime.now().year;
  int _selectedQuarter = _quarterOf(DateTime.now());
  bool _loading = false;
  List<_WaSubmission> _submissions = [];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _loadSubmissions();
    _prefillTra();
  }

  @override
  void dispose() {
    _tabs.dispose();
    _traCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _prefillTra() async {
    // Try wa_tra setting first, fall back to profile taxId
    final dao = ref.read(appSettingsDaoProvider);
    final saved = await dao.getValue('wa_tra');
    if (saved != null && saved.isNotEmpty) {
      _traCtrl.text = saved;
    } else {
      final profile = await ref.read(userProfileDaoProvider).getProfile();
      if (profile.taxId != null && mounted) {
        _traCtrl.text = profile.taxId!;
      }
    }
  }

  Future<void> _loadSubmissions() async {
    final dao = ref.read(appSettingsDaoProvider);
    final json = await dao.getValue('wa_submissions');
    if (json != null && mounted) {
      try {
        final list = jsonDecode(json) as List<dynamic>;
        setState(() {
          _submissions = list
              .map((e) => _WaSubmission.fromJson(e as Map<String, dynamic>))
              .toList()
            ..sort((a, b) => b.submittedAt.compareTo(a.submittedAt));
        });
      } catch (_) {}
    }
  }

  Future<void> _saveSubmissions() async {
    final dao = ref.read(appSettingsDaoProvider);
    final json = jsonEncode(_submissions.map((s) => s.toJson()).toList());
    await dao.setValue('wa_submissions', json);
  }

  // ── Compute gross receipts for the selected quarter ──────────────────────────

  double _grossForQuarter(List<dynamic> allInvoices) {
    final range = _quarterRange(_selectedYear, _selectedQuarter);
    double total = 0;
    for (final inv in allInvoices) {
      if (inv.status != 'paid') continue;
      if (inv.issueDate.isBefore(range.start)) continue;
      if (!inv.issueDate.isBefore(range.end)) continue;
      total += (inv.total as double);
    }
    return total;
  }

  // ── Generate DOR CSV content ─────────────────────────────────────────────────

  Future<String> _buildDorCsv(double gross) async {
    final profile = await ref.read(userProfileDaoProvider).getProfile();
    final tra = _traCtrl.text.trim();
    final period = _periodCode(_selectedYear, _selectedQuarter);
    final preparer = profile.ownerName.isNotEmpty ? profile.ownerName : '';
    final email = profile.email ?? '';
    final phone = profile.phone ?? '';

    final buf = StringBuffer();
    buf.writeln('# WA DOR Excise Tax Return - $period');
    buf.writeln(
        '# Generated by CodeLedger on ${DateFormat.yMMMd().format(DateTime.now())}');
    buf.writeln();
    buf.writeln('ACCOUNT,$tra,$period,$preparer,$email,$phone');
    // Line code 6: Service & Other Activities B&O
    buf.write('TAX,6,0,${gross.toStringAsFixed(2)},#(Service B&O)');
    return buf.toString();
  }

  Future<void> _exportDorCsv() async {
    setState(() => _loading = true);
    try {
      // Save TRA for next time
      final tra = _traCtrl.text.trim();
      if (tra.isNotEmpty) {
        await ref.read(appSettingsDaoProvider).setValue('wa_tra', tra);
      }

      final allInvoices = ref.read(allInvoicesProvider).valueOrNull ?? [];
      final gross = _grossForQuarter(allInvoices);
      final content = await _buildDorCsv(gross);

      final dir = await getTemporaryDirectory();
      final period = _periodCode(_selectedYear, _selectedQuarter);
      final file = File('${dir.path}/WA_Excise_$period.csv');
      await file.writeAsString(content);

      if (mounted) {
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path, mimeType: 'text/csv')],
            subject: 'WA Excise Tax $period',
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _markSubmitted() async {
    setState(() => _loading = true);
    try {
      final allInvoices = ref.read(allInvoicesProvider).valueOrNull ?? [];
      final gross = _grossForQuarter(allInvoices);
      final content = await _buildDorCsv(gross);
      final period = _periodCode(_selectedYear, _selectedQuarter);

      final submission = _WaSubmission(
        period: period,
        submittedAt: DateTime.now().toIso8601String().substring(0, 10),
        grossAmount: gross,
        fileContent: content,
        notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      );

      setState(() {
        _submissions.removeWhere((s) => s.period == period);
        _submissions.insert(0, submission);
      });
      await _saveSubmissions();
      _notesCtrl.clear();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$period marked as submitted')),
        );
        _tabs.animateTo(1);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _deleteSubmission(_WaSubmission s) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Submission'),
        content: Text(
            'Remove the submission record for ${s.period}? This cannot be undone.'),
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
    if (confirm == true) {
      setState(() => _submissions.removeWhere((x) => x.period == s.period));
      await _saveSubmissions();
    }
  }

  Future<void> _reexportSubmission(_WaSubmission s) async {
    try {
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/WA_Excise_${s.period}.csv');
      await file.writeAsString(s.fileContent);
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'text/csv')],
          subject: 'WA Excise Tax ${s.period}',
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WA Excise Tax'),
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Generate'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _buildGenerateTab(),
          _buildHistoryTab(),
        ],
      ),
    );
  }

  Widget _buildGenerateTab() {
    final invoicesAsync = ref.watch(allInvoicesProvider);
    final theme = Theme.of(context);
    final currFmt = NumberFormat.currency(symbol: '\$');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Quarter selector ──────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quarter', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedYear,
                          decoration:
                              const InputDecoration(labelText: 'Year'),
                          items: List.generate(5, (i) {
                            final y = DateTime.now().year - i;
                            return DropdownMenuItem(
                                value: y, child: Text('$y'));
                          }),
                          onChanged: (v) =>
                              setState(() => _selectedYear = v!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: _selectedQuarter,
                          decoration:
                              const InputDecoration(labelText: 'Quarter'),
                          items: const [
                            DropdownMenuItem(value: 1, child: Text('Q1 (Jan–Mar)')),
                            DropdownMenuItem(value: 2, child: Text('Q2 (Apr–Jun)')),
                            DropdownMenuItem(value: 3, child: Text('Q3 (Jul–Sep)')),
                            DropdownMenuItem(value: 4, child: Text('Q4 (Oct–Dec)')),
                          ],
                          onChanged: (v) =>
                              setState(() => _selectedQuarter = v!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Gross receipts summary ────────────────────────────────
          invoicesAsync.when(
            data: (invoices) {
              final gross = _grossForQuarter(invoices);
              final isSubmitted = _submissions
                  .any((s) => s.period ==
                      _periodCode(_selectedYear, _selectedQuarter));
              return Card(
                color: isSubmitted
                    ? theme.colorScheme.secondaryContainer
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Gross Receipts',
                              style: theme.textTheme.titleSmall),
                          if (isSubmitted) ...[
                            const SizedBox(width: 8),
                            Chip(
                              label: const Text('Submitted'),
                              visualDensity: VisualDensity.compact,
                              backgroundColor:
                                  theme.colorScheme.secondaryContainer,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        currFmt.format(gross),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'From paid invoices in Q$_selectedQuarter $_selectedYear',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'B&O Service tax (Line 6) will be calculated by DOR '
                        'based on current rates.',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Card(
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: LinearProgressIndicator())),
            error: (_, __) =>
                const Card(child: ListTile(title: Text('Error loading invoices'))),
          ),
          const SizedBox(height: 12),

          // ── TRA / Account ─────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Account Info', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _traCtrl,
                    decoration: const InputDecoration(
                      labelText: 'TRA / UBI Number',
                      hintText: 'e.g. 501777540',
                      helperText:
                          'Your WA Tax Registration Account (UBI) number.',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Notes ─────────────────────────────────────────────────
          TextFormField(
            controller: _notesCtrl,
            decoration: const InputDecoration(
              labelText: 'Notes (optional)',
              hintText: 'e.g. Submitted via MyDOR portal',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 20),

          // ── Actions ───────────────────────────────────────────────
          FilledButton.icon(
            onPressed: _loading ? null : _exportDorCsv,
            icon: const Icon(Icons.download_outlined),
            label: const Text('Export DOR Upload File (.csv)'),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: _loading ? null : _markSubmitted,
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Mark as Submitted'),
          ),
          const SizedBox(height: 8),
          Text(
            'The exported file uses the WA DOR data upload format (ACCOUNT + TAX tags, '
            'line code 6 for Service & Other Activities B&O). Upload it at MyDOR '
            '→ Excise Tax Return → Upload a file.',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    final theme = Theme.of(context);
    final currFmt = NumberFormat.currency(symbol: '\$');

    if (_submissions.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 48, color: Colors.grey),
            SizedBox(height: 12),
            Text('No submissions recorded yet.',
                style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text('Generate a report and tap "Mark as Submitted".',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _submissions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final s = _submissions[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Text(
                s.period.substring(0, 2), // Q1, Q2, etc.
                style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer),
              ),
            ),
            title: Text(s.period,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gross: ${currFmt.format(s.grossAmount)}'),
                Text('Submitted: ${s.submittedAt}'),
                if (s.notes != null) Text(s.notes!),
              ],
            ),
            isThreeLine: true,
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'reexport') _reexportSubmission(s);
                if (value == 'delete') _deleteSubmission(s);
              },
              itemBuilder: (_) => const [
                PopupMenuItem(
                  value: 'reexport',
                  child: ListTile(
                    leading: Icon(Icons.download_outlined),
                    title: Text('Re-export CSV'),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text('Delete record'),
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
