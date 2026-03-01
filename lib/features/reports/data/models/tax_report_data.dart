import '../../../../core/database/app_database.dart';

/// One resolved row in the tax / income report.
class TaxReportRow {
  final Invoice invoice;
  final String clientName;

  const TaxReportRow({required this.invoice, required this.clientName});

  /// Tax column label for the PDF cell.
  /// Shows label + rate when tax > 0, otherwise empty string.
  String get taxColumnLabel {
    if (invoice.taxRate == 0.0) return '';
    return '${invoice.taxLabel} ${invoice.taxRate.toStringAsFixed(0)}%';
  }
}

class TaxReportData {
  final UserProfile profile;
  final DateTime startDate;
  final DateTime endDate;
  final List<TaxReportRow> rows;
  final String? clientFilterName; // null = all clients

  const TaxReportData({
    required this.profile,
    required this.startDate,
    required this.endDate,
    required this.rows,
    this.clientFilterName,
  });

  double get totalSubtotal =>
      rows.fold(0.0, (s, r) => s + r.invoice.subtotal);
  double get totalTax =>
      rows.fold(0.0, (s, r) => s + r.invoice.taxAmount);
  double get totalPaid =>
      rows.fold(0.0, (s, r) => s + r.invoice.amountPaid);
  String get currency =>
      rows.isEmpty ? 'USD' : rows.first.invoice.currency;

  String _fmt(DateTime d) =>
      '${d.month.toString().padLeft(2, '0')}/'
      '${d.day.toString().padLeft(2, '0')}/'
      '${d.year}';
  String get dateRangeText => '${_fmt(startDate)} - ${_fmt(endDate)}';
}
