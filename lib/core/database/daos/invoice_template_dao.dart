import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/invoice_templates_table.dart';

part 'invoice_template_dao.g.dart';

@DriftAccessor(tables: [InvoiceTemplates])
class InvoiceTemplateDao extends DatabaseAccessor<AppDatabase>
    with _$InvoiceTemplateDaoMixin {
  InvoiceTemplateDao(super.db);

  Stream<List<InvoiceTemplate>> watchAll() {
    return (select(invoiceTemplates)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  Future<List<InvoiceTemplate>> getAll() {
    return (select(invoiceTemplates)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  Future<InvoiceTemplate?> getById(int id) {
    return (select(invoiceTemplates)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<InvoiceTemplate?> getByKey(String key) {
    return (select(invoiceTemplates)
          ..where((t) => t.templateKey.equals(key)))
        .getSingleOrNull();
  }

  Future<InvoiceTemplate?> getDefault() async {
    final results = await (select(invoiceTemplates)
          ..where((t) => t.isDefault.equals(true))
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }
}
