import 'package:drift/drift.dart';
import 'invoice_templates_table.dart';

class Clients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get contactName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get addressLine1 => text().nullable()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get stateProvince => text().nullable()();
  TextColumn get postalCode => text().nullable()();
  TextColumn get country => text().nullable()();
  RealColumn get hourlyRate => real().nullable()();
  TextColumn get currency => text().withDefault(const Constant('USD'))();
  RealColumn get taxRate => real().nullable()();
  IntColumn get defaultTemplateId =>
      integer().nullable().references(InvoiceTemplates, #id)();
  TextColumn get paymentTermsOverride => text().nullable()();
  IntColumn get paymentTermsDaysOverride => integer().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
