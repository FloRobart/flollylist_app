import 'package:hollylist_app/data/repositories/users/user_repository.dart';
import 'package:hollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:hollylist_app/domain/models/users/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// UseCase provider pour l'écran de profil.
final profileScreenUseCaseProvider = Provider<ProfileScreenUsecase>((ref) {
  return ProfileScreenUsecase(
    userRepository: ref.read(userRepositoryProvider),
    appLockManager: ref.read(appLockManagerProvider.notifier),
  );
});

/// UseCase pour l'écran de profil.
class ProfileScreenUsecase {
  ProfileScreenUsecase({
    required this.userRepository,
    required this.appLockManager,
  });

  final UserRepository userRepository;
  final AppLockManager appLockManager;

  /// Récupère l'utilisateur actuel.
  Future<User> getCurrentUser() {
    return userRepository.getCurrentUser();
  }

  /// Met à jour le pseudo de l'utilisateur.
  Future<void> updatePseudo(String newPseudo) {
    return userRepository.updatePseudo(newPseudo);
  }

  /// Change le code de verrouillage de l'application.
  Future<void> changeAppLockCode(String newCode) {
    return appLockManager.setCode(newCode);
  }

  /// Verrouille l'application.
  void lockApp() {
    appLockManager.lock();
  }

  /// Déconnecte l'utilisateur de cet appareil. Le code de verrouillage appartient à la session :
  /// il est supprimé avec elle, et le prochain utilisateur de l'appareil définira le sien.
  Future<void> logout() async {
    await userRepository.logout();
    await appLockManager.reset();
  }

  /// Déconnecte l'utilisateur de tous les appareils.
  Future<void> logoutAll() async {
    await userRepository.logoutAll();
    await appLockManager.reset();
  }
}
