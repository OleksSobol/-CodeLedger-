import 'package:flutter/material.dart';

class InvoiceStatusBadge extends StatelessWidget {
  final String status;
  const InvoiceStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = _resolve(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  static (String, Color) _resolve(String status) {
    return switch (status) {
      'draft' => ('Draft', Colors.grey),
      'sent' => ('Sent', Colors.blue),
      'paid' => ('Paid', Colors.green),
      'overdue' => ('Overdue', Colors.red),
      'cancelled' => ('Cancelled', Colors.orange),
      _ => (status, Colors.grey),
    };
  }
}
