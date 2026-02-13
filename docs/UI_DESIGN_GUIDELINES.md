# CodeLedger — App-Wide UI & Design Guidelines

**Stack:** Flutter 3.x, Material 3, Riverpod, GoRouter
**Seed color:** `0xFF1565C0` (Blue 800)
**Theme:** Light + Dark via `ColorScheme.fromSeed`

These are internal engineering standards. Every screen must follow them.

---

## 1. Layout System

### SafeArea Rules

| Context | Rule |
|---|---|
| Scaffold with AppBar | AppBar handles top inset automatically. **Do NOT wrap body in SafeArea.** |
| Scaffold with `bottomNavigationBar` | Flutter handles bottom inset automatically. **Do NOT add extra bottom padding.** |
| Scaffold **without** bottomNavigationBar | **Add bottom padding** to account for gesture nav / system buttons. |
| Fullscreen overlays (no Scaffold) | **Wrap in SafeArea.** |

### Bottom Inset Pattern (scrollable body, no bottomNavigationBar)

```dart
// DO — account for system nav bar
ListView(
  padding: EdgeInsets.fromLTRB(
    16, 16, 16, 16 + MediaQuery.of(context).padding.bottom,
  ),
  children: [...],
)
```

```dart
// DON'T — content hidden behind gesture bar
ListView(
  padding: const EdgeInsets.all(16),
  children: [...],
)
```

### Fixed Bottom Actions (e.g., wizard "Next" bar)

```dart
// DO — use bottomNavigationBar slot, wrap content in SafeArea
Scaffold(
  body: ...,
  bottomNavigationBar: SafeArea(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
      ),
      child: FilledButton(...),
    ),
  ),
)
```

```dart
// DON'T — put fixed buttons at bottom of a Column/Stack inside body
```

### Scrollable vs Fixed Layout

- **Scrollable (default):** Use `ListView` or `SingleChildScrollView`. Always include bottom padding.
- **Fixed:** Use `Column` with `Expanded` for the flexible section. Put fixed actions in `bottomNavigationBar`.

---

## 2. Spacing System

### Scale

| Token | Value | Usage |
|---|---|---|
| `xs` | 4 | Tight inline spacing, between icon and label |
| `sm` | 8 | Between related items in a group |
| `md` | 16 | Standard padding, section internal padding |
| `lg` | 24 | Between sections |
| `xl` | 32 | Major section breaks, bottom of page |

### Constants

```dart
abstract class Spacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}
```

### Vertical Rhythm

- **Within a card:** `md` (16) padding on all sides.
- **Between cards:** `sm` (8) vertical gap.
- **Between sections:** `lg` (24) vertical gap.
- **Section header to first item:** `sm` (8).
- **Page bottom padding:** `xl` (32) + system inset.

---

## 3. Typography System

### Material 3 Text Styles — Usage Map

| Element | Style | Weight Override |
|---|---|---|
| Page title (in AppBar) | `titleLarge` | Default |
| Section header | `titleMedium` | `FontWeight.bold` |
| Card title | `titleSmall` | `FontWeight.bold` |
| Body text | `bodyMedium` | Default |
| Secondary/caption text | `bodySmall` | Default |
| Button labels | `labelLarge` | Default (automatic) |
| Chip/badge text | `labelMedium` | Default |
| Large stat/number | `headlineMedium` | `FontWeight.bold` |

### Rules

- **DO** use `Theme.of(context).textTheme.xxx`.
- **DON'T** use arbitrary `fontSize` or `TextStyle(fontSize: 14)`.
- **DO** use `.copyWith(fontWeight: ...)` when you need emphasis.
- **DON'T** use more than 2 font weights per card (regular + bold).

---

## 4. Button & Action Hierarchy

### Material 3 Button Types

| Priority | Widget | Usage |
|---|---|---|
| **Primary** | `FilledButton` / `FilledButton.icon` | Main action per screen (1 max) |
| **Secondary** | `OutlinedButton` / `OutlinedButton.icon` | Alternative actions |
| **Tertiary** | `TextButton` | Cancel, dismiss, minor links |
| **Destructive** | `TextButton` with `colorScheme.error` | Delete, discard |
| **FAB** | `FloatingActionButton.extended` | Global "create new" action |

### Rules

- **Max 1 primary (filled) button per visible screen area.**
- Destructive actions always require confirmation.
- Icon buttons in app bar: max 3.
- Button in a loading state: show inline `SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))` replacing the icon, keep the label as "Loading...".
- Disable only the button that triggered the action, not the entire screen.

---

## 5. Async & Loading States

### Patterns

| Scenario | Pattern |
|---|---|
| Initial page data load | `AsyncValue.when(loading: ..., error: ..., data: ...)` |
| Button triggers async action | Inline spinner in button, button disabled |
| Pull-to-refresh | `RefreshIndicator` wrapping `ListView` |
| Full-screen blocking operation | `Stack` with semi-transparent overlay + centered spinner (rare — only for DB restore) |

### Loading Widget

```dart
// Inline button spinner
FilledButton.icon(
  onPressed: isLoading ? null : _doAction,
  icon: isLoading
      ? const SizedBox(
          width: 20, height: 20,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : const Icon(Icons.cloud_upload),
  label: Text(isLoading ? 'Uploading...' : 'Upload'),
)
```

### Error Display

- **Page-level errors:** `Center(child: Column(icon, message, retry button))`.
- **Action errors:** `SnackBar` with error message.
- **Form errors:** Inline field validation.

### Success Feedback

- **Lightweight:** `SnackBar` with message (auto-dismiss 3s).
- **Navigation:** Navigate away (e.g., after create, go to list).
- **DON'T** show success dialogs that require dismissal.

---

## 6. Dialog & Bottom Sheet Standards

### When to Use What

| Interaction | Widget |
|---|---|
| Destructive confirmation (delete, overwrite) | `showDialog` with `AlertDialog` |
| Input collection (passphrase, form) | `showModalBottomSheet` |
| Picker (select from list) | `showModalBottomSheet` with `ListView` |
| Quick message | `SnackBar` |

### Destructive Confirmation Pattern

```dart
Future<bool> confirmDestructive(BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Delete',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(ctx).colorScheme.error,
          ),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result == true;
}
```

### Bottom Sheet Input Pattern

```dart
Future<String?> askPassphrase(BuildContext context) {
  final controller = TextEditingController();
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(
        24, 24, 24, 24 + MediaQuery.of(ctx).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Encryption Passphrase',
              style: Theme.of(ctx).textTheme.titleMedium),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Passphrase',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              final pass = controller.text.trim();
              if (pass.isNotEmpty) Navigator.pop(ctx, pass);
            },
            child: const Text('Continue'),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
```

---

## 7. Theming

### Rules

- **DO** use `theme.colorScheme.xxx` for all colors.
- **DON'T** hardcode `Colors.blue`, `Color(0xFF...)`, etc.
- **DO** use `theme.colorScheme.surface` for card/sheet backgrounds.
- **DO** use `theme.colorScheme.outline` for borders and dividers.
- **DO** use `theme.colorScheme.error` for destructive actions and error text.
- **DO** use `theme.colorScheme.tertiary` for accent/info elements.
- **DO** use `theme.colorScheme.primaryContainer` for highlighted/selected states.

### Allowed Color References

```dart
// DO
theme.colorScheme.primary
theme.colorScheme.onPrimary
theme.colorScheme.primaryContainer
theme.colorScheme.onPrimaryContainer
theme.colorScheme.surface
theme.colorScheme.onSurface
theme.colorScheme.surfaceContainerHighest  // elevated cards
theme.colorScheme.outline                  // borders
theme.colorScheme.outlineVariant           // subtle borders
theme.colorScheme.error
theme.colorScheme.tertiary                 // accent

// DON'T
Colors.grey
Colors.blue
Color(0xFFxxxxxx)
.withOpacity(0.5)  // use .withValues(alpha: 0.5) instead
```

---

## 8. Component Structure

### Folder Pattern (per feature)

```
features/
  backup/
    application/         # Services, business logic
    presentation/
      pages/             # Full-screen widgets (one per route)
      widgets/           # Reusable pieces within this feature
      providers/         # Riverpod providers
```

### Reusable Wrappers

#### AppPageScaffold — Standard scrollable page

```dart
/// Scrollable page body with correct bottom inset handling.
class AppPageBody extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const AppPageBody({super.key, required this.children, this.padding});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return ListView(
      padding: padding ??
          EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      children: children,
    );
  }
}
```

#### AppSectionCard — Grouped actions card

```dart
class AppSectionCard extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const AppSectionCard({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ],
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }
}
```

---

## 9. Empty States

### Pattern

```dart
Center(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.xxx_outlined, size: 64, color: theme.colorScheme.outline),
      const SizedBox(height: 16),
      Text('No items yet', style: theme.textTheme.titleMedium),
      const SizedBox(height: 8),
      Text('Description of what to do', style: theme.textTheme.bodySmall),
    ],
  ),
)
```

### Positive Empty States (dashboard cards)

When "empty" is a good thing (e.g., no overdue invoices), show a positive message with a check icon using `theme.colorScheme.tertiary`.

---

## 10. State Modeling for Async Operations

### DON'T: Raw booleans

```dart
// Bad
bool _isWorking = false;
String? _statusMessage;
```

### DO: Sealed class or enum-based state

```dart
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
```

Or use `AsyncValue<String?>` from Riverpod directly when modeling a single async operation.

---

## 11. Global Page Scaffold

Centralize Scaffold + SafeArea + bottom inset logic so no screen forgets it.

```dart
class AppPageScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomBar;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppPageScaffold({
    super.key,
    this.title,
    required this.body,
    this.bottomBar,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text(title!), actions: actions)
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomBar != null
          ? SafeArea(child: bottomBar!)
          : null,
    );
  }
}
```

Every screen should use `AppPageScaffold` or `Scaffold` with the same patterns. No one forgets SafeArea. No one forgets bottom inset logic.

---

## 12. Elevation & Surface Rules

Material 3 is surface-driven, not shadow-driven.

| Element | Surface | Elevation |
|---|---|---|
| Page background | `colorScheme.surface` | 0 |
| Standard card | Default `Card` | 0–1 |
| Elevated card (selected, highlighted) | `colorScheme.surfaceContainerHighest` | 0 |
| Bottom sheet | `colorScheme.surfaceContainerLow` | Default |
| Dialog | Default `AlertDialog` | Default |
| AppBar | `colorScheme.surface` | 0 (scrolledUnder handled by M3) |

### Rules

- **DO** use tonal contrast (surface containers) instead of shadows for hierarchy.
- **DON'T** use elevation > 2 on cards. Heavy shadows look dated.
- **DO** use `Card` with default theme (elevation 1, as defined in `AppTheme`).
- **DON'T** manually set `Card(elevation: 4)` or add `BoxShadow`.
- Prefer flat, tonal design. Let color do the lifting, not depth.

---

## 13. Motion & Animation Rules

| Context | Rule |
|---|---|
| Page transitions | GoRouter defaults. No custom hero animations unless meaningful. |
| Bottom sheets | Default Material animation. Don't customize duration. |
| Dialogs | Default Material animation. |
| List item appear | No staggered animations. Items render immediately. |
| Button state changes | Default Material ink/ripple. |
| Loading indicators | `CircularProgressIndicator` — no custom spinners. |

### Rules

- **DON'T** add custom animation durations > 300ms.
- **DON'T** add entrance animations to list items (looks slow on long lists).
- **DO** use `AnimatedSwitcher` when swapping widget content in-place (e.g., idle → loading → done).
- **DO** let Material 3 handle transitions. Custom motion adds maintenance cost with little UX gain.

---

## 14. Accessibility

### Minimum Requirements

| Rule | Detail |
|---|---|
| Tap targets | Minimum 48x48 logical pixels. `ListTile`, `IconButton`, `FilledButton` meet this by default. |
| Text scaling | Respect `MediaQuery.textScaleFactor`. Don't use fixed heights that clip scaled text. |
| Color alone | Never rely on color alone to communicate meaning. Pair with icon, text, or shape. |
| Semantic labels | All `Icon` used as buttons must have `tooltip` or `semanticLabel`. |
| Contrast | Use `colorScheme` pairs (`primary`/`onPrimary`, etc.) — they guarantee contrast. |

### Rules

- **DO** set `tooltip` on every `IconButton`.
- **DO** use `Semantics` widget for custom widgets that convey meaning.
- **DON'T** hardcode widget heights that break when text scales to 1.5x.
- **DON'T** use tiny tap targets (< 48px) for interactive elements.

---

## 15. Design Tokens

### Current Tokens

```dart
// Spacing (Section 2)
abstract class Spacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}
```

### Future Tokens (add when needed)

```dart
// Border radius
abstract class Radii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double full = 999; // pill shape
}

// Durations
abstract class Durations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
}

// Elevation
abstract class Elevations {
  static const double none = 0;
  static const double low = 1;
  static const double medium = 2;
}
```

Use these instead of magic numbers. When a value appears in 3+ places, extract it to a token.

---

## Checklist (apply to every screen)

- [ ] Bottom content not hidden behind system nav bar
- [ ] No hardcoded colors
- [ ] Text styles from `theme.textTheme`
- [ ] Max 1 `FilledButton` per visible area
- [ ] Destructive actions have confirmation dialog
- [ ] Loading states use inline spinners (not blocking overlays)
- [ ] Cards use `theme.cardTheme` (no custom margins unless necessary)
- [ ] Dialogs for confirmations, bottom sheets for input
- [ ] Empty states are informative (icon + title + subtitle)
- [ ] `SafeArea` only where Scaffold doesn't handle it
- [ ] Tap targets >= 48x48
- [ ] All `IconButton`s have `tooltip`
- [ ] No custom shadows or elevation > 2
- [ ] No custom animation durations > 300ms
- [ ] Color never used as sole indicator of meaning
