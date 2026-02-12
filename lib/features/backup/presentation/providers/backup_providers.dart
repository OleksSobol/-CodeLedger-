import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/encryption/encryption_service.dart';
import '../../application/backup_service.dart';
import '../../application/drive_backup_service.dart';

final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  return EncryptionService();
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(encryptionServiceProvider));
});

final driveBackupServiceProvider = Provider<DriveBackupService>((ref) {
  return DriveBackupService();
});

/// Tracks the Drive sign-in state.
final driveSignedInProvider = StateProvider<bool>((ref) => false);

/// Tracks the signed-in email.
final driveEmailProvider = StateProvider<String?>((ref) => null);

/// Lists backups on Drive (refreshed manually).
final driveBackupsProvider =
    FutureProvider<List<DriveBackupEntry>>((ref) async {
  final drive = ref.watch(driveBackupServiceProvider);
  if (!drive.isSignedIn) return [];
  return drive.listBackups();
});
