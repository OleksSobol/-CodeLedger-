import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart'; // re-uses appSettingsDaoProvider
import '../../domain/time_entry_field.dart';

const _kFieldConfigKey = 'time_entry_field_config';

/// Persisted list of [FieldConfig] for the time-entry list tile.
/// Backed by AppSettings (same SQLite store as theme mode).
final fieldConfigProvider =
    AsyncNotifierProvider<FieldConfigNotifier, List<FieldConfig>>(
  FieldConfigNotifier.new,
);

class FieldConfigNotifier extends AsyncNotifier<List<FieldConfig>> {
  @override
  Future<List<FieldConfig>> build() async {
    final dao = ref.watch(appSettingsDaoProvider);
    final json = await dao.getValue(_kFieldConfigKey);
    return json == null ? FieldConfig.defaults() : FieldConfig.decode(json);
  }

  Future<void> save(List<FieldConfig> configs) async {
    final dao = ref.read(appSettingsDaoProvider);
    await dao.setValue(_kFieldConfigKey, FieldConfig.encode(configs));
    state = AsyncData(configs);
  }
}
