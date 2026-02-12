import 'package:pdf/widgets.dart' as pw;
import 'models/pdf_invoice_data.dart';
import 'templates/base_invoice_template.dart';
import 'templates/minimal_template.dart';
import 'templates/detailed_breakdown_template.dart';
import 'templates/modern_developer_template.dart';

/// Registry-based PDF generator using Strategy pattern.
class PdfGenerator {
  static final Map<String, BaseInvoiceTemplate> _templates = {
    'minimal': MinimalTemplate(),
    'detailed': DetailedBreakdownTemplate(),
    'modern_developer': ModernDeveloperTemplate(),
  };

  /// Generate an invoice PDF using the template specified in the data.
  static Future<pw.Document> generateInvoice(PdfInvoiceData data) async {
    final templateKey = data.template.templateKey;
    final template = _templates[templateKey] ?? _templates['minimal']!;
    return template.build(data);
  }

  /// Get all available template keys.
  static List<String> get availableTemplates => _templates.keys.toList();
}
