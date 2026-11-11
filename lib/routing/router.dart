import 'package:flollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:flollylist_app/data/services/auth/auth_manager.dart';
import 'package:flollylist_app/routing/route_guard.dart';
import 'package:flollylist_app/routing/routes.dart';
import 'package:flollylist_app/ui/app_lock/widgets/app_lock_screen.dart';
import 'package:flollylist_app/ui/auth/code_entry/widgets/code_entry_screen.dart';
import 'package:flollylist_app/ui/auth/login/widgets/login_screen.dart';
import 'package:flollylist_app/ui/core/ui/widgets/loading_screen.dart';
import 'package:flollylist_app/ui/home/widgets/home_screen.dart';
import 'package:flollylist_app/ui/peoples/widgets/people_details_screen.dart';
import 'package:flollylist_app/ui/profile/widgets/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Fournit le [GoRouter] de l'application, qui redirige selon la session et le verrouillage.
/// Un seul routeur pour toute la vie de l'application : il est notifié des changements d'état,
/// au lieu d'être recréé, ce qui garderait mal la page en cours.
final routerProvider = Provider<GoRouter>((ref) {
  final stateChangeNotifier = ValueNotifier<int>(0);
  ref.listen(authNotifierProvider, (_, _) => stateChangeNotifier.value++);
  ref.listen(appLockManagerProvider, (_, _) => stateChangeNotifier.value++);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: stateChangeNotifier,
    /* Debug builds only: a release would log every page visited in the console */
    debugLogDiagnostics: kDebugMode,
    onException: (context, state, router) {
      router.go(AppRoutes.home);
    },

    redirect: (context, state) => resolveRedirect(
      authStatus: ref.read(authNotifierProvider),
      appLockStatus: ref.read(appLockManagerProvider),
      location: state.matchedLocation,
    ),

    routes: [
      GoRoute(
        path: AppRoutes.loading,
        builder: (_, _) => const LoadingScreen(),
      ),
      GoRoute(path: AppRoutes.home, builder: (_, _) => const HomeScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.codeEntry,
        builder: (_, _) => const CodeEntryScreen(),
      ),
      GoRoute(
        path: AppRoutes.appLock,
        builder: (_, _) => const AppLockScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (_, _) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.peopleDetails,
        builder: (_, state) => PeopleDetailsScreen(
          peopleId: int.tryParse(state.pathParameters['id'] ?? ''),
        ),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    stateChangeNotifier.dispose();
  });

  return router;
});
