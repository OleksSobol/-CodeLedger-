import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../../../core/database/app_database.dart';

class ExportService {
  Future<File> generateTimeEntriesCsv({
    required List<TimeEntry> entries,
    required Map<int, String> projectNames,
    required Map<int, String> clientNames,
  }) async {
    final rows = <List<dynamic>>[];
    
    // Header
    rows.add([
      'Date',
      'Client',
      'Project',
      'Start Time',
      'End Time',
      'Duration (min)',
      'Description',
      'Repository',
      'Issue Ref',
      'Is Invoiced',
      'Invoice ID',
    ]);

    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat('HH:mm');

    for (final e in entries) {
      final date = dateFormat.format(e.startTime);
      final clientName = clientNames[e.clientId] ?? 'Unknown Client';
      final projectName = e.projectId != null ? (projectNames[e.projectId] ?? '') : '';
      final start = timeFormat.format(e.startTime);
      final end = e.endTime != null ? timeFormat.format(e.endTime!) : '';
      
      rows.add([
        date,
        clientName,
        projectName,
        start,
        end,
        e.durationMinutes ?? 0,
        e.description ?? '',
        e.repository ?? '',
        e.issueReference ?? '',
        e.isInvoiced ? 'Yes' : 'No',
        e.invoiceId ?? '',
      ]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final dir = await getTemporaryDirectory();
    final filename = 'time_entries_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.csv';
    final file = File('${dir.path}/$filename');
    
    await file.writeAsString(csv);
    return file;
  }
}
