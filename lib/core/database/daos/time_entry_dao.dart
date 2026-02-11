import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/time_entries_table.dart';

part 'time_entry_dao.g.dart';

@DriftAccessor(tables: [TimeEntries])
class TimeEntryDao extends DatabaseAccessor<AppDatabase>
    with _$TimeEntryDaoMixin {
  TimeEntryDao(super.db);

  /// Check if there's a currently running timer (end_time is null).
  Future<TimeEntry?> getRunningEntry() async {
    final query = select(timeEntries)
      ..where((t) => t.endTime.isNull())
      ..limit(1);
    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  Stream<TimeEntry?> watchRunningEntry() {
    return (select(timeEntries)
          ..where((t) => t.endTime.isNull())
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Insert a time entry with overlap check (in a transaction).
  Future<int> insertWithOverlapCheck(TimeEntriesCompanion entry) {
    return transaction(() async {
      final start = entry.startTime.value;
      final end = entry.endTime.value;

      if (end != null) {
        final overlapping = await _findOverlapping(start, end);
        if (overlapping.isNotEmpty) {
          throw OverlappingTimeEntryException(overlapping.first);
        }
      }
      return into(timeEntries).insert(entry);
    });
  }

  /// Clock out the running entry.
  Future<bool> clockOut(int entryId, {String? description}) {
    final now = DateTime.now();
    return transaction(() async {
      final entry =
          await (select(timeEntries)..where((t) => t.id.equals(entryId)))
              .getSingle();
      final duration = now.difference(entry.startTime).inMinutes;

      // Check for overlaps with the new end time
      final overlapping =
          await _findOverlapping(entry.startTime, now, excludeId: entryId);
      if (overlapping.isNotEmpty) {
        throw OverlappingTimeEntryException(overlapping.first);
      }

      return (update(timeEntries)..where((t) => t.id.equals(entryId)))
          .write(TimeEntriesCompanion(
            endTime: Value(now),
            durationMinutes: Value(duration),
            description:
                description != null ? Value(description) : const Value.absent(),
            updatedAt: Value(now),
          ))
          .then((rows) => rows > 0);
    });
  }

  /// Find overlapping entries for a given time range.
  Future<List<TimeEntry>> _findOverlapping(
    DateTime start,
    DateTime end, {
    int? excludeId,
  }) {
    final query = select(timeEntries)
      ..where((t) {
        // Overlap: existing.start < new.end AND existing.end > new.start
        // Also exclude entries with null end_time (running timers handled separately)
        var condition = t.startTime.isSmallerThanValue(end) &
            t.endTime.isNotNull() &
            t.endTime.isBiggerThanValue(start);
        if (excludeId != null) {
          condition = condition & t.id.equals(excludeId).not();
        }
        return condition;
      });
    return query.get();
  }

  /// Get entries for a date range.
  Stream<List<TimeEntry>> watchEntriesForDateRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(timeEntries)
          ..where((t) =>
              t.startTime.isBiggerOrEqualValue(start) &
              t.startTime.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
        .watch();
  }

  /// Get uninvoiced entries for a client.
  Future<List<TimeEntry>> getUninvoicedForClient(int clientId) {
    return (select(timeEntries)
          ..where((t) =>
              t.clientId.equals(clientId) &
              t.isInvoiced.equals(false) &
              t.endTime.isNotNull())
          ..orderBy([(t) => OrderingTerm.asc(t.startTime)]))
        .get();
  }

  /// Get uninvoiced entries for a specific project.
  Future<List<TimeEntry>> getUninvoicedForProject(int projectId) {
    return (select(timeEntries)
          ..where((t) =>
              t.projectId.equals(projectId) &
              t.isInvoiced.equals(false) &
              t.endTime.isNotNull())
          ..orderBy([(t) => OrderingTerm.asc(t.startTime)]))
        .get();
  }

  /// Mark entries as invoiced.
  Future<void> markAsInvoiced(List<int> entryIds, int invoiceId) {
    return (update(timeEntries)..where((t) => t.id.isIn(entryIds))).write(
      TimeEntriesCompanion(
        isInvoiced: const Value(true),
        invoiceId: Value(invoiceId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Unmark entries (e.g., when deleting a draft invoice).
  Future<void> unmarkInvoiced(int invoiceId) {
    return (update(timeEntries)
          ..where((t) => t.invoiceId.equals(invoiceId)))
        .write(const TimeEntriesCompanion(
          isInvoiced: Value(false),
          invoiceId: Value(null),
        ));
  }

  /// Get all entries (for export).
  Future<List<TimeEntry>> getAllEntries({
    DateTime? from,
    DateTime? to,
    int? clientId,
    int? projectId,
  }) {
    final query = select(timeEntries);
    query.where((t) {
      Expression<bool> condition = const Constant(true);
      if (from != null) {
        condition = condition & t.startTime.isBiggerOrEqualValue(from);
      }
      if (to != null) {
        condition = condition & t.startTime.isSmallerThanValue(to);
      }
      if (clientId != null) {
        condition = condition & t.clientId.equals(clientId);
      }
      if (projectId != null) {
        condition = condition & t.projectId.equals(projectId);
      }
      return condition;
    });
    query.orderBy([(t) => OrderingTerm.desc(t.startTime)]);
    return query.get();
  }
}

class OverlappingTimeEntryException implements Exception {
  final TimeEntry existing;
  OverlappingTimeEntryException(this.existing);

  @override
  String toString() =>
      'Time entry overlaps with existing entry from '
      '${existing.startTime} to ${existing.endTime}';
}
