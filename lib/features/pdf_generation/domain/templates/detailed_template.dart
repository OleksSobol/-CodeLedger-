import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import '../../../../core/database/daos/invoice_dao.dart';
import '../../../../core/database/app_database.dart';
import '../pdf_generator_strategy.dart';

class DetailedTemplate extends PdfGeneratorStrategy {
  @override
  Future<Uint8List> generate({
    required Invoice invoice,
    required Client client,
    required UserProfile userProfile,
    required List<LineItemWithDetails> lineItems,
    required InvoiceTemplate template,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return [
            // Re-use header from base or custom? Base provided a helper, let's use it
            buildHeader(context, userProfile, invoice),
            pw.SizedBox(height: 30),

            // Client Info
            _buildClientInfo(client),
            pw.SizedBox(height: 30),

            // Grouped Line Items
            ..._buildGroupedLineItems(lineItems, invoice.currency),
            pw.SizedBox(height: 20),

            // Totals
            _buildTotals(invoice, template),
            pw.SizedBox(height: 40),

            // Payment Info
            if (template.showPaymentInfo)
              _buildPaymentInfo(userProfile, invoice, template),
            
             // Footer
            if (template.footerText != null && template.footerText!.isNotEmpty)
             pw.Padding(
               padding: const pw.EdgeInsets.only(top: 20),
               child: pw.Text(template.footerText!, 
                 style: const pw.TextStyle(color: PdfColors.grey600, fontSize: 10),
                 textAlign: pw.TextAlign.center),
             ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildClientInfo(Client client) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Bill To:',
            style: pw.TextStyle(
                fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColors.grey700)),
        pw.SizedBox(height: 4),
        pw.Text(client.name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        if (client.contactName != null) pw.Text(client.contactName!),
        if (client.addressLine1 != null) pw.Text(client.addressLine1!),
        if (client.city != null)
          pw.Text(
              '${client.city}, ${client.stateProvince ?? ""} ${client.postalCode ?? ""}'),
      ],
    );
  }

  List<pw.Widget> _buildGroupedLineItems(List<LineItemWithDetails> items, String currency) {
    final widgets = <pw.Widget>[];

    // Group by date
    final grouped = groupBy(items, (LineItemWithDetails item) {
      if (item.timeEntry != null) {
        final start = item.timeEntry!.startTime;
        return DateTime(start.year, start.month, start.day);
      }
      return null; // Manual items
    });

    // Sort keys: Dates first (sorted), then null (manual items)
    final keys = grouped.keys.toList()
      ..sort((a, b) {
        if (a == null) return 1;
        if (b == null) return -1;
        return a.compareTo(b);
      });

    for (final date in keys) {
      final dateItems = grouped[date]!;
      
      // Date Header for Time Entries
      if (date != null) {
        widgets.add(
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: PdfColors.grey200,
            width: double.infinity,
            child: pw.Text(
              DateFormat.yMMMMEEEEd().format(date),
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            ),
          ),
        );
      } else {
        // Section for manual items
        widgets.add(
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: PdfColors.grey200,
            width: double.infinity,
            child: pw.Text(
              'Other Items',
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10),
            ),
          ),
        );
      }

      // Items table for this group
      widgets.add(
        pw.TableHelper.fromTextArray(
          headers: null, // No headers for inner tables to avoid repetition
          data: dateItems.map((item) {
             String desc = item.lineItem.description;
             // Append issue ref if available
             if (item.timeEntry?.issueReference != null) {
               desc += ' (${item.timeEntry!.issueReference})';
             }
             
             return [
              desc,
              item.lineItem.quantity.toStringAsFixed(2),
              formatCurrency(item.lineItem.unitPrice, currency),
              formatCurrency(item.lineItem.total, currency),
            ];
          }).toList(),
          // Custom widths to align with valid "headers" if we had them
          columnWidths: {
            0: const pw.FlexColumnWidth(4),
            1: const pw.FixedColumnWidth(50),
            2: const pw.FixedColumnWidth(80),
            3: const pw.FixedColumnWidth(80),
          },
          cellAlignments: {
            0: pw.Alignment.centerLeft,
            1: pw.Alignment.centerRight,
            2: pw.Alignment.centerRight,
            3: pw.Alignment.centerRight,
          },
          border: null,
          cellStyle: const pw.TextStyle(fontSize: 10),
          cellPadding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        ),
      );
      
      widgets.add(pw.SizedBox(height: 10));
    }

    return widgets;
  }

  pw.Widget _buildTotals(Invoice invoice, InvoiceTemplate template) {
    final taxRate = invoice.taxRate / 100;
    final subtotal = invoice.total / (1 + taxRate);
    final taxAmount = invoice.total - subtotal;
    
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Container(
          width: 200,
          child: pw.Column(
            children: [
              _buildTotalRow('Subtotal', formatCurrency(subtotal, invoice.currency)),
              if (template.showTaxBreakdown && invoice.taxRate > 0)
                _buildTotalRow('Tax (${invoice.taxRate}%)', formatCurrency(taxAmount, invoice.currency)),
              pw.Divider(),
              _buildTotalRow('Total', formatCurrency(invoice.total, invoice.currency), isBold: true),
              _buildTotalRow('Amount Paid', formatCurrency(invoice.amountPaid, invoice.currency)),
              pw.SizedBox(height: 4),
              _buildTotalRow('Balance Due', 
                 formatCurrency(invoice.total - invoice.amountPaid, invoice.currency), 
                 isBold: true, color: PdfColors.red700),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildTotalRow(String label, String value, {bool isBold = false, PdfColor? color}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : null)),
          pw.Text(value, style: pw.TextStyle(fontWeight: isBold ? pw.FontWeight.bold : null, color: color)),
        ],
      ),
    );
  }
  
  pw.Widget _buildPaymentInfo(UserProfile profile, Invoice invoice, InvoiceTemplate template) {
     return pw.Container(
       padding: const pw.EdgeInsets.all(10),
       decoration: pw.BoxDecoration(
         border: pw.Border.all(color: PdfColors.grey300),
         borderRadius: pw.BorderRadius.circular(4),
       ),
       child: pw.Column(
         crossAxisAlignment: pw.CrossAxisAlignment.start,
         children: [
           pw.Text('Payment Information', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
           pw.SizedBox(height: 5),
           if (template.showBankDetails && profile.bankName != null && profile.showBankDetails) ...[
             pw.Text('Bank: ${profile.bankName}'),
             if (profile.bankAccountName != null) pw.Text('Account Name: ${profile.bankAccountName}'),
             if (profile.bankAccountNumber != null) pw.Text('Account #: ${profile.bankAccountNumber}'),
             pw.SizedBox(height: 5),
           ],
           if (template.showStripeLink && profile.stripePaymentLink != null && profile.showStripeLink)
             pw.UrlLink(
               child: pw.Text('Pay Online', style: const pw.TextStyle(color: PdfColors.blue, decoration: pw.TextDecoration.underline)),
               destination: profile.stripePaymentLink!,
             ),
         ],
       ),
     );
  }
}
