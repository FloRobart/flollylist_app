import 'package:hollylist_app/config/app_config.dart';
import 'package:hollylist_app/data/services/api/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [PeopleApiClient].
final peopleApiClientProvider = Provider<PeopleApiClient>((ref) {
  return PeopleApiClient(apiClient: ref.read(apiClientProvider));
});

/// Client de l'API des proches de l'utilisateur (hollylist-api).
class PeopleApiClient {
  const PeopleApiClient({required this.apiClient});

  final ApiClient apiClient;

  static String get _baseUrl => '${AppConfig.dataUrl}/peoples';

  /// Récupère tous les proches de l'utilisateur.
  Future<List<Map<String, dynamic>>> getPeoples() async {
    final response = await apiClient.request(HttpMethod.get, _baseUrl);
    return readJsonList(response.data);
  }

  /// Ajoute un proche. Retourne le proche créé, avec son identifiant.
  Future<Map<String, dynamic>> addPeople(Map<String, dynamic> body) async {
    final response = await apiClient.request(
      HttpMethod.post,
      _baseUrl,
      body: body,
    );
    return readJsonObject(response.data);
  }

  /// Remplace les informations d'un proche. Retourne le proche modifié.
  Future<Map<String, dynamic>> updatePeople(
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

  /// Supprime un proche, avec tous ses cadeaux. Retourne le proche supprimé.
  Future<Map<String, dynamic>> deletePeople(int id) async {
    final response = await apiClient.request(
      HttpMethod.delete,
      '$_baseUrl/$id',
    );
    return readJsonObject(response.data);
  }
}
