enum PaymentTerms {
  net7('net_7', 'Net 7', 7),
  net14('net_14', 'Net 14', 14),
  net30('net_30', 'Net 30', 30),
  custom('custom', 'Custom', 0);

  const PaymentTerms(this.value, this.label, this.days);

  final String value;
  final String label;
  final int days;

  static PaymentTerms fromString(String value) {
    return PaymentTerms.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PaymentTerms.net30,
    );
  }

  int resolveDays({int? customDays}) {
    if (this == PaymentTerms.custom) {
      return customDays ?? 30;
    }
    return days;
  }
}
