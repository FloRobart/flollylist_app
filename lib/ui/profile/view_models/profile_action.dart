import 'package:flollylist_app/ui/core/ui/utils/error_message.dart';
import 'package:flollylist_app/ui/core/ui/utils/show_message.dart';
import 'package:flollylist_app/ui/core/ui/widgets/confirm_dialog.dart';
import 'package:flollylist_app/ui/profile/view_models/profile_screen_viewmodel.dart';
import 'package:flollylist_app/ui/profile/widgets/change_app_lock_code_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Actions de l'utilisateur sur son profil : pseudo, code de l'application et déconnexions.
class ProfileAction {
  ProfileAction({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;

  ProfileScreenViewmodel get _viewModel =>
      ref.read(profileScreenViewModelProvider);

  /// Change le pseudo, puis relit le profil pour afficher celui que le serveur a gardé.
  Future<void> updatePseudo(String newPseudo) async {
    final viewModel = _viewModel;

    try {
      await viewModel.updatePseudo(newPseudo);
      if (!context.mounted) return;
      showMessage(context, 'Pseudo modifié.');
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }

    if (!context.mounted) return;
    ref.invalidate(profileCurrentUserProvider);
  }

  /// Demande un nouveau code de verrouillage, puis l'enregistre.
  Future<void> changeAppLockCode() async {
    final viewModel = _viewModel;
    final newCode = await showChangeAppLockCodeDialog(context);
    if (newCode == null) return;

    await viewModel.changeAppLockCode(newCode);
    if (!context.mounted) return;
    showMessage(context, 'Code de l\'application modifié.');
  }

  /// Verrouille l'application : le routeur affiche l'écran de verrouillage.
  void lockApp() {
    _viewModel.lockApp();
  }

  /// Déconnecte l'utilisateur de cet appareil : le routeur affiche l'écran de connexion.
  Future<void> logout() {
    return _viewModel.logout();
  }

  /// Déconnecte l'utilisateur de tous ses appareils, après confirmation.
  Future<void> logoutAll() async {
    final viewModel = _viewModel;
    final isConfirmed = await showConfirmDialog(
      context,
      title: 'Se déconnecter partout ?',
      message: 'Vous serez déconnecté, sur tous vos appareils, de toutes les applications qui utilisent votre compte (FlollyList, Éconoris...).',
      confirmLabel: 'Me déconnecter',
    );
    if (!isConfirmed) return;

    try {
      await viewModel.logoutAll();
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, describeError(error));
    }
  }
}
