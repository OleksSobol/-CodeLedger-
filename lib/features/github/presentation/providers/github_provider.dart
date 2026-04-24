import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/database/app_database.dart';
import '../../../../features/clients/presentation/providers/client_providers.dart';
import '../../../../features/projects/presentation/providers/project_providers.dart';
import '../../../../features/time_tracking/presentation/providers/time_entry_providers.dart';
import '../../data/github_service.dart';

export '../../data/github_service.dart' show SyncLog, SyncLogLevel;

final githubPatProvider = FutureProvider<String?>((ref) {
  return ref.watch(appSettingsDaoProvider).getValue('github_pat');
});

final githubUsernameProvider = FutureProvider<String?>((ref) {
  return ref.watch(appSettingsDaoProvider).getValue('github_username');
});

final githubSyncNotifierProvider =
    AsyncNotifierProvider<GitHubSyncNotifier, void>(GitHubSyncNotifier.new);

/// One potential issue-ref → time-entry assignment found during a scan.
class SyncMatch {
  final String repo;
  final String projectName;
  final String clientName;
  final String issueRef;
  final TimeEntry entry;
  final String? existingRef;

  SyncMatch({
    required this.repo,
    required this.projectName,
    required this.clientName,
    required this.issueRef,
    required this.entry,
    this.existingRef,
  });

  /// What the issueReference field will become after applying.
  String get newRef {
    final existing = existingRef ?? '';
    return existing.isEmpty ? issueRef : '$existing, $issueRef';
  }
}

class GitHubConnectionTest {
  final String? authedAs;
  final String? patError;
  final Map<String, bool> repoResults;

  GitHubConnectionTest({
    this.authedAs,
    this.patError,
    this.repoResults = const {},
  });

  bool get patOk => patError == null && authedAs != null;
}

class GitHubSyncPreview {
  final List<SyncMatch> matches;
  final List<SyncLog> logs;
  final String? error;

  const GitHubSyncPreview({
    this.matches = const [],
    this.logs = const [],
    this.error,
  });

  bool get hasError => error != null;
}

class GitHubSyncNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Scans all linked repos for the date range and returns potential matches
  /// WITHOUT applying any changes. [onLog] is called live as each step runs.
  Future<GitHubSyncPreview> previewSync(
      DateTime start, DateTime end, {void Function(SyncLog)? onLog}) async {
    final dao = ref.read(appSettingsDaoProvider);
    final pat = await dao.getValue('github_pat');
    final username = await dao.getValue('github_username');

    void emitError(String msg) =>
        onLog?.call(SyncLog(msg, SyncLogLevel.error));

    if (pat == null || pat.isEmpty) {
      emitError('GitHub PAT not configured. Go to Settings → Accounts.');
      return const GitHubSyncPreview(
        error: 'GitHub PAT not configured. Go to Settings → Accounts.',
      );
    }
    if (username == null || username.isEmpty) {
      emitError('GitHub username not configured. Go to Settings → Accounts.');
      return const GitHubSyncPreview(
        error: 'GitHub username not configured. Go to Settings → Accounts.',
      );
    }

    final service = GitHubService(pat: pat, username: username, onLog: onLog);

    final allProjects = await ref.read(allActiveProjectsProvider.future);
    final linkedProjects = allProjects
        .where((p) => p.githubRepo != null && p.githubRepo!.isNotEmpty)
        .toList();

    if (linkedProjects.isEmpty) {
      emitError('No projects have a GitHub repo linked. Edit a project to add one.');
      return const GitHubSyncPreview(
        error:
            'No projects have a GitHub repo linked. Edit a project to add one.',
      );
    }

    final allClients = await ref.read(allClientsProvider.future);
    final clientById = {for (final c in allClients) c.id: c.name};

    service.logs.add(SyncLog(
      'Scanning ${linkedProjects.length} linked project(s) for '
      '${_fmtDate(start)} – ${_fmtDate(end.subtract(const Duration(days: 1)))}',
      SyncLogLevel.info,
    ));

    // Verify repo access first (normalize repo strings before use)
    final accessOk = <String, bool>{};
    for (final p in linkedProjects) {
      final normalized = GitHubService.normalizeRepo(p.githubRepo!);
      accessOk[normalized] = await service.verifyRepoAccess(normalized);
    }

    final timeEntryDao = ref.read(timeEntryDaoProvider);
    final matches = <SyncMatch>[];

    var day = DateTime(start.year, start.month, start.day);
    final endDay = DateTime(end.year, end.month, end.day);

    while (day.isBefore(endDay)) {
      final dayEnd = day.add(const Duration(days: 1));
      final entries =
          await timeEntryDao.getAllEntries(from: day, to: dayEnd);

      for (final project in linkedProjects) {
        final repo = GitHubService.normalizeRepo(project.githubRepo!);
        if (accessOk[repo] != true) continue;

        final issueRefs = await service.getIssueRefsForDate(repo, day);

        for (final issueRef in issueRefs) {
          final projectEntries =
              entries.where((e) => e.projectId == project.id).toList();
          final clientEntries =
              entries.where((e) => e.clientId == project.clientId).toList();
          final candidates =
              projectEntries.isNotEmpty ? projectEntries : clientEntries;
          if (candidates.isEmpty) continue;

          final target = candidates.firstWhere(
            (e) => !(e.issueReference ?? '').contains(issueRef),
            orElse: () => candidates.first,
          );

          if ((target.issueReference ?? '').contains(issueRef)) continue;

          // Deduplicate: don't add the same (issueRef, entryId) twice
          final alreadyQueued = matches.any(
            (m) => m.issueRef == issueRef && m.entry.id == target.id,
          );
          if (alreadyQueued) continue;

          matches.add(SyncMatch(
            repo: repo,
            projectName: project.name,
            clientName: clientById[project.clientId] ?? '',
            issueRef: issueRef,
            entry: target,
            existingRef: target.issueReference,
          ));
        }
      }

      day = dayEnd;
    }

    service.logs.add(SyncLog(
      'Scan complete — ${matches.length} match(es) found.',
      SyncLogLevel.info,
    ));

    return GitHubSyncPreview(
      matches: matches,
      logs: List.from(service.logs),
    );
  }

  /// Applies the selected matches, writing issue refs to time entries.
  /// Returns the number of entries updated.
  Future<int> applyMatches(List<SyncMatch> selected) async {
    final timeEntryDao = ref.read(timeEntryDaoProvider);
    // Track accumulated refs per entry so multiple matches on the same entry stack correctly.
    final accumulatedRefs = <int, String>{};
    int count = 0;

    for (final match in selected) {
      final entryId = match.entry.id;
      final existing = accumulatedRefs[entryId] ??
          (match.entry.issueReference ?? '');

      if (existing.contains(match.issueRef)) continue;

      final newRef =
          existing.isEmpty ? match.issueRef : '$existing, ${match.issueRef}';
      accumulatedRefs[entryId] = newRef;

      await timeEntryDao.updateWithOverlapCheck(
        entryId,
        TimeEntriesCompanion(issueReference: Value(newRef)),
      );
      count++;
    }

    ref.invalidate(filteredEntriesProvider);
    return count;
  }

  /// Tests the PAT and checks access to all linked repos.
  Future<GitHubConnectionTest> testConnection(
      String pat, String username) async {
    if (pat.isEmpty) {
      return GitHubConnectionTest(
          patError: 'No PAT entered. Enter a token and try again.');
    }

    final service = GitHubService(pat: pat, username: username);

    String? authedAs;
    String? patError;
    try {
      authedAs = await service.verifyPat();
    } catch (e) {
      patError = e.toString();
    }

    final repoResults = <String, bool>{};
    if (patError == null) {
      final allProjects = await ref.read(allActiveProjectsProvider.future);
      final linkedRepos = allProjects
          .where((p) => p.githubRepo != null && p.githubRepo!.isNotEmpty)
          .map((p) => GitHubService.normalizeRepo(p.githubRepo!))
          .toSet();

      for (final repo in linkedRepos) {
        repoResults[repo] = await service.verifyRepoAccess(repo);
      }
    }

    return GitHubConnectionTest(
      authedAs: authedAs,
      patError: patError,
      repoResults: repoResults,
    );
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
