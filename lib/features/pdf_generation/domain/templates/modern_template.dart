import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/database/daos/invoice_dao.dart';
import '../../../../core/database/app_database.dart';
import '../pdf_generator_strategy.dart';

class ModernTemplate extends PdfGeneratorStrategy {
  @override
  Future<Uint8List> generate({
    required Invoice invoice,
    required Client client,
    required UserProfile userProfile,
    required List<LineItemWithDetails> lineItems,
    required InvoiceTemplate template,
  }) async {
    final pdf = pw.Document();
    
    // Use the template colors
    final primaryColor = PdfColor.fromInt(template.primaryColor); // e.g. Teal

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        build: (context) {
          return [
             pw.Row(
               crossAxisAlignment: pw.CrossAxisAlignment.start,
               children: [
                 // Left Sidebar with colors
                 pw.Expanded(
                   flex: 1,
                   child: pw.Column(
                     crossAxisAlignment: pw.CrossAxisAlignment.start,
                     children: [
                       pw.Text(userProfile.businessName, 
                         style: pw.TextStyle(color: primaryColor, fontSize: 24, fontWeight: pw.FontWeight.bold)),
                       pw.SizedBox(height: 20),
                       _buildLabelValue('INVOICE', invoice.invoiceNumber, isHeader: true),
                       pw.SizedBox(height: 10),
                       _buildLabelValue('DATE', formatDate(invoice.issueDate)),
                       _buildLabelValue('DUE', formatDate(invoice.dueDate)),
                       pw.SizedBox(height: 30),
                       pw.Text('BILL TO', style: pw.TextStyle(color: PdfColors.grey600, fontSize: 10, fontWeight: pw.FontWeight.bold)),
                       pw.SizedBox(height: 5),
                       pw.Text(client.name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                       if (client.addressLine1 != null) pw.Text(client.addressLine1!, style: const pw.TextStyle(fontSize: 10)),
                       if (client.city != null) pw.Text(client.city!, style: const pw.TextStyle(fontSize: 10)),
                     ],
                   )
                 ),
                 // Right Content
                 pw.Expanded(
                   flex: 2,
                   child: pw.Column(
                     children: [
                       pw.Container(
                         height: 5,
                         color: primaryColor,
                         width: double.infinity,
                       ),
                       pw.SizedBox(height: 40),
                       _buildLineItemsTable(lineItems, invoice.currency, primaryColor),
                       pw.SizedBox(height: 20),
                       _buildTotals(invoice, template, primaryColor),
                       pw.SizedBox(height: 40),
                       if (template.showPaymentInfo)
                         _buildPaymentInfo(userProfile, invoice, template, primaryColor),
                     ]
                   )
                 ),
               ]
             ),
          ];
         },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildLabelValue(String label, String value, {bool isHeader = false}) {
     return pw.Column(
       crossAxisAlignment: pw.CrossAxisAlignment.start,
       children: [
         pw.Text(label, style: pw.TextStyle(color: PdfColors.grey600, fontSize: 10, fontWeight: pw.FontWeight.bold)),
         pw.Text(value, style: pw.TextStyle(fontSize: isHeader ? 16 : 12, fontWeight: isHeader ? pw.FontWeight.bold : null)),
       ]
     );
  }

  pw.Widget _buildLineItemsTable(List<LineItemWithDetails> items, String currency, PdfColor primaryColor) {
    final headers = ['DESCRIPTION', 'QTY', 'PRICE', 'AMOUNT'];
    
    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: items.map((item) {
        String desc = item.lineItem.description;
         if (item.timeEntry?.repository != null) {
           desc += '\nRepo: ${item.timeEntry!.repository}';
         }
        return [
          desc,
          item.lineItem.quantity.toStringAsFixed(2),
          formatCurrency(item.lineItem.unitPrice, currency),
          formatCurrency(item.lineItem.total, currency),
        ];
      }).toList(),
      border: null,
      headerStyle: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10),
      headerDecoration: pw.BoxDecoration(color: primaryColor),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
    );
  }

  pw.Widget _buildTotals(Invoice invoice, InvoiceTemplate template, PdfColor color) {
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
              _buildTotalRow('SUBTOTAL', formatCurrency(subtotal, invoice.currency)),
              if (template.showTaxBreakdown && invoice.taxRate > 0)
                _buildTotalRow('TAX (${invoice.taxRate}%)', formatCurrency(taxAmount, invoice.currency)),
              pw.Divider(color: color),
              _buildTotalRow('TOTAL', formatCurrency(invoice.total, invoice.currency), isBold: true, color: color),
              pw.SizedBox(height: 4),
              _buildTotalRow('BALANCE DUE', 
                 formatCurrency(invoice.total - invoice.amountPaid, invoice.currency), 
                 isBold: true),
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
          pw.Text(label, style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColors.grey600)),
          pw.Text(value, style: pw.TextStyle(fontSize: 12, fontWeight: isBold ? pw.FontWeight.bold : null, color: color)),
        ],
      ),
    );
  }
  
  pw.Widget _buildPaymentInfo(UserProfile profile, Invoice invoice, InvoiceTemplate template, PdfColor color) {
     return pw.Container(
       width: double.infinity,
       padding: const pw.EdgeInsets.all(15),
       color: PdfColor(color.red, color.green, color.blue, 0.1),
       child: pw.Column(
         crossAxisAlignment: pw.CrossAxisAlignment.start,
         children: [
           pw.Text('PAYMENT DETAILS', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: color)),
           pw.SizedBox(height: 5),
           if (template.showBankDetails && profile.bankName != null && profile.showBankDetails) ...[
             pw.Text('Bank: ${profile.bankName}', style: const pw.TextStyle(fontSize: 10)),
             if (profile.bankAccountNumber != null) pw.Text('Account #: ${profile.bankAccountNumber}', style: const pw.TextStyle(fontSize: 10)),
             if (profile.bankRoutingNumber != null) pw.Text('Routing #: ${profile.bankRoutingNumber}', style: const pw.TextStyle(fontSize: 10)),
           ],
         ],
       ),
     );
  }
}
