import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/invoice_template_dao.dart';
import '../../../../core/providers/database_provider.dart';

final invoiceTemplateDaoProvider = Provider<InvoiceTemplateDao>((ref) {
  return InvoiceTemplateDao(ref.watch(databaseProvider));
});

final allTemplatesProvider = StreamProvider<List<InvoiceTemplate>>((ref) {
  return ref.watch(invoiceTemplateDaoProvider).watchAll();
});

final defaultTemplateProvider = FutureProvider<InvoiceTemplate?>((ref) {
  return ref.watch(invoiceTemplateDaoProvider).getDefault();
});
