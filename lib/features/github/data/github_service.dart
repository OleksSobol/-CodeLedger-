import 'dart:convert';
import 'package:http/http.dart' as http;

enum SyncLogLevel { info, warning, error }

class SyncLog {
  final String message;
  final SyncLogLevel level;
  SyncLog(this.message, this.level);
}

class GitHubService {
  final String pat;
  final String username;
  final List<SyncLog> logs = [];
  final void Function(SyncLog)? onLog;

  GitHubService({required this.pat, required this.username, this.onLog});

  Map<String, String> get _headers => {
        'Authorization': 'token $pat',
        'Accept': 'application/vnd.github.v3+json',
      };

  void _log(String msg, [SyncLogLevel level = SyncLogLevel.info]) {
    final entry = SyncLog(msg, level);
    logs.add(entry);
    onLog?.call(entry);
  }

  String _fmtDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  /// Normalizes any GitHub repo string to "owner/repo" format.
  /// Handles full URLs like https://github.com/owner/repo.git
  static String normalizeRepo(String raw) {
    var s = raw.trim();
    // Strip protocol + host
    s = s.replaceFirst(RegExp(r'^https?://github\.com/'), '');
    // Strip trailing .git
    if (s.endsWith('.git')) s = s.substring(0, s.length - 4);
    // Strip leading/trailing slashes
    s = s.replaceAll(RegExp(r'^/+|/+$'), '');
    return s;
  }

  /// Verifies the PAT by calling /user. Returns the authenticated GitHub login
  /// on success, or throws a descriptive string on failure.
  Future<String> verifyPat() async {
    final uri = Uri.parse('https://api.github.com/user');
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['login'] as String? ?? 'unknown';
    } else if (response.statusCode == 401) {
      throw 'Invalid PAT — authentication failed (401)';
    } else {
      throw 'Unexpected response: HTTP ${response.statusCode}';
    }
  }

  /// Checks if the repo is accessible and logs the result. Returns true on success.
  Future<bool> verifyRepoAccess(String repo) async {
    repo = normalizeRepo(repo);
    _log('Checking access to $repo…');
    final uri = Uri.parse('https://api.github.com/repos/$repo');
    try {
      final response = await http.get(uri, headers: _headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final name = data['full_name'] ?? repo;
        final isPrivate = data['private'] as bool? ?? false;
        _log('✓ Connected to $name (${isPrivate ? 'private' : 'public'})');
        return true;
      } else if (response.statusCode == 401) {
        _log('✗ Authentication failed — check your GitHub PAT', SyncLogLevel.error);
      } else if (response.statusCode == 404) {
        _log('✗ $repo not found or PAT lacks access (404)', SyncLogLevel.error);
      } else {
        _log('✗ $repo returned HTTP ${response.statusCode}', SyncLogLevel.error);
      }
    } catch (e) {
      _log('✗ Network error for $repo: $e', SyncLogLevel.error);
    }
    return false;
  }

  /// Returns issue refs (e.g. "Issue-5444") that had commits from [username]
  /// in [repo] on [date].
  Future<Set<String>> getIssueRefsForDate(String repo, DateTime date) async {
    repo = normalizeRepo(repo);
    final dayStart = DateTime(date.year, date.month, date.day).toUtc();
    final dayEnd = dayStart.add(const Duration(days: 1));

    _log('Scanning branches in $repo for ${_fmtDate(date)}…');
    final issueBranches = await _listIssueBranches(repo);
    _log('  Found ${issueBranches.length} Issue-* branch(es) — checking in parallel');

    final found = <String>{};

    // Check branches in parallel batches of 10 to avoid overwhelming the API.
    const batchSize = 10;
    for (var i = 0; i < issueBranches.length; i += batchSize) {
      final batch = issueBranches.skip(i).take(batchSize).toList();
      final results = await Future.wait(
        batch.map((branch) => _hasCommitsOnBranch(repo, branch, dayStart, dayEnd)
            .then((has) => has ? branch : null)),
      );
      for (final branch in results.whereType<String>()) {
        _log('  ✓ $branch — commit by $username on ${_fmtDate(date)}');
        found.add(branch);
      }
    }

    final msgRefs =
        await _getIssueRefsFromCommitMessages(repo, dayStart, dayEnd);
    if (msgRefs.isNotEmpty) {
      _log('  Found ${msgRefs.length} ref(s) in commit messages: ${msgRefs.join(', ')}');
      found.addAll(msgRefs);
    }

    if (found.isEmpty) {
      _log('  No issue refs for ${_fmtDate(date)} in $repo',
          SyncLogLevel.warning);
    }

    return found;
  }

  Future<List<String>> _listIssueBranches(String repo) async {
    final branches = <String>[];
    var page = 1;
    final issuePattern = RegExp(r'^[Ii]ssue[-_]\d+');

    while (true) {
      final uri = Uri.parse(
        'https://api.github.com/repos/$repo/branches?per_page=100&page=$page',
      );
      final response = await http.get(uri, headers: _headers);
      if (response.statusCode != 200) {
        _log('  Branch list failed: HTTP ${response.statusCode}',
            SyncLogLevel.warning);
        break;
      }

      final List<dynamic> data = jsonDecode(response.body);
      if (data.isEmpty) break;

      for (final branch in data) {
        final name = branch['name'] as String;
        if (issuePattern.hasMatch(name)) branches.add(name);
      }

      if (data.length < 100) break;
      page++;
    }
    return branches;
  }

  Future<bool> _hasCommitsOnBranch(
    String repo,
    String branch,
    DateTime since,
    DateTime until,
  ) async {
    final uri = Uri.parse(
      'https://api.github.com/repos/$repo/commits'
      '?sha=${Uri.encodeComponent(branch)}'
      '&author=${Uri.encodeComponent(username)}'
      '&since=${since.toIso8601String()}'
      '&until=${until.toIso8601String()}'
      '&per_page=1',
    );
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode != 200) return false;
    final List<dynamic> data = jsonDecode(response.body);
    return data.isNotEmpty;
  }

  Future<Set<String>> _getIssueRefsFromCommitMessages(
    String repo,
    DateTime since,
    DateTime until,
  ) async {
    final uri = Uri.parse(
      'https://api.github.com/repos/$repo/commits'
      '?author=${Uri.encodeComponent(username)}'
      '&since=${since.toIso8601String()}'
      '&until=${until.toIso8601String()}'
      '&per_page=100',
    );
    final response = await http.get(uri, headers: _headers);
    if (response.statusCode != 200) return {};

    final List<dynamic> data = jsonDecode(response.body);
    final refs = <String>{};
    final pattern = RegExp(
      r'[Ii]ssue[-_ ]?#?(\d+)|(?:fix(?:es|ed)?|close[sd]?|resolve[sd]?)\s+#(\d+)',
      caseSensitive: false,
    );

    for (final commit in data) {
      final msg = commit['commit']?['message'] as String? ?? '';
      for (final match in pattern.allMatches(msg)) {
        final num = match.group(1) ?? match.group(2);
        if (num != null) refs.add('Issue-$num');
      }
    }
    return refs;
  }
}
