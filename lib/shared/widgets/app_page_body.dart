import 'package:flutter/material.dart';
import 'spacing.dart';

/// Scrollable page body with correct bottom inset handling.
///
/// See `docs/UI_DESIGN_GUIDELINES.md` Sections 1 & 8.
class AppPageBody extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const AppPageBody({super.key, required this.children, this.padding});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    return ListView(
      padding: padding ??
          EdgeInsets.fromLTRB(
            Spacing.md,
            Spacing.md,
            Spacing.md,
            Spacing.md + bottomInset,
          ),
      children: children,
    );
  }
}
