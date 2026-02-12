import 'models/work_report_data.dart';
import 'templates/work_report_template.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportGenerator {
  static final _template = SimpleWorkReportTemplate();
  
  static Future<pw.Document> generateReport(WorkReportData data) {
    // For now we only have one template
    return _template.build(data);
  }
}
