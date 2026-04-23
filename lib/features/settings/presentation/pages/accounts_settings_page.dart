import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../github/presentation/providers/github_provider.dart';

class AccountsSettingsPage extends ConsumerStatefulWidget {
  const AccountsSettingsPage({super.key});

  @override
  ConsumerState<AccountsSettingsPage> createState() =>
      _AccountsSettingsPageState();
}

class _AccountsSettingsPageState extends ConsumerState<AccountsSettingsPage> {
  late final TextEditingController _patCtrl;
  late final TextEditingController _usernameCtrl;
  bool _obscurePat = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _patCtrl = TextEditingController();
    _usernameCtrl = TextEditingController();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final dao = ref.read(appSettingsDaoProvider);
    final pat = await dao.getValue('github_pat');
    final username = await dao.getValue('github_username');
    if (mounted) {
      _patCtrl.text = pat ?? '';
      _usernameCtrl.text = username ?? '';
    }
  }

  @override
  void dispose() {
    _patCtrl.dispose();
    _usernameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final dao = ref.read(appSettingsDaoProvider);
      final pat = _patCtrl.text.trim();
      final username = _usernameCtrl.text.trim();

      if (pat.isEmpty) {
        await dao.deleteKey('github_pat');
      } else {
        await dao.setValue('github_pat', pat);
      }

      if (username.isEmpty) {
        await dao.deleteKey('github_username');
      } else {
        await dao.setValue('github_username', username);
      }

      ref.invalidate(githubPatProvider);
      ref.invalidate(githubUsernameProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Accounts')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // GitHub section
          Text(
            'GitHub',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Connect your GitHub account to automatically pull issue references '
            'from your commit history into time entries.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _usernameCtrl,
            decoration: const InputDecoration(
              labelText: 'GitHub Username',
              hintText: 'e.g. octocat',
              prefixIcon: Icon(Icons.person_outline),
            ),
            autocorrect: false,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _patCtrl,
            obscureText: _obscurePat,
            decoration: InputDecoration(
              labelText: 'Personal Access Token',
              hintText: 'ghp_...',
              prefixIcon: const Icon(Icons.key_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePat ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () =>
                    setState(() => _obscurePat = !_obscurePat),
              ),
            ),
            autocorrect: false,
          ),
          const SizedBox(height: 8),
          Text(
            'Generate a token at GitHub → Settings → Developer Settings → '
            'Personal access tokens. Required scopes: repo (read access).',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Text(
            'How it works',
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          _HowItWorksStep(
            number: '1',
            text:
                'Link a GitHub repo to each project (Client → Project → Edit).',
          ),
          _HowItWorksStep(
            number: '2',
            text:
                'Tap the sync button on the Time Tracking screen to pull issue '
                'references for the current date range.',
          ),
          _HowItWorksStep(
            number: '3',
            text:
                'Any branch named Issue-XXXX that had commits that day will '
                'have its issue number added to the matching time entry.',
          ),
        ],
      ),
    );
  }
}

class _HowItWorksStep extends StatelessWidget {
  final String number;
  final String text;

  const _HowItWorksStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              number,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
