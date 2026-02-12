import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/daos/project_dao.dart';
import '../../../../core/providers/database_provider.dart';

final projectDaoProvider = Provider<ProjectDao>((ref) {
  return ProjectDao(ref.watch(databaseProvider));
});

/// Watch all active projects across all clients.
final allActiveProjectsProvider = StreamProvider<List<Project>>((ref) {
  return ref.watch(projectDaoProvider).watchAllActiveProjects();
});

/// Watch active projects for a specific client.
final projectsForClientProvider =
    StreamProvider.family<List<Project>, int>((ref, clientId) {
  return ref.watch(projectDaoProvider).watchProjectsForClient(clientId);
});

final projectNotifierProvider =
    AsyncNotifierProvider<ProjectNotifier, void>(ProjectNotifier.new);

class ProjectNotifier extends AsyncNotifier<void> {
  late ProjectDao _dao;

  @override
  Future<void> build() async {
    _dao = ref.watch(projectDaoProvider);
  }

  Future<int> addProject({
    required int clientId,
    required String name,
    String? description,
    double? hourlyRateOverride,
    int color = 0xFF2196F3,
  }) async {
    final id = await _dao.insertProject(ProjectsCompanion.insert(
      clientId: clientId,
      name: name,
      description: Value(description),
      hourlyRateOverride: Value(hourlyRateOverride),
      color: Value(color),
    ));
    // Invalidate the family provider for this client
    ref.invalidate(projectsForClientProvider(clientId));
    return id;
  }

  Future<bool> updateProject(int id, int clientId, ProjectsCompanion companion) async {
    final result = await _dao.updateProject(id, companion);
    if (result) {
      ref.invalidate(projectsForClientProvider(clientId));
    }
    return result;
  }

  Future<bool> archiveProject(int id, int clientId) async {
    final result = await _dao.archiveProject(id);
    if (result) {
      ref.invalidate(projectsForClientProvider(clientId));
    }
    return result;
  }
}
