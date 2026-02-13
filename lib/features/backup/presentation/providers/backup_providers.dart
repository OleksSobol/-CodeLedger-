import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/encryption/encryption_service.dart';
import '../../application/backup_service.dart';
import '../../application/drive_backup_service.dart';

// -- Services --

final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  return EncryptionService();
});

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(ref.watch(encryptionServiceProvider));
});

final driveBackupServiceProvider = Provider<DriveBackupService>((ref) {
  return DriveBackupService();
});

// -- Drive state --

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

// -- Sealed UI state --

sealed class BackupUiState {
  const BackupUiState();
}

class BackupIdle extends BackupUiState {
  const BackupIdle();
}

class BackupWorking extends BackupUiState {
  final String message;
  const BackupWorking(this.message);
}

class BackupSuccess extends BackupUiState {
  final String message;
  const BackupSuccess(this.message);
}

class BackupError extends BackupUiState {
  final String message;
  const BackupError(this.message);
}

final backupUiStateProvider = StateProvider<BackupUiState>(
  (_) => const BackupIdle(),
);
