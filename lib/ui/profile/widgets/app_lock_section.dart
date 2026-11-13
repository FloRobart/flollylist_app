import 'package:hollylist_app/ui/core/ui/widgets/card_container.dart';
import 'package:flutter/material.dart';

/// Section du code de l'application : le changer, ou verrouiller tout de suite.
class AppLockSection extends StatelessWidget {
  const AppLockSection({
    super.key,
    required this.onChangeCode,
    required this.onLockNow,
  });

  final VoidCallback onChangeCode;
  final VoidCallback onLockNow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code de l\'application', style: theme.textTheme.titleMedium),

          const SizedBox(height: 4),

          Text(
            'Demandé à chaque ouverture, pour que vos proches ne découvrent pas leurs cadeaux.',
            style: theme.textTheme.bodySmall,
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Icon(Icons.pin_outlined, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onChangeCode,
                child: const Text('Changer le code'),
              ),
            ],
          ),

          Row(
            children: [
              Icon(Icons.lock_outline, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onLockNow,
                child: const Text('Verrouiller maintenant'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
