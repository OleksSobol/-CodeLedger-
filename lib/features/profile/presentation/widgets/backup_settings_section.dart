import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';

const _passphraseKey = 'backup_passphrase';

/// Reads the stored backup passphrase (or null if not set).
final backupPassphraseProvider = FutureProvider<String?>((ref) {
  return ref.watch(appSettingsDaoProvider).getValue(_passphraseKey);
});

class BackupSettingsSection extends ConsumerStatefulWidget {
  const BackupSettingsSection({super.key});

  @override
  ConsumerState<BackupSettingsSection> createState() =>
      _BackupSettingsSectionState();
}

class _BackupSettingsSectionState
    extends ConsumerState<BackupSettingsSection> {
  final _ctrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscure = true;
  bool _loaded = false;

  @override
  void dispose() {
    _ctrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final pass = _ctrl.text.trim();
    if (pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passphrase cannot be empty')),
      );
      return;
    }
    if (pass != _confirmCtrl.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passphrases do not match')),
      );
      return;
    }

    await ref.read(appSettingsDaoProvider).setValue(_passphraseKey, pass);
    ref.invalidate(backupPassphraseProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup passphrase saved')),
      );
    }
  }

  Future<void> _clear() async {
    await ref.read(appSettingsDaoProvider).deleteKey(_passphraseKey);
    ref.invalidate(backupPassphraseProvider);
    _ctrl.clear();
    _confirmCtrl.clear();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backup passphrase removed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passphraseAsync = ref.watch(backupPassphraseProvider);

    return passphraseAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (stored) {
        // Seed controller once with stored value
        if (!_loaded) {
          _loaded = true;
          if (stored != null) {
            _ctrl.text = stored;
            _confirmCtrl.text = stored;
          }
        }

        final hasStored = stored != null && stored.isNotEmpty;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Backup Encryption',
                    style: theme.textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  hasStored
                      ? 'Passphrase is set. Backups will use it automatically.'
                      : 'Set a passphrase so you don\'t have to enter it every backup.',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _ctrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Passphrase',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _obscure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscure = !_obscure),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _confirmCtrl,
                  obscureText: _obscure,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Passphrase',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (hasStored)
                      TextButton(
                        onPressed: _clear,
                        child: const Text('Remove'),
                      ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
