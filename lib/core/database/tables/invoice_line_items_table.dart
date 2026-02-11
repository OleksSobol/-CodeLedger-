import 'package:drift/drift.dart';
import 'invoices_table.dart';
import 'time_entries_table.dart';
import 'projects_table.dart';

class InvoiceLineItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(Invoices, #id)();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  TextColumn get description => text()();
  RealColumn get quantity => real()();
  RealColumn get unitPrice => real()();
  RealColumn get total => real()();
  IntColumn get timeEntryId =>
      integer().nullable().references(TimeEntries, #id)();
  IntColumn get projectId =>
      integer().nullable().references(Projects, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}
