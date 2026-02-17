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

  /// Update an existing template's styling fields.
  Future<bool> updateTemplate(int id, InvoiceTemplatesCompanion companion) {
    return (update(invoiceTemplates)..where((t) => t.id.equals(id)))
        .write(companion)
        .then((rows) => rows > 0);
  }

  /// Insert a new custom template.
  Future<int> insertTemplate(InvoiceTemplatesCompanion companion) {
    return into(invoiceTemplates).insert(companion);
  }

  /// Delete a template.
  Future<int> deleteTemplate(int id) {
    return (delete(invoiceTemplates)..where((t) => t.id.equals(id))).go();
  }

  /// Set a template as default (clear others first).
  Future<void> setDefault(int id) async {
    await customStatement(
        'UPDATE invoice_templates SET is_default = 0');
    await (update(invoiceTemplates)..where((t) => t.id.equals(id)))
        .write(const InvoiceTemplatesCompanion(isDefault: Value(true)));
  }
}
