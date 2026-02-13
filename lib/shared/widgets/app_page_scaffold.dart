import 'package:flutter/material.dart';

/// Centralized page scaffold that handles AppBar, SafeArea, and bottom bars.
///
/// See `docs/UI_DESIGN_GUIDELINES.md` Section 11.
class AppPageScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomBar;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppPageScaffold({
    super.key,
    this.title,
    required this.body,
    this.bottomBar,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text(title!), actions: actions)
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomBar != null
          ? SafeArea(child: bottomBar!)
          : null,
    );
  }
}
