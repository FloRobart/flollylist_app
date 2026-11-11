import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:flollylist_app/routing/routes.dart';
import 'package:flollylist_app/ui/core/ui/utils/error_message.dart';
import 'package:flollylist_app/ui/core/ui/utils/show_message.dart';
import 'package:flollylist_app/ui/core/ui/widgets/confirm_dialog.dart';
import 'package:flollylist_app/ui/core/ui/widgets/form_sheet.dart';
import 'package:flollylist_app/ui/peoples/view_models/people_viewmodel.dart';
import 'package:flollylist_app/ui/peoples/widgets/people_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Actions de l'utilisateur sur ses proches : ouverture des formulaires, confirmations et messages.
class PeopleAction {
  PeopleAction({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;

  /// Ouvre le formulaire d'ajout d'un proche, puis l'ajoute.
  Future<void> openCreateForm() async {
    final viewModel = ref.read(peopleViewModelProvider.notifier);
    final peopleUpsert = await showFormSheet<PeopleUpsert>(
      context,
      const PeopleForm(),
    );
    if (peopleUpsert == null) return;

    try {
      final createdPeople = await viewModel.addPeople(peopleUpsert);
      if (!context.mounted) return;
      showMessage(context, '${createdPeople.fullName} a été ajouté(e).');
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }

  /// Ouvre le formulaire de modification d'un proche, puis enregistre la modification.
  Future<void> openEditForm(People people) async {
    final viewModel = ref.read(peopleViewModelProvider.notifier);
    final peopleUpsert = await showFormSheet<PeopleUpsert>(
      context,
      PeopleForm(initialPeople: people),
    );
    if (peopleUpsert == null) return;

    try {
      await viewModel.editPeople(people.id, peopleUpsert);
      if (!context.mounted) return;
      showMessage(context, 'Modifications enregistrées.');
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }

  /// Supprime un proche et tous ses cadeaux après confirmation, puis revient à l'accueil.
  Future<void> confirmAndDelete(
    People people, {
    required int giftsCount,
  }) async {
    final viewModel = ref.read(peopleViewModelProvider.notifier);
    final isConfirmed = await showConfirmDialog(
      context,
      title: 'Supprimer ${people.fullName} ?',
      message: giftsCount == 0
          ? 'Cette personne sera supprimée définitivement.'
          : 'Cette personne et ses $giftsCount cadeau(x) seront supprimés définitivement.',
    );
    if (!isConfirmed) return;

    try {
      await viewModel.deletePeople(people.id);
      if (!context.mounted) return;
      showMessage(context, '${people.fullName} a été supprimé(e).');
      context.go(AppRoutes.home);
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }
}
