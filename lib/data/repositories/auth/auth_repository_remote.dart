import 'package:flollylist_app/data/services/api/auth/auth_api_client.dart';

class AuthRepositoryRemote {
  const AuthRepositoryRemote({required this.authApiClient});

  final AuthApiClient authApiClient;

  /// Demande l'envoi d'un code de connexion par email.
  /// Retourne le jeton associé au code.
  Future<String> requestLoginCode(String email) {
    return authApiClient.requestLoginCode(email);
  }

  /// Confirme le code de connexion.
  /// Retourne le JWT de l'utilisateur.
  Future<String> confirmLoginCode(String email, String token, String secret) {
    return authApiClient.confirmLoginCode(email, token, secret);
  }
}
