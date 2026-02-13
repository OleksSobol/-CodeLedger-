import 'package:flutter/material.dart';
import 'spacing.dart';

/// Bottom sheet for passphrase input.
///
/// When [requireConfirmation] is true, shows a second field to confirm.
/// See `docs/UI_DESIGN_GUIDELINES.md` Section 6.
Future<String?> askPassphrase(
  BuildContext context, {
  bool requireConfirmation = false,
}) {
  final controller = TextEditingController();
  final confirmController = TextEditingController();

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => Padding(
      padding: EdgeInsets.fromLTRB(
        Spacing.lg,
        Spacing.lg,
        Spacing.lg,
        Spacing.lg + MediaQuery.of(ctx).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Encryption Passphrase',
            style: Theme.of(ctx).textTheme.titleMedium,
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            requireConfirmation
                ? "Choose a passphrase to protect this backup. You'll need it to restore."
                : 'Enter the passphrase used when creating this backup.',
            style: Theme.of(ctx).textTheme.bodySmall,
          ),
          const SizedBox(height: Spacing.md),
          TextField(
            controller: controller,
            obscureText: true,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Passphrase',
              border: OutlineInputBorder(),
            ),
          ),
          if (requireConfirmation) ...[
            const SizedBox(height: Spacing.sm),
            TextField(
              controller: confirmController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Passphrase',
                border: OutlineInputBorder(),
              ),
            ),
          ],
          const SizedBox(height: Spacing.md),
          FilledButton(
            onPressed: () {
              final pass = controller.text.trim();
              if (pass.isEmpty) return;
              if (requireConfirmation &&
                  pass != confirmController.text.trim()) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Passphrases do not match')),
                );
                return;
              }
              Navigator.pop(ctx, pass);
            },
            child: const Text('Continue'),
          ),
          const SizedBox(height: Spacing.sm),
        ],
      ),
    ),
  );
}
