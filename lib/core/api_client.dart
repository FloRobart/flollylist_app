import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class ApiClient {
  // Singleton pour n'avoir qu'une instance du client
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final StorageService _storage = StorageService();

  /// Récupère les headers par défaut (Content-Type + Authorization si connecté)
  Future<Map<String, String>> _getHeaders() async {
    final token = await _storage.getJwt();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// Méthode générique GET
  Future<dynamic> get(String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse(url), headers: headers);
      return _processResponse(response);
    } catch (e) {
      print('Erreur GET $url: $e');
      rethrow;
    }
  }

  /// Méthode générique POST
  Future<dynamic> post(String url, {dynamic body}) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      print('Erreur POST $url: $e');
      rethrow;
    }
  }

  /// Méthode générique PUT
  Future<dynamic> put(String url, {dynamic body}) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse(url),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      print('Erreur PUT $url: $e');
      rethrow;
    }
  }

  /// Méthode générique DELETE
  Future<dynamic> delete(String url) async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(Uri.parse(url), headers: headers);
      return _processResponse(response);
    } catch (e) {
      print('Erreur DELETE $url: $e');
      rethrow;
    }
  }

  /// Traitement de la réponse HTTP
  dynamic _processResponse(http.Response response) {
    // Pour le debug
    print('Response status: ${response.statusCode} for ${response.request?.url}');

    // Succès (Codes 200-299)
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Si le corps est vide ou code 204 (No Content)
      if (response.body.isEmpty || response.statusCode == 204) {
        return null;
      }
      // Tente de décoder le JSON
      try {
        return jsonDecode(response.body);
      } catch (e) {
        // Retourne le texte brut si ce n'est pas du JSON valide
        return response.body;
      }
    } 
    // Gestion spécifique (ex: 401 Unauthorized)
    else if (response.statusCode == 401) {
      throw ApiException(message: "Non autorisé", statusCode: 401);
    } 
    // Autres erreurs
    else {
      String message = "Erreur inconnue";
      try {
        // Essayer de lire le message d'erreur du serveur
        final body = jsonDecode(response.body);
        if (body is Map && body.containsKey('message')) {
          message = body['message'];
        } else if (body is Map && body.containsKey('error')) {
          message = body['error'];
        }
      } catch (_) {
        message = response.body;
      }
      throw ApiException(message: message, statusCode: response.statusCode);
    }
  }
}

// Une petite classe d'exception personnalisée
class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException({required this.message, required this.statusCode});

  @override
  String toString() => 'ApiException(status: $statusCode, message: $message)';
}