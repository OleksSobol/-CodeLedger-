import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/clients_table.dart';
import '../tables/time_entries_table.dart';
import '../tables/invoices_table.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [Clients, TimeEntries, Invoices])
class ClientDao extends DatabaseAccessor<AppDatabase>
    with _$ClientDaoMixin {
  ClientDao(super.db);

  /// Watch all active (non-archived) clients.
  Stream<List<Client>> watchActiveClients() {
    return (select(clients)
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch();
  }

  /// Get all active clients.
  Future<List<Client>> getActiveClients() {
    return (select(clients)
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Get a single client by ID.
  Future<Client> getClient(int id) {
    return (select(clients)..where((t) => t.id.equals(id))).getSingle();
  }

  /// Insert a new client.
  Future<int> insertClient(ClientsCompanion companion) {
    return into(clients).insert(companion);
  }

  /// Update a client.
  Future<bool> updateClient(int id, ClientsCompanion companion) {
    return (update(clients)..where((t) => t.id.equals(id)))
        .write(companion.copyWith(updatedAt: Value(DateTime.now())))
        .then((rows) => rows > 0);
  }

  /// Soft-archive a client.
  Future<bool> archiveClient(int id) {
    return updateClient(
      id,
      const ClientsCompanion(isArchived: Value(true)),
    );
  }

  /// Get uninvoiced hours for a client.
  Future<double> getUninvoicedHours(int clientId) async {
    final query = select(timeEntries)
      ..where((t) =>
          t.clientId.equals(clientId) &
          t.isInvoiced.equals(false) &
          t.endTime.isNotNull());
    final entries = await query.get();
    return entries.fold<double>(
        0, (sum, e) => sum + (e.durationMinutes ?? 0) / 60.0);
  }

  /// Get total billed amount for a client.
  Future<double> getTotalBilled(int clientId) async {
    final query = select(invoices)
      ..where((t) => t.clientId.equals(clientId));
    final inv = await query.get();
    return inv.fold<double>(0, (sum, i) => sum + i.total);
  }

  /// Get total paid amount for a client.
  Future<double> getTotalPaid(int clientId) async {
    final query = select(invoices)
      ..where((t) =>
          t.clientId.equals(clientId) & t.status.equals('paid'));
    final inv = await query.get();
    return inv.fold<double>(0, (sum, i) => sum + i.amountPaid);
  }
}
