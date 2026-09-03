import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:code_ledger/app.dart';
import 'package:code_ledger/core/database/app_database.dart';
import 'package:code_ledger/core/providers/database_provider.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(() => db.close());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
        ],
        child: const CodeLedgerApp(),
      ),
    );
    expect(find.text('CodeLedger'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 100));
  });
}
