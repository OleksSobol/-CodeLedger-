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

class DriveSignedInNotifier extends Notifier<bool> {
  @override
  bool build() => false;
  void set(bool v) => state = v;
}

/// Tracks the Drive sign-in state.
final driveSignedInProvider =
    NotifierProvider<DriveSignedInNotifier, bool>(DriveSignedInNotifier.new);

class DriveEmailNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void set(String? v) => state = v;
}

/// Tracks the signed-in email.
final driveEmailProvider =
    NotifierProvider<DriveEmailNotifier, String?>(DriveEmailNotifier.new);

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

class BackupUiStateNotifier extends Notifier<BackupUiState> {
  @override
  BackupUiState build() => const BackupIdle();
  void set(BackupUiState v) => state = v;
}

final backupUiStateProvider =
    NotifierProvider<BackupUiStateNotifier, BackupUiState>(
        BackupUiStateNotifier.new);
