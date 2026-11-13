import 'package:hollylist_app/config/app_config.dart';
import 'package:hollylist_app/data/services/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance d'[UserApiClient].
final userApiClientProvider = Provider<UserApiClient>((ref) {
  return UserApiClient(apiClient: ref.read(apiClientProvider));
});

/// Client de l'API des utilisateurs (Floraccess).
class UserApiClient {
  const UserApiClient({required this.apiClient});

  final ApiClient apiClient;

  static String get _baseUrl => '${AppConfig.authUrl}/users';

  /// Récupère les données de l'utilisateur actuel depuis l'API.
  Future<Map<String, dynamic>> getCurrentUser() async {
    final response = await apiClient.request(HttpMethod.get, _baseUrl);
    return readJsonObject(response.data);
  }

  /// Met à jour le pseudo de l'utilisateur. Retourne le nouveau JWT, qui contient ce pseudo.
  Future<String> updatePseudo(String newPseudo, String email) async {
    final response = await apiClient.request(
      HttpMethod.put,
      _baseUrl,
      body: {'email': email, 'pseudo': newPseudo},
    );
    return readJsonObject(response.data)['jwt'] as String;
  }

  /// Déconnecte l'utilisateur de tous les appareils et de toutes les applications.
  Future<void> logoutAll() async {
    await apiClient.request(HttpMethod.post, '$_baseUrl/logout');
  }
}
