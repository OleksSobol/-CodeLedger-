import 'package:flutter/material.dart';
import 'spacing.dart';

/// Section card with optional header and trailing widget.
///
/// See `docs/UI_DESIGN_GUIDELINES.md` Section 8.
class AppSectionCard extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final List<Widget> children;

  const AppSectionCard({
    super.key,
    this.title,
    this.trailing,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            children: [
              Text(
                title!,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (trailing != null) ...[
                const Spacer(),
                trailing!,
              ],
            ],
          ),
          const SizedBox(height: Spacing.sm),
        ],
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ],
    );
  }
}
