import 'package:drift/drift.dart';
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

/// Notifier for template mutations (create, update, delete, set default).
final templateNotifierProvider =
    AsyncNotifierProvider<TemplateNotifier, void>(TemplateNotifier.new);

class TemplateNotifier extends AsyncNotifier<void> {
  late InvoiceTemplateDao _dao;

  @override
  Future<void> build() async {
    _dao = ref.watch(invoiceTemplateDaoProvider);
  }

  Future<bool> updateTemplate(
      int id, InvoiceTemplatesCompanion companion) {
    return _dao.updateTemplate(id, companion);
  }

  Future<int> duplicateTemplate(
      InvoiceTemplate source, String newName) {
    return _dao.insertTemplate(InvoiceTemplatesCompanion.insert(
      name: newName,
      templateKey:
          '${source.templateKey}_copy_${DateTime.now().millisecondsSinceEpoch}',
      description: Value(source.description),
      isDefault: const Value(false),
      primaryColor: Value(source.primaryColor),
      accentColor: Value(source.accentColor),
      fontFamily: Value(source.fontFamily),
      showLogo: Value(source.showLogo),
      showPaymentInfo: Value(source.showPaymentInfo),
      showTaxBreakdown: Value(source.showTaxBreakdown),
      showTaxId: Value(source.showTaxId),
      showBusinessLicense: Value(source.showBusinessLicense),
      showBankDetails: Value(source.showBankDetails),
      showStripeLink: Value(source.showStripeLink),
      showDetailedBreakdown: Value(source.showDetailedBreakdown),
      showPaymentTerms: Value(source.showPaymentTerms),
      showLateFeeClause: Value(source.showLateFeeClause),
      isBuiltIn: const Value(false),
      footerText: Value(source.footerText),
    ));
  }

  Future<void> deleteTemplate(int id) => _dao.deleteTemplate(id);

  Future<void> setDefault(int id) => _dao.setDefault(id);
}
