import 'package:flollylist_app/config/app_config.dart';
import 'package:flollylist_app/domain/models/users/user.dart';
import 'package:flollylist_app/ui/core/ui/widgets/base_app.dart';
import 'package:flollylist_app/ui/profile/view_models/profile_action.dart';
import 'package:flollylist_app/ui/profile/view_models/profile_screen_viewmodel.dart';
import 'package:flollylist_app/ui/profile/widgets/app_lock_section.dart';
import 'package:flollylist_app/ui/profile/widgets/logout_section.dart';
import 'package:flollylist_app/ui/profile/widgets/overview_section.dart';
import 'package:flollylist_app/ui/profile/widgets/status_section.dart';
import 'package:flollylist_app/ui/profile/widgets/theme_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Écran de profil de l'application.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Relit le profil depuis le serveur. Une erreur est affichée dans l'écran lui-même.
  Future<void> _refreshProfile(WidgetRef ref) async {
    ref.invalidate(profileCurrentUserProvider);

    try {
      await ref.read(profileCurrentUserProvider.future);
    } catch (_) {
      /* Shown by the error state of the screen */
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final profileAction = ProfileAction(context: context, ref: ref);
    final currentUserAsync = ref.watch(profileCurrentUserProvider);

    return BaseApp(
      onRefresh: () => _refreshProfile(ref),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Sélecteur de thème
              const ThemeSection(),

              const SizedBox(height: 12),

              /// Informations du compte, chez Floraccess
              currentUserAsync.when(
                data: (user) =>
                    _UserSections(user: user, profileAction: profileAction),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => Text(
                  'Impossible de charger votre profil.',
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 12),

              /// Code de l'application
              AppLockSection(
                onChangeCode: profileAction.changeAppLockCode,
                onLockNow: profileAction.lockApp,
              ),

              const SizedBox(height: 12),

              /* Kept without the profile: a session refused by the server must not keep
                 the user from logging out */
              LogoutSection(
                onLogout: profileAction.logout,
                onLogoutAll: profileAction.logoutAll,
              ),

              const SizedBox(height: 16),

              /// App version
              Center(
                child: Text(
                  'Version : ${AppConfig.appVersion}',
                  style: theme.textTheme.bodySmall,
                ),
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

/// Les sections qui affichent l'utilisateur : son pseudo, son email et le statut de son compte.
class _UserSections extends StatelessWidget {
  const _UserSections({required this.user, required this.profileAction});

  final User user;
  final ProfileAction profileAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OverViewSection(
          pseudo: user.pseudo,
          email: user.email,
          onPseudoChanged: profileAction.updatePseudo,
        ),

        const SizedBox(height: 12),

        StatusSection(
          isConnected: user.isConnected,
          isEmailVerified: user.isVerifiedEmail,
          createdAt: user.createdAt,
        ),
      ],
    );
  }
}
