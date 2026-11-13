import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/routing/routes.dart';
import 'package:hollylist_app/ui/core/ui/widgets/empty_list_message.dart';
import 'package:hollylist_app/ui/gifts/view_models/gift_action.dart';
import 'package:hollylist_app/ui/gifts/view_models/gifts_by_year.dart';
import 'package:hollylist_app/ui/gifts/widgets/year_gifts_section.dart';
import 'package:hollylist_app/ui/peoples/view_models/people_action.dart';
import 'package:hollylist_app/ui/peoples/widgets/people_summary_card.dart';
import 'package:hollylist_app/ui/peoples/widgets/peoples_and_gifts_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Contenu de la page d'un proche : son résumé, puis ses cadeaux, année par année.
class PeopleDetailsBody extends ConsumerWidget {
  const PeopleDetailsBody({super.key, required this.peopleId});

  final int? peopleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PeoplesAndGiftsBuilder(
      builder: (context, peoples, gifts) {
        final people = findPeople(peoples, peopleId);
        if (people == null) return const _PeopleNotFound();

        return _PeopleGifts(
          people: people,
          peopleGifts: gifts
              .where((gift) => gift.peopleId == people.id)
              .toList(),
          peopleAction: PeopleAction(context: context, ref: ref),
          giftAction: GiftAction(context: context, ref: ref, peoples: peoples),
        );
      },
    );
  }
}

/// Trouve un proche par son identifiant, ou null s'il n'existe pas (ou plus).
People? findPeople(List<People> peoples, int? peopleId) {
  return peoples.where((people) => people.id == peopleId).firstOrNull;
}

/// Le résumé d'un proche et ses cadeaux, groupés par année.
class _PeopleGifts extends StatelessWidget {
  const _PeopleGifts({
    required this.people,
    required this.peopleGifts,
    required this.peopleAction,
    required this.giftAction,
  });

  final People people;
  final List<Gift> peopleGifts;
  final PeopleAction peopleAction;
  final GiftAction giftAction;

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final giftYearGroups = groupGiftsByYear(peopleGifts);
    final giftsOfCurrentYear = peopleGifts.where(
      (gift) => gift.year == currentYear,
    );

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PeopleSummaryCard(
            people: people,
            year: currentYear,
            totalOfYear: sumGiftPrices(giftsOfCurrentYear),
            hasGiftThisYear: giftsOfCurrentYear.isNotEmpty,
            onEdit: () => peopleAction.openEditForm(people),
            onDelete: () => peopleAction.confirmAndDelete(
              people,
              giftsCount: peopleGifts.length,
            ),
          ),

          const SizedBox(height: 24),

          if (giftYearGroups.isEmpty)
            EmptyListMessage(
              icon: Icons.card_giftcard,
              message:
                  'Aucun cadeau pour ${people.firstName} pour le moment.\nAjoutez-en un avec le bouton en bas de l\'écran.',
            ),

          for (final group in giftYearGroups)
            YearGiftsSection(group: group, onGiftTap: giftAction.openDetails),

          /* Room for the button of the bottom of the screen, which would hide the last gift */
          const SizedBox(height: 96),
        ],
      ),
    );
  }
}

/// Affiché pour un proche supprimé, ou une adresse qui ne correspond à aucun proche.
class _PeopleNotFound extends StatelessWidget {
  const _PeopleNotFound();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EmptyListMessage(
          icon: Icons.person_off_outlined,
          message: 'Ce proche n\'existe pas, ou a été supprimé.',
        ),
        OutlinedButton.icon(
          onPressed: () => context.go(AppRoutes.home),
          icon: const Icon(Icons.home_outlined),
          label: const Text('Retour à l\'accueil'),
        ),
      ],
    );
  }
}
