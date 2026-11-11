import 'package:dio/dio.dart';
import 'package:flollylist_app/data/services/auth/auth_manager.dart';

/// Intercepteur Dio qui ajoute le JWT aux requêtes authentifiées, et déconnecte l'utilisateur
/// quand le serveur refuse ce JWT.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.authManager});

  final AuthManager authManager;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /* A request that does not require authentication goes without the Authorization header */
    if (!_requiresAuthentication(options)) {
      handler.next(options);
      return;
    }

    final token = authManager.getJwt;
    if (!authManager.isAuthenticated || token == null) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: 'AuthInterceptor: User not authenticated',
        ),
      );
      return;
    }

    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    /* The session ended on the server (expired, or "logout from every device" on another
       device): every next request would fail, so the user goes back to the login screen */
    final isTokenRefused = err.response?.statusCode == 401;
    if (isTokenRefused && _requiresAuthentication(err.requestOptions)) {
      authManager.logout();
    }

    handler.next(err);
  }

  /// Indique si la requête doit porter le JWT. Toutes le doivent, sauf celles de connexion.
  bool _requiresAuthentication(RequestOptions options) {
    return options.extra['authenticated'] != false;
  }
}
