import 'package:flollylist_app/config/shared_preferences_keys.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fournit une instance d'[AppLockRepository].
final appLockRepositoryProvider = Provider<AppLockRepository>((ref) {
  return const AppLockRepository();
});

/// Stockage local de l'empreinte du code de verrouillage. Le code lui-même n'est jamais stocké.
class AppLockRepository {
  const AppLockRepository();

  /// Récupère l'empreinte du code, ou null si aucun code n'est défini.
  Future<String?> getCodeHash() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(SharedPreferencesKeys.appLockCodeHash);
  }

  /// Enregistre l'empreinte du code, à la place de la précédente.
  Future<void> saveCodeHash(String codeHash) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(
      SharedPreferencesKeys.appLockCodeHash,
      codeHash,
    );
  }

  /// Supprime l'empreinte du code.
  Future<void> deleteCodeHash() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(SharedPreferencesKeys.appLockCodeHash);
  }
}
