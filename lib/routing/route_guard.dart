import 'package:hollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:hollylist_app/data/services/auth/auth_manager.dart';
import 'package:hollylist_app/routing/routes.dart';

/* Pages reachable without being logged in */
const Set<String> _loginRoutes = {AppRoutes.login, AppRoutes.codeEntry};

/* Pages that only lead to the application: useless once the user is logged in and the application unlocked */
const Set<String> _gateRoutes = {
  AppRoutes.loading,
  AppRoutes.login,
  AppRoutes.codeEntry,
  AppRoutes.appLock,
};

/// Décide où envoyer l'utilisateur selon sa session et le verrouillage de l'application.
/// Retourne null s'il peut rester sur [location].
String? resolveRedirect({
  required AuthStatus authStatus,
  required AppLockStatus appLockStatus,
  required String location,
}) {
  final requiredLocation = _requiredLocation(
    authStatus,
    appLockStatus,
    location,
  );
  if (requiredLocation == location) return null;

  return requiredLocation;
}

/// Page imposée par l'état de l'application, ou null si toutes les pages sont accessibles.
String? _requiredLocation(
  AuthStatus authStatus,
  AppLockStatus appLockStatus,
  String location,
) {
  if (authStatus == AuthStatus.unknown) return AppRoutes.loading;

  if (authStatus == AuthStatus.unauthenticated) {
    return _loginRoutes.contains(location) ? null : AppRoutes.login;
  }

  /* Logged in: the data stays hidden until the code of the application is set or typed */
  if (appLockStatus == AppLockStatus.unknown) return AppRoutes.loading;
  if (appLockStatus != AppLockStatus.unlocked) return AppRoutes.appLock;

  return _gateRoutes.contains(location) ? AppRoutes.home : null;
}
