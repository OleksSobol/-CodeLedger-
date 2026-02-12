import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/database/daos/invoice_dao.dart';
import '../../../../core/database/app_database.dart';

/// Abstract base class for invoice PDF generation strategies.
abstract class PdfGeneratorStrategy {
  /// Generates the PDF bytes for the given invoice data.
  Future<Uint8List> generate({
    required Invoice invoice,
    required Client client,
    required UserProfile userProfile,
    required List<LineItemWithDetails> lineItems,
    required InvoiceTemplate template,
  });

  /// Helper to format currency (e.g. $ 1,234.56)
  String formatCurrency(double amount, String currency) {
    // Simple formatter, can be replaced with NumberFormat
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  /// Helper to format a date (e.g. 2023-10-27)
  String formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Common header section
  pw.Widget buildHeader(
      pw.Context context, UserProfile userProfile, Invoice invoice) {
    return pw.Header(
      level: 0,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(userProfile.businessName,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              if (userProfile.ownerName.isNotEmpty)
                pw.Text(userProfile.ownerName),
              if (userProfile.email != null) pw.Text(userProfile.email!),
            ],
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text('INVOICE',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Text('Invoice #: ${invoice.invoiceNumber}'),
              pw.Text('Date: ${formatDate(invoice.issueDate)}'),
              pw.Text('Due Date: ${formatDate(invoice.dueDate)}'),
            ],
          ),
        ],
      ),
    );
  }
}
