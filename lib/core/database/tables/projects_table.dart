import 'package:drift/drift.dart';
import 'clients_table.dart';

class Projects extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #id)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  RealColumn get hourlyRateOverride => real().nullable()();
  IntColumn get color => integer().withDefault(const Constant(0xFF2196F3))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isArchived =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {clientId, name}
      ];
}
