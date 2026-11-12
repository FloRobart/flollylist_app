import 'package:hollylist_app/config/app_config.dart';
import 'package:hollylist_app/config/assets.dart';
import 'package:hollylist_app/domain/use_cases/app_lock/app_lock_usecase.dart';
import 'package:hollylist_app/routing/routes.dart';
import 'package:hollylist_app/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Widget d'en-tête (AppBar) pour les écrans de l'application.
class Header extends ConsumerWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /* Réinitialise la navigation puis redirige vers la page d'accueil */
  void _onPressedHomeButton(BuildContext context) {
    final String currentRoute = GoRouter.of(context).state.matchedLocation;
    if (currentRoute == AppRoutes.home) return;

    GoRouter.of(context).go(AppRoutes.home);
  }

  /* Redirige vers la page de profil si l'utilisateur n'est pas déjà sur cette page */
  void _onPressedProfileButton(BuildContext context) {
    final String currentRoute = GoRouter.of(context).state.matchedLocation;
    if (currentRoute == AppRoutes.profile) return;

    GoRouter.of(context).push(AppRoutes.profile);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final canGoBack = GoRouter.of(context).canPop();

    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: canGoBack ? 0 : NavigationToolbar.kMiddleSpacing,
      leading: canGoBack
          ? IconButton(
              onPressed: () => GoRouter.of(context).pop(),
              tooltip: 'Retour',
              icon: const Icon(Icons.arrow_back),
            )
          : null,
      title: TextButton.icon(
        onPressed: () => _onPressedHomeButton(context),
        style: TextButton.styleFrom(
          foregroundColor: theme.colorScheme.onSurface,
        ),
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Image.asset(Assets.logo512, height: 40),
        ),
        label: Text(
          AppConfig.appName,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: AppTheme.fontSizes[AppFontSize.xlarge],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        /// Verrouille l'application, avant de prêter l'appareil par exemple
        IconButton(
          onPressed: () => ref.read(appLockUseCaseProvider).lock(),
          tooltip: 'Verrouiller HollyList',
          icon: const Icon(Icons.lock_outline),
        ),

        /// Bouton de profil
        IconButton(
          onPressed: () => _onPressedProfileButton(context),
          tooltip: 'Mon profil',
          icon: const Icon(Icons.account_circle_outlined, size: 30),
        ),

        const SizedBox(width: 8),
      ],
    );
  }
}
