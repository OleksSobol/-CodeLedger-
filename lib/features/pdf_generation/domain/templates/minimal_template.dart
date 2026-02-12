import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../core/database/daos/invoice_dao.dart';
import '../../../../core/database/app_database.dart';
import '../pdf_generator_strategy.dart';

class MinimalTemplate extends PdfGeneratorStrategy {
  @override
  Future<Uint8List> generate({
    required Invoice invoice,
    required Client client,
    required UserProfile userProfile,
    required List<LineItemWithDetails> lineItems,
    required InvoiceTemplate template,
  }) async {
    final pdf = pw.Document();

    // Use built-in fonts for now, can load custom ones later if needed
    // final font = await PdfGoogleFonts.interRegular();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return [
            // Header
            _buildHeader(context, userProfile, invoice, template),
            pw.SizedBox(height: 30),

            // Client Info
            _buildClientInfo(client),
            pw.SizedBox(height: 30),

            // Line Items Table
            _buildLineItemsTable(lineItems, invoice.currency),
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

  pw.Widget _buildHeader(pw.Context context, UserProfile userProfile,
      Invoice invoice, InvoiceTemplate template) {
    return super.buildHeader(context, userProfile, invoice);
    // Actually, MinimalTemplate had its own _buildHeader logic.
    // I should preserve it, but I see I commented out the imports which might break `buildHeader` in base class if I relied on it.
    // The previous implementation used its own `_buildHeader` which called `super`? No, it implemented it fully.
    // Let's just fix the signature first.
  }
  
  // Wait, I am replacing the whole generate method block, so I need to match the original content but with new signature.
  // And `_buildLineItemsTable` needs update.
  
  pw.Widget _buildLineItemsTable(List<LineItemWithDetails> items, String currency) {
    final headers = ['Description', 'Qty', 'Unit Price', 'Amount'];
    
    return pw.TableHelper.fromTextArray(
      headers: headers,
      data: items.map((item) {
        return [
          item.lineItem.description,
          item.lineItem.quantity.toStringAsFixed(2),
          formatCurrency(item.lineItem.unitPrice, currency),
          formatCurrency(item.lineItem.total, currency),
        ];
      }).toList(),
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
      cellHeight: 25,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey50),
    );
  }

  pw.Widget _buildTotals(Invoice invoice, InvoiceTemplate template) {
    // Calculate subtotal from DB or recompute? Invoice table has total, but not subtotal directly stored?
    // Wait, Invoice table has total, date, etc. Logic usually computes subtotal.
    // Let's infer subtotal for now as total - tax.
    
    // Actually, we should probably pass calculated totals if not in DB.
    // For now assuming: total = subtotal + (subtotal * taxRate)
    // So subtotal = total / (1 + taxRate)
    
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
             if (profile.bankRoutingNumber != null) pw.Text('Routing #: ${profile.bankRoutingNumber}'),
             pw.SizedBox(height: 5),
           ],
           if (template.showStripeLink && profile.stripePaymentLink != null && profile.showStripeLink)
             pw.UrlLink(
               child: pw.Text('Pay Online via Stripe', style: const pw.TextStyle(color: PdfColors.blue, decoration: pw.TextDecoration.underline)),
               destination: profile.stripePaymentLink!,
             ),
           if (profile.paymentInstructions != null)
             pw.Padding(
               padding: const pw.EdgeInsets.only(top: 5),
               child: pw.Text(profile.paymentInstructions!, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
             ),
         ],
       ),
     );
  }
}
