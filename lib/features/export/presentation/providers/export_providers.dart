import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/export_service.dart';

final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService();
});
