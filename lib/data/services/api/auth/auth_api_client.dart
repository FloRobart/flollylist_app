import 'package:hollylist_app/config/app_config.dart';
import 'package:hollylist_app/data/services/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance d'[AuthApiClient].
final authApiClientProvider = Provider<AuthApiClient>((ref) {
  return AuthApiClient(apiClient: ref.read(apiClientProvider));
});

/// Client de l'API d'authentification (Floraccess), pour la connexion par code envoyé par email.
class AuthApiClient {
  const AuthApiClient({required this.apiClient});

  final ApiClient apiClient;

  static String get _baseUrl => '${AppConfig.authUrl}/users';

  /// Demande l'envoi d'un code de connexion à l'adresse email. Floraccess crée le compte s'il
  /// n'existe pas encore : il n'y a donc pas de différence entre connexion et inscription.
  /// Retourne le jeton qui accompagne ce code, nécessaire pour le confirmer.
  Future<String> requestLoginCode(String email) async {
    final response = await apiClient.request(
      HttpMethod.post,
      '$_baseUrl/login/request',
      authenticated: false,
      body: {'email': email},
    );

    return readJsonObject(response.data)['token'] as String;
  }

  /// Confirme le code reçu par email. Retourne le JWT de l'utilisateur.
  Future<String> confirmLoginCode(
    String email,
    String token,
    String secret,
  ) async {
    final response = await apiClient.request(
      HttpMethod.post,
      '$_baseUrl/login/confirm',
      authenticated: false,
      body: {'email': email, 'token': token, 'secret': secret},
    );

    return readJsonObject(response.data)['jwt'] as String;
  }
}
