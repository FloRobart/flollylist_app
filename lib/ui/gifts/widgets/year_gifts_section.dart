import 'package:flollylist_app/domain/models/gifts/gift.dart';
import 'package:flollylist_app/ui/core/ui/utils/format_price.dart';
import 'package:flollylist_app/ui/core/ui/utils/pluralize.dart';
import 'package:flollylist_app/ui/gifts/view_models/gifts_by_year.dart';
import 'package:flollylist_app/ui/gifts/widgets/gift_tile.dart';
import 'package:flutter/material.dart';

/// Les cadeaux d'une année pour un proche, avec leur nombre et leur prix total.
class YearGiftsSection extends StatelessWidget {
  const YearGiftsSection({
    super.key,
    required this.group,
    required this.onGiftTap,
  });

  final GiftYearGroup group;
  final ValueChanged<Gift> onGiftTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final giftsCount = pluralize(group.gifts.length, 'cadeau', 'cadeaux');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    group.year?.toString() ?? 'Sans année',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '$giftsCount · ${formatPrice(group.totalPrice)}',
                  style: theme.textTheme.titleSmall,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  for (final gift in group.gifts)
                    GiftTile(gift: gift, onTap: () => onGiftTap(gift)),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
