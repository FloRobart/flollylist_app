import 'package:flollylist_app/config/shared_preferences_keys.dart';
import 'package:flollylist_app/data/services/auth/jwt_payload.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Définit les différents états d'authentification possibles pour l'application.
enum AuthStatus { unknown, authenticated, unauthenticated }

/// Fournit une instance de [AuthManager] pour gérer l'état d'authentification global de l'application.
final authNotifierProvider = NotifierProvider<AuthManager, AuthStatus>(
  AuthManager.new,
);

/// Gère l'état d'authentification global de l'application et le JWT de l'utilisateur.
class AuthManager extends Notifier<AuthStatus> {
  String? _jwt;
  String? _email;

  @override
  AuthStatus build() {
    _init();
    return AuthStatus.unknown;
  }

  /// Charge le JWT depuis le stockage local et définit l'état d'authentification.
  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final storedJwt = prefs.getString(SharedPreferencesKeys.jwtToken);
    final payload = storedJwt == null ? null : JwtPayload.tryParse(storedJwt);

    if (storedJwt == null ||
        payload == null ||
        payload.secondsBeforeExpiration() <= 0) {
      /* A token that can no longer be used has nothing to do in the storage */
      await prefs.remove(SharedPreferencesKeys.jwtToken);
      if (ref.mounted) state = AuthStatus.unauthenticated;
      return;
    }

    _jwt = storedJwt;
    _email = payload.email;
    if (ref.mounted) state = AuthStatus.authenticated;
  }

  /// Récupère le JWT actuellement stocké.
  String? get getJwt => _jwt;

  /// Récupère l'email de l'utilisateur actuellement connecté.
  String? get getEmail => _email;

  /// Indique si l'utilisateur est actuellement authentifié, avec un JWT non expiré.
  bool get isAuthenticated {
    final jwt = _jwt;
    if (state != AuthStatus.authenticated || jwt == null) return false;

    final payload = JwtPayload.tryParse(jwt);
    return payload != null && payload.secondsBeforeExpiration() > 0;
  }

  /// Supprime le JWT du stockage local et passe l'état à non authentifié.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKeys.jwtToken);
    _jwt = null;
    _email = null;
    if (ref.mounted) state = AuthStatus.unauthenticated;
  }

  /// Enregistre le JWT dans le stockage local et passe l'état à authentifié.
  Future<void> setAuthenticated(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKeys.jwtToken, jwt);
    _jwt = jwt;
    _email = JwtPayload.tryParse(jwt)?.email;
    if (ref.mounted) state = AuthStatus.authenticated;
  }
}
