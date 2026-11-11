import 'package:flollylist_app/ui/core/ui/utils/refresh_peoples_and_gifts.dart';
import 'package:flollylist_app/ui/core/ui/widgets/base_app.dart';
import 'package:flollylist_app/ui/home/widgets/home_body.dart';
import 'package:flollylist_app/ui/peoples/view_models/people_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran d'accueil : le résumé de Noël et la liste des proches.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final peopleAction = PeopleAction(context: context, ref: ref);

    return BaseApp(
      onRefresh: () => refreshPeoplesAndGifts(context, ref),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: peopleAction.openCreateForm,
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Ajouter un proche'),
      ),
    );
  }
}
