import 'package:flollylist_app/config/app_config.dart';
import 'package:flollylist_app/data/services/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [GiftApiClient].
final giftApiClientProvider = Provider<GiftApiClient>((ref) {
  return GiftApiClient(apiClient: ref.read(apiClientProvider));
});

/// Client de l'API des cadeaux de l'utilisateur (flollylist-api).
class GiftApiClient {
  const GiftApiClient({required this.apiClient});

  final ApiClient apiClient;

  static String get _baseUrl => '${AppConfig.dataUrl}/gifts';

  /// Récupère tous les cadeaux de l'utilisateur, pour tous ses proches.
  Future<List<Map<String, dynamic>>> getGifts() async {
    final response = await apiClient.request(HttpMethod.get, _baseUrl);
    return readJsonList(response.data);
  }

  /// Ajoute un cadeau à un proche. Retourne le cadeau créé, avec son identifiant.
  Future<Map<String, dynamic>> addGift(Map<String, dynamic> body) async {
    final response = await apiClient.request(
      HttpMethod.post,
      _baseUrl,
      body: body,
    );
    return readJsonObject(response.data);
  }

  /// Remplace les informations d'un cadeau. Retourne le cadeau modifié.
  Future<Map<String, dynamic>> updateGift(
    int id,
    Map<String, dynamic> body,
  ) async {
    final response = await apiClient.request(
      HttpMethod.put,
      '$_baseUrl/$id',
      body: body,
    );
    return readJsonObject(response.data);
  }

  /// Supprime un cadeau. Retourne le cadeau supprimé.
  Future<Map<String, dynamic>> deleteGift(int id) async {
    final response = await apiClient.request(
      HttpMethod.delete,
      '$_baseUrl/$id',
    );
    return readJsonObject(response.data);
  }
}
