import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../application/drive_backup_service.dart';
import '../providers/backup_providers.dart';

class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  bool _isWorking = false;
  String? _statusMessage;

  @override
  void initState() {
    super.initState();
    // Try silent sign-in on page load
    _trySilentSignIn();
  }

  Future<void> _trySilentSignIn() async {
    final drive = ref.read(driveBackupServiceProvider);
    final email = await drive.trySilentSignIn();
    if (email != null && mounted) {
      ref.read(driveSignedInProvider.notifier).state = true;
      ref.read(driveEmailProvider.notifier).state = email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSignedIn = ref.watch(driveSignedInProvider);
    final email = ref.watch(driveEmailProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Backup & Restore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status message
          if (_statusMessage != null)
            Card(
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    if (_isWorking)
                      const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    Expanded(child: Text(_statusMessage!)),
                  ],
                ),
              ),
            ),
          if (_statusMessage != null) const SizedBox(height: 16),

          // -- Local Backup Section --
          Text('Local Backup', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.backup),
                  title: const Text('Create Backup'),
                  subtitle:
                      const Text('Encrypt and save database to a file'),
                  trailing: _isWorking
                      ? null
                      : const Icon(Icons.chevron_right),
                  onTap: _isWorking ? null : _createLocalBackup,
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text('Restore from File'),
                  subtitle:
                      const Text('Import an encrypted backup file'),
                  trailing: _isWorking
                      ? null
                      : const Icon(Icons.chevron_right),
                  onTap: _isWorking ? null : _restoreLocalBackup,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // -- Google Drive Section --
          Text('Google Drive', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.cloud),
                  title: isSignedIn
                      ? Text('Signed in as $email')
                      : const Text('Sign in to Google Drive'),
                  subtitle: isSignedIn
                      ? null
                      : const Text(
                          'Back up your data to the cloud'),
                  trailing: isSignedIn
                      ? TextButton(
                          onPressed: _isWorking ? null : _signOut,
                          child: const Text('Sign Out'),
                        )
                      : null,
                  onTap: isSignedIn || _isWorking
                      ? null
                      : _signInToDrive,
                ),
                if (isSignedIn) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_upload),
                    title: const Text('Backup to Drive'),
                    subtitle: const Text(
                        'Encrypt and upload to /CodeLedger/'),
                    trailing: _isWorking
                        ? null
                        : const Icon(Icons.chevron_right),
                    onTap: _isWorking ? null : _backupToDrive,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_download),
                    title: const Text('Restore from Drive'),
                    subtitle: const Text(
                        'Download and decrypt a backup'),
                    trailing: _isWorking
                        ? null
                        : const Icon(Icons.chevron_right),
                    onTap: _isWorking ? null : _restoreFromDrive,
                  ),
                ],
              ],
            ),
          ),

          // -- Drive Backups List --
          if (isSignedIn) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                Text('Drive Backups',
                    style: theme.textTheme.titleMedium),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _isWorking
                      ? null
                      : () => ref.invalidate(driveBackupsProvider),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _DriveBackupsList(
              onRestore: _isWorking ? null : _restoreFromDriveEntry,
              onDelete: _isWorking ? null : _deleteDriveBackup,
            ),
          ],
        ],
      ),
    );
  }

  // -- Actions --

  Future<void> _createLocalBackup() async {
    final passphrase = await _askPassphrase('Create Backup');
    if (passphrase == null) return;

    _setWorking(true, 'Creating encrypted backup...');
    try {
      final backup = ref.read(backupServiceProvider);
      final file = await backup.createBackup(passphrase);

      // Share the file so user can save it wherever
      await SharePlus.instance.share(
        ShareParams(files: [XFile(file.path)]),
      );

      _setWorking(false, 'Backup created successfully');
    } catch (e) {
      _setWorking(false, 'Backup failed: $e');
    }
  }

  Future<void> _restoreLocalBackup() async {
    // Show warning dialog
    final confirmed = await _confirmRestore();
    if (!confirmed) return;

    final passphrase = await _askPassphrase('Restore Backup');
    if (passphrase == null) return;

    _setWorking(true, 'Restoring from backup...');
    try {
      // For local restore, user needs to pick a file.
      // On mobile we'd use file_picker, but for now show instructions.
      if (mounted) {
        _setWorking(false, null);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Place your .enc backup file in the app temp directory, '
              'then use Drive restore. Local file picker coming soon.',
            ),
          ),
        );
      }
    } catch (e) {
      _setWorking(false, 'Restore failed: $e');
    }
  }

  Future<void> _signInToDrive() async {
    _setWorking(true, 'Signing in to Google...');
    try {
      final drive = ref.read(driveBackupServiceProvider);
      final email = await drive.signIn();
      if (email != null) {
        ref.read(driveSignedInProvider.notifier).state = true;
        ref.read(driveEmailProvider.notifier).state = email;
        ref.invalidate(driveBackupsProvider);
        _setWorking(false, 'Signed in as $email');
      } else {
        _setWorking(false, 'Sign-in cancelled');
      }
    } catch (e) {
      _setWorking(false, 'Sign-in failed: $e');
    }
  }

  Future<void> _signOut() async {
    final drive = ref.read(driveBackupServiceProvider);
    await drive.signOut();
    ref.read(driveSignedInProvider.notifier).state = false;
    ref.read(driveEmailProvider.notifier).state = null;
    setState(() => _statusMessage = null);
  }

  Future<void> _backupToDrive() async {
    final passphrase = await _askPassphrase('Backup to Drive');
    if (passphrase == null) return;

    _setWorking(true, 'Creating encrypted backup...');
    try {
      final backup = ref.read(backupServiceProvider);
      final file = await backup.createBackup(passphrase);

      _setWorking(true, 'Uploading to Google Drive...');
      final drive = ref.read(driveBackupServiceProvider);
      await drive.uploadBackup(file);

      // Clean up temp file
      await file.delete();

      ref.invalidate(driveBackupsProvider);
      _setWorking(false, 'Backup uploaded to Drive successfully');
    } catch (e) {
      _setWorking(false, 'Drive backup failed: $e');
    }
  }

  Future<void> _restoreFromDrive() async {
    // Show drive backups picker
    final drive = ref.read(driveBackupServiceProvider);
    final backups = await drive.listBackups();

    if (backups.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No backups found on Drive')),
        );
      }
      return;
    }

    // Let user pick from list
    if (!mounted) return;
    final selected = await showDialog<DriveBackupEntry>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Select Backup'),
        children: backups.map((b) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, b),
            child: ListTile(
              title: Text(b.name),
              subtitle: Text(
                '${b.formattedSize} - ${b.createdAt != null ? DateFormat.yMMMd().add_jm().format(b.createdAt!) : "Unknown date"}',
              ),
            ),
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      await _restoreFromDriveEntry(selected);
    }
  }

  Future<void> _restoreFromDriveEntry(DriveBackupEntry entry) async {
    final confirmed = await _confirmRestore();
    if (!confirmed) return;

    final passphrase = await _askPassphrase('Restore Backup');
    if (passphrase == null) return;

    _setWorking(true, 'Downloading backup from Drive...');
    try {
      final drive = ref.read(driveBackupServiceProvider);
      final file = await drive.downloadBackup(entry.id, entry.name);

      _setWorking(true, 'Decrypting and restoring...');
      final backup = ref.read(backupServiceProvider);
      await backup.restoreBackup(file, passphrase);

      // Clean up
      await file.delete();

      _setWorking(false, 'Restore complete! Please restart the app.');
    } catch (e) {
      _setWorking(false, 'Restore failed: $e');
    }
  }

  Future<void> _deleteDriveBackup(DriveBackupEntry entry) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Backup?'),
        content: Text('Delete "${entry.name}" from Google Drive?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    _setWorking(true, 'Deleting backup...');
    try {
      final drive = ref.read(driveBackupServiceProvider);
      await drive.deleteBackup(entry.id);
      ref.invalidate(driveBackupsProvider);
      _setWorking(false, 'Backup deleted');
    } catch (e) {
      _setWorking(false, 'Delete failed: $e');
    }
  }

  // -- Helpers --

  void _setWorking(bool working, String? message) {
    if (!mounted) return;
    setState(() {
      _isWorking = working;
      _statusMessage = message;
    });
  }

  Future<String?> _askPassphrase(String title) async {
    final controller = TextEditingController();
    final confirmController = TextEditingController();
    final isCreate = title.contains('Create') || title.contains('Backup');

    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter an encryption passphrase. You will need this '
              'to restore the backup.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Passphrase',
                border: OutlineInputBorder(),
              ),
            ),
            if (isCreate) ...[
              const SizedBox(height: 8),
              TextField(
                controller: confirmController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Passphrase',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final pass = controller.text.trim();
              if (pass.isEmpty) return;
              if (isCreate && pass != confirmController.text.trim()) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(
                      content: Text('Passphrases do not match')),
                );
                return;
              }
              Navigator.pop(ctx, pass);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmRestore() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore Backup?'),
        content: const Text(
          'This will replace ALL current data with the backup. '
          'This cannot be undone. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    return result == true;
  }
}

/// Displays the list of backups on Google Drive.
class _DriveBackupsList extends ConsumerWidget {
  final void Function(DriveBackupEntry)? onRestore;
  final void Function(DriveBackupEntry)? onDelete;

  const _DriveBackupsList({this.onRestore, this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupsAsync = ref.watch(driveBackupsProvider);

    return backupsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error loading backups: $e'),
        ),
      ),
      data: (backups) {
        if (backups.isEmpty) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('No backups found on Google Drive'),
            ),
          );
        }

        return Card(
          child: Column(
            children: backups.map((b) {
              return ListTile(
                title: Text(b.name),
                subtitle: Text(
                  '${b.formattedSize}'
                  '${b.createdAt != null ? ' - ${DateFormat.yMMMd().add_jm().format(b.createdAt!)}' : ''}',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.restore),
                      tooltip: 'Restore',
                      onPressed:
                          onRestore != null ? () => onRestore!(b) : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: 'Delete',
                      onPressed:
                          onDelete != null ? () => onDelete!(b) : null,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
