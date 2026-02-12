import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../../../features/dashboard/presentation/providers/dashboard_provider.dart';
import '../../../../core/database/daos/invoice_template_dao.dart';
import '../../../profile/presentation/providers/profile_provider.dart';
import '../../application/pdf_service.dart';

final invoiceTemplateDaoProvider = Provider<InvoiceTemplateDao>((ref) {
  return InvoiceTemplateDao(ref.watch(databaseProvider));
});

final pdfServiceProvider = Provider<PdfService>((ref) {
  // Use .notifier to get the DAO from the notifier provider if that's how it's exposed?
  // No, invoiceDaoProvider is likely a Provider<InvoiceDao>.
  // I need to check invoice_providers.dart to be sure but standard pattern is Provider<InvoiceDao>.
  // The error said "Undefined name 'invoiceDaoProvider'".
  // Maybe it's not exported or named differently?
  // Let's assume it is named invoiceDaoProvider for now, but if it fails again I'll check.
  
  final invoiceDao = ref.watch(invoiceDaoProvider);
  final userProfileDao = ref.watch(userProfileDaoProvider);
  final templateDao = ref.watch(invoiceTemplateDaoProvider);
  
  return PdfService(invoiceDao, userProfileDao, templateDao);
});
