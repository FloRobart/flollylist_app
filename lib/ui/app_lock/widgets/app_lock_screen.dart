import 'package:flollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:flollylist_app/ui/app_lock/widgets/app_lock_setup_form.dart';
import 'package:flollylist_app/ui/app_lock/widgets/app_lock_unlock_form.dart';
import 'package:flollylist_app/ui/auth/widgets/auth_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran de verrouillage : choix du code à la première connexion, puis saisie à chaque ouverture.
class AppLockScreen extends ConsumerWidget {
  const AppLockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLockStatus = ref.watch(appLockManagerProvider);

    if (appLockStatus == AppLockStatus.needsSetup) {
      return const AuthBase(
        title: 'Choisissez un code',
        body: AppLockSetupForm(),
      );
    }

    return const AuthBase(
      title: 'FlollyList est verrouillé',
      body: AppLockUnlockForm(),
    );
  }
}
