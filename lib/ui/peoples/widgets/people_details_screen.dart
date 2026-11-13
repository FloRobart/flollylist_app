import 'package:hollylist_app/ui/core/ui/utils/refresh_peoples_and_gifts.dart';
import 'package:hollylist_app/ui/core/ui/widgets/base_app.dart';
import 'package:hollylist_app/ui/gifts/view_models/gift_action.dart';
import 'package:hollylist_app/ui/peoples/view_models/people_viewmodel.dart';
import 'package:hollylist_app/ui/peoples/widgets/people_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Page d'un proche, avec tous ses cadeaux.
class PeopleDetailsScreen extends ConsumerWidget {
  const PeopleDetailsScreen({super.key, required this.peopleId});

  /// L'identifiant lu dans l'adresse, null s'il n'est pas un nombre.
  final int? peopleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final peoples = ref.watch(peopleViewModelProvider).value ?? [];
    final people = findPeople(peoples, peopleId);

    return BaseApp(
      onRefresh: () => refreshPeoplesAndGifts(context, ref),
      body: PeopleDetailsBody(peopleId: peopleId),

      /* No gift can be added to a person that does not exist */
      floatingActionButton: people == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => GiftAction(
                context: context,
                ref: ref,
                peoples: peoples,
              ).openCreateForm(people.id),
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un cadeau'),
            ),
    );
  }
}
