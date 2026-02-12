import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../../data/models/work_report_data.dart';
import '../../data/report_generator.dart';

class ReportPreviewPage extends StatelessWidget {
  final WorkReportData data;

  const ReportPreviewPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report Preview')),
      body: PdfPreview(
        build: (format) async {
            final doc = await ReportGenerator.generateReport(data);
            return doc.save();
        },
        canChangeOrientation: false,
        canDebug: false,
      ),
    );
  }
}
