import 'package:dio/dio.dart';
import 'package:flollylist_app/data/services/auth/auth_manager.dart';
import 'package:flollylist_app/data/services/interceptors/auth_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [Dio] configurée avec les intercepteurs nécessaires.
final dioProvider = Provider<Dio>((ref) {
  /* Without limits, a server that does not answer would keep a spinner forever */
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );
  dio.interceptors.add(
    AuthInterceptor(authManager: ref.read(authNotifierProvider.notifier)),
  );

  /* Debug builds only: in a release, these logs would show the JWT, the login codes and
     every gift of the user in the console of the browser */
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  return dio;
});

/// Fournit une instance d'[ApiClient].
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(dio: ref.read(dioProvider));
});

/// Les méthodes HTTP utilisées par l'application.
enum HttpMethod { get, post, put, delete }

/// Client HTTP partagé par tous les clients d'API de l'application.
class ApiClient {
  const ApiClient({required this._dio});

  final Dio _dio;

  /// Envoie une requête. Le JWT est ajouté par [AuthInterceptor], sauf si [authenticated] est false.
  /// Lève une [DioException] si la requête échoue ou si le serveur répond par une erreur.
  Future<Response<dynamic>> request(
    HttpMethod method,
    String url, {
    bool authenticated = true,
    Map<String, dynamic>? body,
  }) {
    return _dio.request<dynamic>(
      url,
      data: body,
      options: Options(
        method: method.name.toUpperCase(),
        extra: {'authenticated': authenticated},
      ),
    );
  }
}

/// Lit un objet JSON dans la réponse d'une API.
/// Lève une [FormatException] si la réponse n'est pas un objet JSON.
Map<String, dynamic> readJsonObject(dynamic responseData) {
  if (responseData is Map) return Map<String, dynamic>.from(responseData);

  throw FormatException('Unexpected JSON object: ${responseData.runtimeType}');
}

/// Lit une liste d'objets JSON dans la réponse d'une API.
/// Lève une [FormatException] si la réponse n'est pas une liste d'objets JSON.
List<Map<String, dynamic>> readJsonList(dynamic responseData) {
  if (responseData is List) return responseData.map(readJsonObject).toList();

  throw FormatException('Unexpected JSON list: ${responseData.runtimeType}');
}
