import 'package:drift/drift.dart';
import 'clients_table.dart';
import 'projects_table.dart';
import 'invoices_table.dart';

class TimeEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  IntColumn get projectId =>
      integer().nullable().references(Projects, #id)();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get issueReference => text().nullable()();
  TextColumn get repository => text().nullable()();
  TextColumn get tags => text().nullable()(); // JSON array of strings
  BoolColumn get isManual =>
      boolean().withDefault(const Constant(false))();
  RealColumn get hourlyRateSnapshot => real()();
  BoolColumn get isInvoiced =>
      boolean().withDefault(const Constant(false))();
  IntColumn get invoiceId =>
      integer().nullable().references(Invoices, #id)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();
}
