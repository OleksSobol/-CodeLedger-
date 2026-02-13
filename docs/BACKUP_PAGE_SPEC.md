# Backup & Restore — Page Redesign Spec

**Reference:** Follow [UI_DESIGN_GUIDELINES.md](UI_DESIGN_GUIDELINES.md) for all layout, spacing, button, and theming rules.

---

## Current Problems

1. **Raw boolean state** (`_isWorking`, `_statusMessage`) — not scalable, no type safety.
2. **Local restore is a stub** — shows a SnackBar saying "coming soon".
3. **All buttons disabled during any operation** — should only disable relevant ones.
4. **Passphrase input uses `showDialog`** — should use `showModalBottomSheet` per guidelines.
5. **Drive backup list uses `SimpleDialog`** for picker — should be inline or bottom sheet.
6. **No visual hierarchy** — all actions look the same (ListTile with chevron).
7. **Status banner is a card at top** — clutters the page, should be SnackBar for transient feedback.
8. **No empty state for "not signed in" Drive section** — just a sign-in ListTile.
9. **Bottom content clips behind system nav bar** — needs bottom padding.

---

## State Architecture

### Sealed UI State

```dart
sealed class BackupUiState {
  const BackupUiState();
}

class BackupIdle extends BackupUiState {
  const BackupIdle();
}

class BackupWorking extends BackupUiState {
  final String message; // "Encrypting...", "Uploading...", "Downloading..."
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
```

### Riverpod Provider

```dart
final backupUiStateProvider = StateProvider<BackupUiState>(
  (_) => const BackupIdle(),
);
```

### Drive State (existing — keep as-is)

```dart
final driveSignedInProvider = StateProvider<bool>((_) => false);
final driveEmailProvider = StateProvider<String?>((_) => null);
final driveBackupsProvider = FutureProvider<List<DriveBackupEntry>>(...);
```

---

## Widget Tree Structure

```
Scaffold
  AppBar: "Backup & Restore"
  body: ListView (with bottom inset padding)
    ├── _LocalBackupSection
    │   ├── Section header: "Local"
    │   └── Card
    │       ├── "Create & Share Backup" — FilledButton.tonal.icon
    │       └── "Restore from File" — OutlinedButton.icon
    │
    ├── SizedBox(height: 24)
    │
    ├── _GoogleDriveSection
    │   ├── Section header: "Google Drive" + sign-in status chip
    │   ├── [Not signed in] → Card with sign-in prompt + FilledButton
    │   └── [Signed in] → Card
    │       ├── Account row (avatar icon + email + Sign Out text button)
    │       ├── Divider
    │       ├── "Backup to Drive" — FilledButton.icon (primary action)
    │       ├── SizedBox(8)
    │       └── "Restore from Drive" — OutlinedButton.icon
    │
    ├── SizedBox(height: 24)
    │
    └── [Signed in] _DriveBackupsList
        ├── Section header: "Your Backups" + refresh icon
        ├── [Empty] Card with "No backups yet" empty state
        └── [Has data] Card with backup entries
            └── Each: name, date, size, trailing: restore + delete icons
```

---

## Interaction Flows

### Backup to Drive

1. User taps "Backup to Drive"
2. `showModalBottomSheet` — passphrase input (+ confirm field)
3. User enters passphrase, taps "Continue"
4. Button shows inline spinner: "Encrypting..."
5. State updates: "Uploading to Drive..."
6. On success: `SnackBar("Backup uploaded")`, refresh backup list
7. On error: `SnackBar("Upload failed: ...")`, return to idle

### Restore from Drive

1. User taps "Restore from Drive"
2. If backups not loaded yet, show inline spinner
3. `showModalBottomSheet` — list of backups (name, date, size) as selectable tiles
4. User selects a backup
5. `showDialog` — destructive confirmation: "This will replace all current data"
6. `showModalBottomSheet` — passphrase input
7. User enters passphrase, taps "Restore"
8. Full-screen overlay with spinner: "Downloading...", "Decrypting...", "Restoring..."
9. On success: dialog with "Restore complete. Please restart the app." + "OK" button
10. On error: `SnackBar("Restore failed: ...")`

### Create & Share Local Backup

1. User taps "Create & Share Backup"
2. `showModalBottomSheet` — passphrase (+ confirm)
3. Button spinner: "Encrypting..."
4. Share sheet opens with encrypted `.enc` file
5. On success: `SnackBar("Backup created")`

### Restore from Local File

1. User taps "Restore from File"
2. File picker opens (add `file_picker` package)
3. `showDialog` — destructive confirmation
4. `showModalBottomSheet` — passphrase input
5. Full-screen overlay: "Decrypting...", "Restoring..."
6. On success: dialog "Restore complete. Please restart."

---

## Microcopy

| Current | Improved |
|---|---|
| "Encrypt and save database to a file" | "Create an encrypted copy of your data" |
| "Import an encrypted backup file" | "Restore from a backup file on this device" |
| "Encrypt and upload to /CodeLedger/" | "Encrypt and save to your Google Drive" |
| "Download and decrypt a backup" | "Restore from a Google Drive backup" |
| "Enter an encryption passphrase. You will need this to restore the backup." | "Choose a passphrase to protect this backup. You'll need it to restore." |
| "This will replace ALL current data with the backup. This cannot be undone." | "This will replace all your current data with this backup. This can't be undone." |
| "Restore complete! Please restart the app." | "Restore complete. Restart the app to load your data." |
| "No backups found on Google Drive" | "No backups yet" (with cloud_off icon) |

---

## Error Handling

| Error | Handling |
|---|---|
| Wrong passphrase (decryption fails) | `SnackBar("Wrong passphrase or corrupted backup")` |
| Network error during upload/download | `SnackBar("Network error. Check your connection and try again.")` |
| Drive API error | `SnackBar("Google Drive error: ...")` |
| File picker cancelled | Silent — return to idle |
| Sign-in cancelled | `SnackBar("Sign-in cancelled")` |
| Sign-in config error | Inline error card with setup instructions |

---

## Visual Design Notes

- **Local section** uses `FilledTonalButton` (not full `FilledButton`) — secondary priority.
- **Drive "Backup" button** is `FilledButton` — primary action on page.
- **Drive "Restore" button** is `OutlinedButton` — secondary, destructive context.
- **Sign-in card** when not signed in: prominent, centered Google icon, single `FilledButton("Sign in with Google")`.
- **Account row** when signed in: `Icon(Icons.account_circle)` + email text + `TextButton("Sign out")`.
- **Backup entries**: `ListTile` with `leading: Icon(Icons.lock_outline)`, title = filename, subtitle = "date - size", trailing = `PopupMenuButton` with Restore/Delete options (instead of two icon buttons).
- **Section headers**: `titleMedium` with `FontWeight.bold`, left-aligned.
- **Bottom padding**: `16 + MediaQuery.of(context).padding.bottom`.

---

## Dependencies to Add

```yaml
file_picker: ^8.0.0  # For local file restore
```

---

## Summary of Changes from Current Implementation

1. Replace `_isWorking` / `_statusMessage` with sealed `BackupUiState` via `StateProvider`.
2. Replace `showDialog` for passphrase with `showModalBottomSheet`.
3. Replace `SimpleDialog` backup picker with `showModalBottomSheet` list.
4. Add `file_picker` for local restore (currently a stub).
5. Use `SnackBar` for transient feedback instead of persistent status card.
6. Use button hierarchy: `FilledButton` for primary, `OutlinedButton` for secondary, `FilledTonalButton` for local actions.
7. Add proper empty state for Drive backups list.
8. Add bottom inset padding to `ListView`.
9. Use `PopupMenuButton` on backup entries instead of two bare icon buttons.
10. Improve microcopy throughout.
