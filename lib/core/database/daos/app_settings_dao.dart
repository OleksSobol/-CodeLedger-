import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/app_settings_table.dart';

part 'app_settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  Future<String?> getValue(String key) async {
    final results = await (select(appSettings)
          ..where((t) => t.key.equals(key)))
        .get();
    return results.isEmpty ? null : results.first.value;
  }

  Future<void> setValue(String key, String value) {
    return into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(
        key: key,
        value: value,
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteKey(String key) {
    return (delete(appSettings)..where((t) => t.key.equals(key))).go();
  }
}
