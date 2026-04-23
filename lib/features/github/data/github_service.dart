import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String pat;
  final String username;

  GitHubService({required this.pat, required this.username});

  Map<String, String> get _headers => {
        'Authorization': 'token $pat',
        'Accept': 'application/vnd.github.v3+json',
      };

  /// Returns issue branch names (e.g. "Issue-5444") that had commits
  /// from [username] in [repo] on [date].
  Future<Set<String>> getIssueRefsForDate(String repo, DateTime date) async {
    final dayStart =
        DateTime(date.year, date.month, date.day).toUtc();
    final dayEnd = dayStart.add(const Duration(days: 1));

    final issueBranches = await _listIssueBranches(repo);

    final found = <String>{};

    // Check each Issue-* branch for commits that day
    for (final branch in issueBranches) {
      final hasCommits =
          await _hasCommitsOnBranch(repo, branch, dayStart, dayEnd);
      if (hasCommits) found.add(branch);
    }

    // Also extract inline issue refs from commit messages as fallback
    final msgRefs =
        await _getIssueRefsFromCommitMessages(repo, dayStart, dayEnd);
    found.addAll(msgRefs);

    return found;
  }

  /// Lists all branches whose name starts with Issue- or issue-.
  Future<List<String>> _listIssueBranches(String repo) async {
    final branches = <String>[];
    var page = 1;
    final issuePattern = RegExp(r'^[Ii]ssue[-_]\d+');

    while (true) {
      final uri = Uri.parse(
        'https://api.github.com/repos/$repo/branches?per_page=100&page=$page',
      );
      final response = await http.get(uri, headers: _headers);
      if (response.statusCode != 200) break;

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

  /// Scans commit messages for inline issue refs like #42, Issue-42, Fixes #42.
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
