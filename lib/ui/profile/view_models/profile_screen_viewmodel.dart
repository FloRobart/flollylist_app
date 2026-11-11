import 'package:flollylist_app/domain/models/users/user.dart';
import 'package:flollylist_app/domain/use_cases/users/profile_screen_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le ViewModel de l'écran de profil.
final profileScreenViewModelProvider = Provider<ProfileScreenViewmodel>((ref) {
  return ProfileScreenViewmodel(ref.read(profileScreenUseCaseProvider));
});

/// Provider asynchrone de l'utilisateur courant, relu à chaque ouverture du profil.
final profileCurrentUserProvider = FutureProvider.autoDispose<User>((ref) {
  return ref.read(profileScreenViewModelProvider).getCurrentUser;
});

/// ViewModel pour l'écran de profil.
class ProfileScreenViewmodel {
  ProfileScreenViewmodel(this.useCase);

  final ProfileScreenUsecase useCase;

  Future<User> get getCurrentUser => useCase.getCurrentUser();

  /// Met à jour le pseudo de l'utilisateur chez Floraccess.
  Future<void> updatePseudo(String newPseudo) =>
      useCase.updatePseudo(newPseudo);

  /// Change le code de verrouillage de l'application.
  Future<void> changeAppLockCode(String newCode) =>
      useCase.changeAppLockCode(newCode);

  /// Verrouille l'application.
  void lockApp() => useCase.lockApp();

  /// Déconnecte l'utilisateur de cet appareil.
  Future<void> logout() => useCase.logout();

  /// Déconnecte l'utilisateur de tous les appareils.
  Future<void> logoutAll() => useCase.logoutAll();
}
