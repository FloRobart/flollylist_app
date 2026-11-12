import 'package:hollylist_app/data/repositories/auth/auth_repository.dart';
import 'package:hollylist_app/data/services/app_lock/app_lock_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [CodeEntryUseCase].
final codeEntryUseCaseProvider = Provider<CodeEntryUseCase>((ref) {
  return CodeEntryUseCase(
    authRepository: ref.read(authRepositoryProvider),
    appLockManager: ref.read(appLockManagerProvider.notifier),
  );
});

/// Cas d'utilisation pour la saisie du code de connexion reçu par email.
class CodeEntryUseCase {
  CodeEntryUseCase({
    required this.authRepository,
    required this.appLockManager,
  });

  final AuthRepository authRepository;
  final AppLockManager appLockManager;

  /// Email auquel le code a été envoyé.
  Future<String?> get getEmail => authRepository.getEmail();

  /// Confirme le code, puis déverrouille l'application si un code de verrouillage existe déjà.
  Future<void> verifyCode(String code) async {
    await authRepository.confirmLoginCode(code);
    appLockManager.unlockAfterLogin();
  }

  /// Envoie un nouveau code à la même adresse email.
  Future<void> resendCode() async {
    final email = await authRepository.getEmail();
    if (email == null) throw StateError('No email to send the code to');

    await authRepository.requestLoginCode(email);
  }
}
