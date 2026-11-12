import 'package:hollylist_app/routing/routes.dart';
import 'package:hollylist_app/ui/core/ui/widgets/empty_list_message.dart';
import 'package:hollylist_app/ui/core/ui/widgets/section_title.dart';
import 'package:hollylist_app/ui/home/view_models/home_body_viewmodel.dart';
import 'package:hollylist_app/ui/home/widgets/christmas_summary_card.dart';
import 'package:hollylist_app/ui/home/widgets/people_card.dart';
import 'package:hollylist_app/ui/peoples/widgets/peoples_and_gifts_builder.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Contenu de l'accueil : le résumé de Noël de l'année, puis tous les proches.
class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return PeoplesAndGiftsBuilder(
      builder: (context, peoples, gifts) {
        final viewModel = HomeBodyViewmodel(
          peoples: peoples,
          gifts: gifts,
          year: DateTime.now().year,
        );

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChristmasSummaryCard(viewModel: viewModel),

              const SizedBox(height: 24),

              const SectionTitle(
                icon: Icons.groups_outlined,
                title: 'Mes proches',
              ),

              const SizedBox(height: 12),

              if (viewModel.sortedPeoples.isEmpty)
                const EmptyListMessage(
                  icon: Icons.person_add_alt_1,
                  message: 'Aucun proche pour le moment.\nAjoutez-en un avec le bouton en bas de l\'écran.',
                ),

              for (final people in viewModel.sortedPeoples)
                PeopleCard(
                  people: people,
                  year: viewModel.year,
                  giftsCount: viewModel.giftsOfYear(people.id).length,
                  totalPrice: viewModel.totalOfYear(people.id),
                  onTap: () =>
                      context.push(AppRoutes.peopleDetailsOf(people.id)),
                ),

              /* Room for the button of the bottom of the screen, which would hide the last person */
              const SizedBox(height: 96),
            ],
          ),
        );
      },
    );
  }
}
