import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/daos/app_settings_dao.dart';
import 'database_provider.dart';

const _themeKey = 'theme_mode';

final appSettingsDaoProvider = Provider<AppSettingsDao>((ref) {
  return AppSettingsDao(ref.watch(databaseProvider));
});

/// Persisted theme mode: system, light, or dark.
final themeModeProvider =
    AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  @override
  Future<ThemeMode> build() async {
    final dao = ref.watch(appSettingsDaoProvider);
    final value = await dao.getValue(_themeKey);
    return _fromString(value);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final dao = ref.read(appSettingsDaoProvider);
    await dao.setValue(_themeKey, mode.name);
    state = AsyncData(mode);
  }

  static ThemeMode _fromString(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
