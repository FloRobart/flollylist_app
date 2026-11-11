import 'package:flutter/material.dart';

/// Titre d'une section d'un écran, avec son icône.
class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: (theme.textTheme.titleLarge?.fontSize ?? 22) + 2,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
