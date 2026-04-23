import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/time_entry_dao.dart';
import '../../../../features/projects/presentation/providers/project_providers.dart';
import '../../../../features/time_tracking/presentation/providers/time_entry_providers.dart';
import '../../data/github_service.dart';

final githubPatProvider = FutureProvider<String?>((ref) {
  return ref.watch(appSettingsDaoProvider).getValue('github_pat');
});

final githubUsernameProvider = FutureProvider<String?>((ref) {
  return ref.watch(appSettingsDaoProvider).getValue('github_username');
});

final githubSyncNotifierProvider =
    AsyncNotifierProvider<GitHubSyncNotifier, void>(GitHubSyncNotifier.new);

class GitHubSyncNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<GitHubSyncResult> syncForDate(DateTime date) async {
    final dao = ref.read(appSettingsDaoProvider);
    final pat = await dao.getValue('github_pat');
    final username = await dao.getValue('github_username');

    if (pat == null || pat.isEmpty) {
      return GitHubSyncResult(
        error: 'GitHub PAT not configured. Go to Settings → Accounts.',
      );
    }
    if (username == null || username.isEmpty) {
      return GitHubSyncResult(
        error: 'GitHub username not configured. Go to Settings → Accounts.',
      );
    }

    final service = GitHubService(pat: pat, username: username);

    final allProjects = await ref.read(allActiveProjectsProvider.future);
    final linkedProjects = allProjects
        .where((p) => p.githubRepo != null && p.githubRepo!.isNotEmpty)
        .toList();

    if (linkedProjects.isEmpty) {
      return GitHubSyncResult(
        error:
            'No projects have a GitHub repo linked. Edit a project to add one.',
      );
    }

    final timeEntryDao = ref.read(timeEntryDaoProvider);
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final entries = await timeEntryDao.getAllEntries(from: dayStart, to: dayEnd);

    int updatedCount = 0;
    final errors = <String>[];

    for (final project in linkedProjects) {
      try {
        final issueRefs =
            await service.getIssueRefsForDate(project.githubRepo!, date);

        for (final issueRef in issueRefs) {
          // Prefer entries for this specific project, fall back to same client
          final projectEntries =
              entries.where((e) => e.projectId == project.id).toList();
          final clientEntries =
              entries.where((e) => e.clientId == project.clientId).toList();

          final candidates =
              projectEntries.isNotEmpty ? projectEntries : clientEntries;
          if (candidates.isEmpty) continue;

          // Pick the first entry that doesn't already have this ref
          final target = candidates.firstWhere(
            (e) => !(e.issueReference ?? '').contains(issueRef),
            orElse: () => candidates.first,
          );

          final existing = target.issueReference ?? '';
          if (existing.contains(issueRef)) continue;

          final newRef =
              existing.isEmpty ? issueRef : '$existing, $issueRef';

          await timeEntryDao.updateWithOverlapCheck(
            target.id,
            TimeEntriesCompanion(issueReference: Value(newRef)),
          );
          updatedCount++;
        }
      } catch (e) {
        errors.add('${project.githubRepo}: $e');
      }
    }

    return GitHubSyncResult(
      updatedCount: updatedCount,
      repoErrors: errors,
    );
  }
}

class GitHubSyncResult {
  final String? error;
  final int updatedCount;
  final List<String> repoErrors;

  GitHubSyncResult({
    this.error,
    this.updatedCount = 0,
    this.repoErrors = const [],
  });

  bool get hasError => error != null;
  bool get hasRepoErrors => repoErrors.isNotEmpty;

  String get summary {
    if (hasError) return error!;
    if (updatedCount == 0 && repoErrors.isEmpty) {
      return 'No new issue references found.';
    }
    final parts = <String>[];
    if (updatedCount > 0) {
      parts.add('Updated $updatedCount entr${updatedCount == 1 ? 'y' : 'ies'}.');
    }
    if (hasRepoErrors) {
      parts.add('${repoErrors.length} repo(s) failed.');
    }
    return parts.join(' ');
  }
}
