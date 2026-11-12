import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/ui/core/ui/utils/format_price.dart';
import 'package:flutter/material.dart';

/// Détails d'un cadeau, avec ses actions : copier le lien, modifier et supprimer.
class GiftDetails extends StatelessWidget {
  const GiftDetails({
    super.key,
    required this.gift,
    required this.peopleName,
    required this.onCopyLink,
    required this.onEdit,
    required this.onDelete,
  });

  final Gift gift;
  final String peopleName;
  final VoidCallback onCopyLink;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = gift.description;
    final link = gift.link;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(gift.name, style: theme.textTheme.titleLarge),

          const SizedBox(height: 16),

          _DetailLine(icon: Icons.person_outline, text: 'Pour $peopleName'),
          _DetailLine(
            icon: Icons.event_outlined,
            text: gift.year?.toString() ?? 'Sans année',
          ),
          _DetailLine(icon: Icons.sell_outlined, text: formatPrice(gift.price)),
          if (description != null)
            _DetailLine(icon: Icons.notes, text: description),
          if (link != null) _DetailLine(icon: Icons.link, text: link),

          const SizedBox(height: 16),

          if (link != null)
            OutlinedButton.icon(
              onPressed: onCopyLink,
              icon: const Icon(Icons.copy),
              label: const Text('Copier le lien'),
            ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                    side: BorderSide(color: theme.colorScheme.error),
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Supprimer'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Modifier'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Une information du cadeau, avec son icône.
class _DetailLine extends StatelessWidget {
  const _DetailLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: 12),
          Expanded(
            child: SelectableText(text, style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
