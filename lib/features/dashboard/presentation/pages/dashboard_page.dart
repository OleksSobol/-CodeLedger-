import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeLedger'),
      ),
      body: const Center(
        child: Text('Dashboard — Phase 1 Foundation'),
      ),
    );
  }
}
