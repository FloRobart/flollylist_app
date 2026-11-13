import 'package:hollylist_app/data/repositories/app_lock/app_lock_repository.dart';
import 'package:hollylist_app/data/services/app_lock/app_lock_code_hasher.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Les états possibles du verrouillage de l'application.
enum AppLockStatus {
  /// L'état n'est pas encore lu dans le stockage.
  unknown,

  /// Aucun code n'est défini : il doit l'être avant d'accéder aux données.
  needsSetup,

  /// Un code est défini, et il doit être saisi.
  locked,

  /// Le bon code a été saisi.
  unlocked,
}

/// Fournit une instance de [AppLockManager] pour gérer le verrouillage global de l'application.
final appLockManagerProvider = NotifierProvider<AppLockManager, AppLockStatus>(
  AppLockManager.new,
);

/// Gère le code qui verrouille l'application à chaque ouverture, pour que les proches qui
/// utilisent le même appareil ne voient pas leurs cadeaux.
class AppLockManager extends Notifier<AppLockStatus> {
  static const AppLockCodeHasher _hasher = AppLockCodeHasher();

  AppLockRepository get _repository => ref.read(appLockRepositoryProvider);

  @override
  AppLockStatus build() {
    _init();
    return AppLockStatus.unknown;
  }

  /// Lit dans le stockage si un code est défini : l'application démarre alors verrouillée.
  Future<void> _init() async {
    final codeHash = await _repository.getCodeHash();
    if (!ref.mounted) return;

    state = codeHash == null ? AppLockStatus.needsSetup : AppLockStatus.locked;
  }

  /// Définit un nouveau code, puis déverrouille l'application.
  Future<void> setCode(String code) async {
    await _repository.saveCodeHash(_hasher.createHash(code));
    if (ref.mounted) state = AppLockStatus.unlocked;
  }

  /// Déverrouille l'application si le code est le bon.
  /// Retourne false si le code est faux ou si aucun code n'est défini.
  Future<bool> unlock(String code) async {
    final codeHash = await _repository.getCodeHash();
    if (codeHash == null || !_hasher.matches(code, codeHash)) return false;

    if (ref.mounted) state = AppLockStatus.unlocked;
    return true;
  }

  /// Déverrouille l'application après une connexion : l'utilisateur vient de prouver son
  /// identité avec le code reçu par email, ce qui vaut mieux que le code de l'application.
  /// Sans code défini, l'application reste en attente d'un nouveau code.
  void unlockAfterLogin() {
    if (state != AppLockStatus.locked) return;
    state = AppLockStatus.unlocked;
  }

  /// Verrouille l'application. Sans effet si aucun code n'est défini.
  void lock() {
    if (state != AppLockStatus.unlocked) return;
    state = AppLockStatus.locked;
  }

  /// Supprime le code. À la prochaine connexion, un nouveau code sera demandé.
  Future<void> reset() async {
    await _repository.deleteCodeHash();
    if (ref.mounted) state = AppLockStatus.needsSetup;
  }
}
