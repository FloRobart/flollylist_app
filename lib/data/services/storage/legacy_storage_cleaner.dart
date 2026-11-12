import 'package:hollylist_app/config/shared_preferences_keys.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Supprime ce que l'ancienne version de l'application a laissé dans le stockage local : le
/// code de verrouillage en clair et une copie de toutes les personnes et de tous les cadeaux.
/// Sans effet si ces clés n'existent pas : l'appel peut se faire à chaque démarrage.
Future<void> removeLegacyStorage() async {
  try {
    final sharedPreferences = await SharedPreferences.getInstance();

    for (final legacyKey in SharedPreferencesKeys.legacyKeys) {
      await sharedPreferences.remove(legacyKey);
    }
  } catch (error) {
    /* Not blocking: the application works the same with these keys still there */
    debugPrint('Legacy storage cleaning failed: $error');
  }
}
