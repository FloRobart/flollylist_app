import 'package:flollylist_app/domain/models/gifts/gift.dart';
import 'package:flollylist_app/ui/core/ui/utils/format_price.dart';
import 'package:flutter/material.dart';

/// Un cadeau dans la liste d'un proche. Un appui ouvre ses détails.
class GiftTile extends StatelessWidget {
  const GiftTile({super.key, required this.gift, required this.onTap});

  final Gift gift;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = gift.description;

    return ListTile(
      onTap: onTap,
      leading: Icon(gift.link == null ? Icons.card_giftcard : Icons.link),
      title: Text(gift.name),
      subtitle: description == null
          ? null
          : Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
      /* A gift without price is shown without amount, rather than with a misleading 0 */
      trailing: gift.price == 0
          ? null
          : Text(
              formatPrice(gift.price),
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
