import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../models/pdf_invoice_data.dart';

/// Strategy interface for invoice PDF templates.
abstract class BaseInvoiceTemplate {
  String get templateKey;
  String get templateName;

  Future<pw.Document> build(PdfInvoiceData data);

  // ── Shared helpers ──────────────────────────────────────────────

  PdfColor colorFromArgb(int argb) {
    return PdfColor(
      ((argb >> 16) & 0xFF) / 255,
      ((argb >> 8) & 0xFF) / 255,
      (argb & 0xFF) / 255,
    );
  }

  String fmtDate(DateTime dt) => DateFormat.yMMMd().format(dt);
  String fmtCurrency(double amount) =>
      formatCurrency(amount);

  pw.Widget buildHeader(PdfInvoiceData data, {PdfColor? accentColor}) {
    final theme = data.template;
    final primary = accentColor ?? colorFromArgb(theme.primaryColor);

    return pw.Container(
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: primary,
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('INVOICE',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 28,
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.SizedBox(height: 4),
                pw.Text(data.invoice.invoiceNumber,
                    style: const pw.TextStyle(
                        color: PdfColors.white, fontSize: 14)),
              ],
            ),
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              if (data.profile.businessName.isNotEmpty)
                pw.Text(data.profile.businessName,
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    )),
              if (data.profile.ownerName.isNotEmpty)
                pw.Text(data.profile.ownerName,
                    style: const pw.TextStyle(
                        color: PdfColors.white, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget buildAddresses(PdfInvoiceData data) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('From',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 10)),
              pw.SizedBox(height: 4),
              if (data.profile.businessName.isNotEmpty)
                pw.Text(data.profile.businessName,
                    style: const pw.TextStyle(fontSize: 10)),
              if (data.formattedAddress.isNotEmpty)
                pw.Text(data.formattedAddress,
                    style: const pw.TextStyle(fontSize: 9)),
              if (data.profile.email != null)
                pw.Text(data.profile.email!,
                    style: const pw.TextStyle(fontSize: 9)),
              if (data.profile.phone != null)
                pw.Text(data.profile.phone!,
                    style: const pw.TextStyle(fontSize: 9)),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Bill To',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 10)),
              pw.SizedBox(height: 4),
              pw.Text(data.client.name,
                  style: const pw.TextStyle(fontSize: 10)),
              if (data.client.contactName != null)
                pw.Text(data.client.contactName!,
                    style: const pw.TextStyle(fontSize: 9)),
              if (data.clientAddress.isNotEmpty)
                pw.Text(data.clientAddress,
                    style: const pw.TextStyle(fontSize: 9)),
              if (data.client.email != null)
                pw.Text(data.client.email!,
                    style: const pw.TextStyle(fontSize: 9)),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              _dateRow('Issue Date', fmtDate(data.invoice.issueDate)),
              _dateRow('Due Date', fmtDate(data.invoice.dueDate)),
              if (data.invoice.periodStart != null &&
                  data.invoice.periodEnd != null)
                _dateRow('Period',
                    '${fmtDate(data.invoice.periodStart!)} - ${fmtDate(data.invoice.periodEnd!)}'),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _dateRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1),
      child: pw.Row(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text('$label: ',
              style:
                  pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
          pw.Text(value, style: const pw.TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  pw.Widget buildTotals(PdfInvoiceData data, {PdfColor? accentColor}) {
    final inv = data.invoice;
    final rows = <pw.Widget>[
      _totalRow('Subtotal', fmtCurrency(inv.subtotal)),
    ];
    if (inv.taxRate > 0) {
      rows.add(_totalRow(
          '${inv.taxLabel} (${inv.taxRate.toStringAsFixed(1)}%)',
          fmtCurrency(inv.taxAmount)));
    }
    if (inv.lateFeeAmount > 0) {
      rows.add(_totalRow('Late Fee', fmtCurrency(inv.lateFeeAmount)));
    }
    rows.add(pw.Divider(thickness: 0.5));
    rows.add(pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text('TOTAL',
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold, fontSize: 14)),
        pw.Text(fmtCurrency(inv.total),
            style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 14,
                color: accentColor)),
      ],
    ));
    if (inv.amountPaid > 0) {
      rows.add(_totalRow('Paid', fmtCurrency(inv.amountPaid)));
      final remaining = inv.total - inv.amountPaid;
      if (remaining > 0) {
        rows.add(pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Balance Due',
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                    color: PdfColors.red)),
            pw.Text(fmtCurrency(remaining),
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                    color: PdfColors.red)),
          ],
        ));
      }
    }

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.SizedBox(
        width: 220,
        child: pw.Column(children: rows),
      ),
    );
  }

  pw.Widget _totalRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10)),
          pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  pw.Widget buildPaymentSection(PdfInvoiceData data) {
    final profile = data.profile;
    final tmpl = data.template;
    final sections = <pw.Widget>[];

    if (tmpl.showPaymentTerms) {
      sections.add(pw.Text(
        'Payment due within ${_resolveTermsDays(data)} days of invoice date.',
        style: const pw.TextStyle(fontSize: 9),
      ));
      sections.add(pw.SizedBox(height: 8));
    }

    if (tmpl.showBankDetails && profile.showBankDetails) {
      final bankLines = <String>[];
      if (profile.bankName != null) bankLines.add('Bank: ${profile.bankName}');
      if (profile.bankRoutingNumber != null) {
        bankLines.add('Routing: ${profile.bankRoutingNumber}');
      }
      if (profile.bankAccountNumber != null) {
        final acct = profile.bankAccountNumber!;
        final masked = acct.length > 4
            ? '${'*' * (acct.length - 4)}${acct.substring(acct.length - 4)}'
            : acct;
        bankLines.add('Account: $masked (${profile.bankAccountType})');
      }
      if (bankLines.isNotEmpty) {
        sections.add(pw.Text('Please remit payment via ACH to:',
            style:
                pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)));
        for (final line in bankLines) {
          sections.add(pw.Padding(
            padding: const pw.EdgeInsets.only(left: 12),
            child: pw.Text(line, style: const pw.TextStyle(fontSize: 9)),
          ));
        }
        sections.add(pw.SizedBox(height: 6));
      }
    }

    if (tmpl.showStripeLink &&
        profile.showStripeLink &&
        profile.stripePaymentLink != null) {
      sections.add(pw.Text('Or pay securely online:',
          style:
              pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)));
      sections.add(pw.Padding(
        padding: const pw.EdgeInsets.only(left: 12),
        child: pw.Text(profile.stripePaymentLink!,
            style: const pw.TextStyle(fontSize: 9, color: PdfColors.blue)),
      ));
      sections.add(pw.SizedBox(height: 6));
    }

    if (profile.paymentInstructions != null &&
        profile.paymentInstructions!.isNotEmpty) {
      sections.add(pw.Text(profile.paymentInstructions!,
          style: const pw.TextStyle(fontSize: 9)));
    }

    if (tmpl.showLateFeeClause && profile.lateFeePercentage != null) {
      sections.add(pw.SizedBox(height: 4));
      sections.add(pw.Text(
        'A late fee of ${profile.lateFeePercentage!.toStringAsFixed(1)}% '
        'may be applied to overdue balances.',
        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
      ));
    }

    if (sections.isEmpty) return pw.SizedBox.shrink();

    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.circular(4),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Payment Information',
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
          pw.SizedBox(height: 6),
          ...sections,
        ],
      ),
    );
  }

  pw.Widget buildFooter(PdfInvoiceData data) {
    final parts = <pw.Widget>[];

    if (data.template.showTaxId &&
        data.profile.showTaxId &&
        data.profile.taxId != null) {
      parts.add(pw.Text('Tax ID: ${data.profile.taxId}',
          style: const pw.TextStyle(fontSize: 8)));
    }

    if (data.template.showBusinessLicense &&
        data.profile.showWaLicense &&
        data.profile.waBusinessLicense != null) {
      parts.add(pw.Text(
          'WA Business License: ${data.profile.waBusinessLicense}',
          style: const pw.TextStyle(fontSize: 8)));
    }

    if (data.template.footerText != null) {
      parts.add(pw.Text(data.template.footerText!,
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey)));
    }

    if (data.invoice.notes != null && data.invoice.notes!.isNotEmpty) {
      parts.add(pw.SizedBox(height: 6));
      parts.add(pw.Text('Notes:',
          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)));
      parts.add(pw.Text(data.invoice.notes!,
          style: const pw.TextStyle(fontSize: 9)));
    }

    if (parts.isEmpty) return pw.SizedBox.shrink();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: parts,
    );
  }

  int _resolveTermsDays(PdfInvoiceData data) {
    return data.invoice.dueDate.difference(data.invoice.issueDate).inDays;
  }
}
