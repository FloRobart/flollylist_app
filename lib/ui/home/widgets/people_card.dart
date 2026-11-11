import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/ui/core/ui/utils/format_price.dart';
import 'package:flollylist_app/ui/core/ui/utils/pluralize.dart';
import 'package:flollylist_app/ui/peoples/widgets/people_avatar.dart';
import 'package:flutter/material.dart';

/// Un proche dans la liste de l'accueil : ses cadeaux de l'année et leur prix total.
class PeopleCard extends StatelessWidget {
  const PeopleCard({
    super.key,
    required this.people,
    required this.year,
    required this.giftsCount,
    required this.totalPrice,
    required this.onTap,
  });

  final People people;
  final int year;
  final int giftsCount;
  final double totalPrice;
  final VoidCallback onTap;

  /// « 2 cadeaux en 2026 · 36 ans », ou « Aucun cadeau en 2026 ».
  String _subtitle(DateTime today) {
    final giftsText = giftsCount == 0
        ? 'Aucun cadeau en $year'
        : '${pluralize(giftsCount, 'cadeau', 'cadeaux')} en $year';

    final age = people.ageAt(today);
    if (age == null) return giftsText;

    return '$giftsText · ${pluralize(age, 'an', 'ans')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: PeopleAvatar(people: people, hasGiftThisYear: giftsCount > 0),
        title: Text(people.fullName, overflow: TextOverflow.ellipsis),
        subtitle: Text(_subtitle(DateTime.now())),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              formatPrice(totalPrice),
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
