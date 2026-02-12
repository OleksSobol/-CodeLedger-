import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/client_providers.dart';
import '../widgets/client_list_tile.dart';

class ClientsListPage extends ConsumerWidget {
  const ClientsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(activeClientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/clients/add'),
        child: const Icon(Icons.add),
      ),
      body: clientsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
        data: (clients) {
          if (clients.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.people_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 16),
                  Text('No clients yet',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Text('Tap + to add your first client'),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) =>
                ClientListTile(client: clients[index]),
          );
        },
      ),
    );
  }
}
