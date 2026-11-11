import 'package:flollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:flollylist_app/data/services/auth/auth_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance d'[AppLockUseCase].
final appLockUseCaseProvider = Provider<AppLockUseCase>((ref) {
  return AppLockUseCase(
    appLockManager: ref.read(appLockManagerProvider.notifier),
    authManager: ref.read(authNotifierProvider.notifier),
  );
});

/// Cas d'utilisation du verrouillage de l'application.
class AppLockUseCase {
  AppLockUseCase({required this.appLockManager, required this.authManager});

  final AppLockManager appLockManager;
  final AuthManager authManager;

  /// Définit un nouveau code, puis déverrouille l'application.
  Future<void> setCode(String code) => appLockManager.setCode(code);

  /// Déverrouille l'application. Retourne false si le code est faux.
  Future<bool> unlock(String code) => appLockManager.unlock(code);

  /// Verrouille l'application.
  void lock() => appLockManager.lock();

  /// Code oublié : supprime le code et déconnecte l'utilisateur. Seule une nouvelle connexion,
  /// avec le code reçu par email, permet alors de définir un nouveau code et de revoir les cadeaux.
  Future<void> forgetCode() async {
    /* Logged out first: otherwise the screen of a new code would show up before the login screen */
    await authManager.logout();
    await appLockManager.reset();
  }
}
