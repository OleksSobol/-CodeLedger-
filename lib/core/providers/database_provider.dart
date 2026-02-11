import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';

/// Single global instance of the Drift database.
/// Created lazily on first read; lives for the entire app session.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
