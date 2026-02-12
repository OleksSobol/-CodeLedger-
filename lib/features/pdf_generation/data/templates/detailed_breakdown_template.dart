import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/database/app_database.dart';
import 'base_invoice_template.dart';
import '../models/pdf_invoice_data.dart';

/// Grouped by date, shows each session with description.
class DetailedBreakdownTemplate extends BaseInvoiceTemplate {
  @override
  String get templateKey => 'detailed';
  @override
  String get templateName => 'Detailed Breakdown';

  @override
  Future<pw.Document> build(PdfInvoiceData data) async {
    final doc = pw.Document();
    final primary = colorFromArgb(data.template.primaryColor);
    final accent = colorFromArgb(data.template.accentColor);

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          buildHeader(data, accentColor: primary),
          pw.SizedBox(height: 24),
          buildAddresses(data),
          pw.SizedBox(height: 24),
          _buildGroupedTable(data, accent),
          pw.SizedBox(height: 20),
          buildTotals(data, accentColor: accent),
          pw.SizedBox(height: 24),
          buildPaymentSection(data),
          pw.SizedBox(height: 16),
          buildFooter(data),
        ],
      ),
    );

    return doc;
  }

  pw.Widget _buildGroupedTable(PdfInvoiceData data, PdfColor accent) {
    // Group items that have a time_entry_id by date, put manual items at end
    final timeItems = <InvoiceLineItem>[];
    final manualItems = <InvoiceLineItem>[];

    for (final item in data.lineItems) {
      if (item.timeEntryId != null) {
        timeItems.add(item);
      } else {
        manualItems.add(item);
      }
    }

    final allRows = <List<String>>[];

    // For time-based items, we use the sort order (which was chronological)
    // and show project name if available
    for (final item in timeItems) {
      final projectName = item.projectId != null
          ? data.projectNames[item.projectId] ?? ''
          : '';
      final desc = projectName.isNotEmpty
          ? '$projectName — ${item.description}'
          : item.description;
      allRows.add([
        desc,
        '${item.quantity.toStringAsFixed(2)}h',
        fmtCurrency(item.unitPrice),
        fmtCurrency(item.total),
      ]);
    }

    if (manualItems.isNotEmpty && timeItems.isNotEmpty) {
      allRows.add(['Other Items', '', '', '']);
    }

    for (final item in manualItems) {
      allRows.add([
        item.description,
        item.quantity.toStringAsFixed(2),
        fmtCurrency(item.unitPrice),
        fmtCurrency(item.total),
      ]);
    }

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      headerStyle: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
          color: PdfColors.white),
      headerDecoration: pw.BoxDecoration(color: accent),
      cellStyle: const pw.TextStyle(fontSize: 9),
      cellAlignment: pw.Alignment.centerLeft,
      columnWidths: {
        0: const pw.FlexColumnWidth(4),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(1.2),
        3: const pw.FlexColumnWidth(1.2),
      },
      headers: ['Description', 'Hours', 'Rate', 'Amount'],
      data: allRows,
    );
  }
}
