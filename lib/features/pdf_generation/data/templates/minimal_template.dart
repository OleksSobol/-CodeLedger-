import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'base_invoice_template.dart';
import '../models/pdf_invoice_data.dart';

/// Clean single-total-line invoice, minimal detail.
class MinimalTemplate extends BaseInvoiceTemplate {
  @override
  String get templateKey => 'minimal';
  @override
  String get templateName => 'Minimal';

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

          // Simple summary table — one line per item, no grouping
          _buildSimpleTable(data, accent),
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

  pw.Widget _buildSimpleTable(PdfInvoiceData data, PdfColor accent) {
    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      headerStyle:
          pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10, color: PdfColors.white),
      headerDecoration: pw.BoxDecoration(color: accent),
      cellStyle: const pw.TextStyle(fontSize: 9),
      cellAlignment: pw.Alignment.centerLeft,
      columnWidths: {
        0: const pw.FlexColumnWidth(4),
        1: const pw.FlexColumnWidth(1),
        2: const pw.FlexColumnWidth(1.2),
        3: const pw.FlexColumnWidth(1.2),
      },
      headers: ['Description', 'Qty', 'Rate', 'Amount'],
      data: data.lineItems
          .map((item) => [
                item.description,
                item.quantity.toStringAsFixed(2),
                fmtCurrency(item.unitPrice),
                fmtCurrency(item.total),
              ])
          .toList(),
    );
  }
}
