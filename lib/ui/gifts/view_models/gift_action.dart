import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/ui/core/ui/utils/error_message.dart';
import 'package:hollylist_app/ui/core/ui/utils/show_message.dart';
import 'package:hollylist_app/ui/core/ui/widgets/confirm_dialog.dart';
import 'package:hollylist_app/ui/core/ui/widgets/form_sheet.dart';
import 'package:hollylist_app/ui/gifts/view_models/gift_viewmodel.dart';
import 'package:hollylist_app/ui/gifts/widgets/gift_details.dart';
import 'package:hollylist_app/ui/gifts/widgets/gift_form.dart';
import 'package:hollylist_app/ui/home/view_models/home_body_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Actions de l'utilisateur sur les cadeaux : formulaires, détails, confirmations et messages.
class GiftAction {
  GiftAction({
    required this.context,
    required this.ref,
    required List<People> peoples,
  }) : _peoples = sortPeoplesByName(peoples);

  final BuildContext context;
  final WidgetRef ref;

  /// Les proches, à qui un cadeau peut être offert.
  final List<People> _peoples;

  /// Ouvre le formulaire d'ajout d'un cadeau pour un proche, puis l'ajoute.
  Future<void> openCreateForm(int peopleId) async {
    final viewModel = ref.read(giftViewModelProvider.notifier);
    final giftUpsert = await showFormSheet<GiftUpsert>(
      context,
      GiftForm(peoples: _peoples, peopleId: peopleId),
    );
    if (giftUpsert == null) return;

    try {
      await viewModel.addGift(giftUpsert);
      if (!context.mounted) return;
      showMessage(context, 'Cadeau ajouté.');
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }

  /// Affiche les détails d'un cadeau et ses actions.
  Future<void> openDetails(Gift gift) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (sheetContext) => GiftDetails(
        gift: gift,
        peopleName: _peopleName(gift.peopleId),
        onCopyLink: () => copyLink(gift),
        onEdit: () {
          Navigator.of(sheetContext).pop();
          openEditForm(gift);
        },
        onDelete: () {
          Navigator.of(sheetContext).pop();
          confirmAndDelete(gift);
        },
      ),
    );
  }

  /// Ouvre le formulaire de modification d'un cadeau, puis enregistre la modification.
  Future<void> openEditForm(Gift gift) async {
    final viewModel = ref.read(giftViewModelProvider.notifier);
    final giftUpsert = await showFormSheet<GiftUpsert>(
      context,
      GiftForm(peoples: _peoples, peopleId: gift.peopleId, initialGift: gift),
    );
    if (giftUpsert == null) return;

    try {
      await viewModel.editGift(gift.id, giftUpsert);
      if (!context.mounted) return;
      showMessage(context, 'Modifications enregistrées.');
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }

  /// Supprime un cadeau après confirmation, avec la possibilité d'annuler la suppression.
  Future<void> confirmAndDelete(Gift gift) async {
    final viewModel = ref.read(giftViewModelProvider.notifier);
    final isConfirmed = await showConfirmDialog(
      context,
      title: 'Supprimer ce cadeau ?',
      message: '« ${gift.name} » sera supprimé.',
    );
    if (!isConfirmed) return;

    try {
      await viewModel.deleteGift(gift.id);
      if (!context.mounted) return;
      showMessage(
        context,
        '« ${gift.name} » a été supprimé.',
        action: SnackBarAction(
          label: 'Annuler',
          onPressed: () => viewModel.addGift(GiftUpsert.fromGift(gift)),
        ),
      );
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }

  /// Copie le lien d'un cadeau dans le presse-papiers.
  Future<void> copyLink(Gift gift) async {
    final link = gift.link;
    if (link == null) return;

    await Clipboard.setData(ClipboardData(text: link));
    if (!context.mounted) return;
    showMessage(context, 'Lien copié dans le presse-papiers.');
  }

  String _peopleName(int peopleId) {
    final people = _peoples
        .where((people) => people.id == peopleId)
        .firstOrNull;
    return people?.fullName ?? 'un proche';
  }
}
