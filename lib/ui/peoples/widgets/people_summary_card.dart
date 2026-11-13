import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/ui/core/ui/utils/format_date.dart';
import 'package:hollylist_app/ui/core/ui/utils/format_price.dart';
import 'package:hollylist_app/ui/core/ui/utils/pluralize.dart';
import 'package:hollylist_app/ui/core/ui/widgets/card_container.dart';
import 'package:hollylist_app/ui/peoples/widgets/people_avatar.dart';
import 'package:flutter/material.dart';

/// En-tête de la page d'un proche : son nom, son âge, son budget de l'année, et ses actions.
class PeopleSummaryCard extends StatelessWidget {
  const PeopleSummaryCard({
    super.key,
    required this.people,
    required this.year,
    required this.totalOfYear,
    required this.hasGiftThisYear,
    required this.onEdit,
    required this.onDelete,
  });

  final People people;
  final int year;
  final double totalOfYear;
  final bool hasGiftThisYear;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  /// « Né(e) le 12 mai 1990 · 36 ans », ou null sans date de naissance.
  String? _birthText(DateTime today) {
    final age = people.ageAt(today);
    final birthDate = formatDate(
      people.dateOfBirth,
      customFormat: 'd MMMM yyyy',
    );
    if (age == null || birthDate == null) return null;

    return 'Né(e) le $birthDate · ${pluralize(age, 'an', 'ans')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final birthText = _birthText(DateTime.now());

    return CardContainer(
      child: Row(
        children: [
          PeopleAvatar(
            people: people,
            hasGiftThisYear: hasGiftThisYear,
            radius: 32,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(people.fullName, style: theme.textTheme.titleLarge),
                if (birthText != null)
                  Text(birthText, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(
                  'Noël $year : ${formatPrice(totalOfYear)}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              IconButton(
                onPressed: onEdit,
                tooltip: 'Modifier',
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: onDelete,
                tooltip: 'Supprimer',
                color: theme.colorScheme.error,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
