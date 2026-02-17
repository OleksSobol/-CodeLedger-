import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/spacing.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionChip(
            icon: Icons.receipt_long_outlined,
            label: 'New Invoice',
            onTap: () => context.push('/invoices/create'),
          ),
        ),
        const SizedBox(width: Spacing.sm),
        Expanded(
          child: _ActionChip(
            icon: Icons.edit_note,
            label: 'Manual Entry',
            onTap: () => context.push('/time-tracking/manual'),
          ),
        ),
        const SizedBox(width: Spacing.sm),
        Expanded(
          child: _ActionChip(
            icon: Icons.people_outline,
            label: 'Clients',
            onTap: () => context.push('/clients'),
          ),
        ),
        const SizedBox(width: Spacing.sm),
        Expanded(
          child: _ActionChip(
            icon: Icons.bar_chart,
            label: 'Reports',
            onTap: () => context.push('/reports'),
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: SizedBox(
          height: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: theme.colorScheme.primary),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
