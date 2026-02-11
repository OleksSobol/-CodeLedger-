import 'package:intl/intl.dart';

String formatCurrency(double amount, {String currency = 'USD'}) {
  final format = NumberFormat.currency(
    symbol: _currencySymbol(currency),
    decimalDigits: 2,
  );
  return format.format(amount);
}

String _currencySymbol(String currencyCode) {
  switch (currencyCode.toUpperCase()) {
    case 'USD':
      return '\$';
    case 'EUR':
      return '\u20AC';
    case 'GBP':
      return '\u00A3';
    case 'AUD':
      return 'A\$';
    case 'CAD':
      return 'C\$';
    case 'JPY':
      return '\u00A5';
    default:
      return '$currencyCode ';
  }
}
