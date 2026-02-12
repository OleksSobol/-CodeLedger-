import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../clients/presentation/providers/client_providers.dart';
import '../../../projects/presentation/providers/project_providers.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../../time_tracking/presentation/providers/time_entry_providers.dart';
import '../../data/models/work_report_data.dart';
import 'report_preview_page.dart';

class ReportsPage extends ConsumerStatefulWidget {
  const ReportsPage({super.key});

  @override
  ConsumerState<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends ConsumerState<ReportsPage> {
  DateTimeRange? _dateRange;
  int? _selectedClientId;
  int? _selectedProjectId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Default to this month
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1);
    _dateRange = DateTimeRange(start: start, end: now);
  }

  Future<void> _pickDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: _dateRange,
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  Future<void> _generateReport() async {
    if (_dateRange == null) return;

    setState(() => _isLoading = true);

    try {
      final start = _dateRange!.start;
      // End date from picker is 00:00 of the last day. We want to include that day.
      // So we add 1 day to make it exclusive end bound (e.g. up to next day 00:00)
      final end = _dateRange!.end.add(const Duration(days: 1));

      final timeDao = ref.read(timeEntryDaoProvider);
      final profileDao = ref.read(userProfileDaoProvider);
      final clientDao = ref.read(clientDaoProvider);
      final projectDao = ref.read(projectDaoProvider);

      // Fetch data
      final profile = await profileDao.getProfile();
      final entries = await timeDao.getAllEntries(
        from: start,
        to: end,
        clientId: _selectedClientId,
        projectId: _selectedProjectId,
      );

      Client? client;
      if (_selectedClientId != null) {
        client = await clientDao.getClient(_selectedClientId!);
      }

      Project? project;
      if (_selectedProjectId != null) {
        project = await projectDao.getProject(_selectedProjectId!);
      }

      // Resolve project names
      final projectIds = entries.map((e) => e.projectId).whereType<int>().toSet();
      final projectNames = <int, String>{};
      for (final pid in projectIds) {
        try {
          final p = await projectDao.getProject(pid);
          projectNames[pid] = p.name;
        } catch (_) {
          projectNames[pid] = 'Unknown Project';
        }
      }

      final reportData = WorkReportData(
        profile: profile,
        startDate: start,
        endDate: _dateRange!.end, // Displayed end date
        entries: entries,
        client: client,
        project: project,
        projectNames: projectNames,
      );

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ReportPreviewPage(data: reportData),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating report: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(activeClientsProvider);
    final projectsAsync = ref.watch(allActiveProjectsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Reports'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Report Settings',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    
                    // Date Range
                    InkWell(
                      onTap: _pickDateRange,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date Range',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.date_range),
                        ),
                        child: Text(
                          _dateRange == null
                              ? 'Select dates'
                              : '${_formatDate(_dateRange!.start)} - ${_formatDate(_dateRange!.end)}',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                      // Client Dropdown
                    clientsAsync.when(
                      data: (clients) => InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Client (Optional)',
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int?>(
                            value: _selectedClientId,
                            isDense: true,
                            items: [
                              const DropdownMenuItem(value: null, child: Text('All Clients')),
                              ...clients.map((c) => DropdownMenuItem(
                                    value: c.id,
                                    child: Text(c.name),
                                  )),
                            ],
                            onChanged: (val) {
                              setState(() {
                                _selectedClientId = val;
                                _selectedProjectId = null;
                              });
                            },
                          ),
                        ),
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const Text('Error loading clients'),
                    ),
                    const SizedBox(height: 16),

                    // Project Dropdown
                    projectsAsync.when(
                      data: (projects) {
                        // Filter projects if client is selected
                        final filtered = _selectedClientId == null
                            ? projects
                            : projects.where((p) => p.clientId == _selectedClientId).toList();
                        
                        return InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Project (Optional)',
                            border: OutlineInputBorder(),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int?>(
                              value: _selectedProjectId,
                              isDense: true,
                              items: [
                                const DropdownMenuItem(value: null, child: Text('All Projects')),
                                ...filtered.map((p) => DropdownMenuItem(
                                      value: p.id,
                                      child: Text(p.name),
                                    )),
                              ],
                              onChanged: (val) {
                                setState(() => _selectedProjectId = val);
                              },
                            ),
                          ),
                        );
                      },
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => const Text('Error loading projects'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _generateReport,
              icon: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.picture_as_pdf),
              label: Text(_isLoading ? 'Generating...' : 'Generate PDF Report'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }
}
