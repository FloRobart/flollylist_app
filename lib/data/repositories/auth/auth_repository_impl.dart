import 'package:hollylist_app/data/repositories/auth/auth_repository.dart';
import 'package:hollylist_app/data/repositories/auth/auth_repository_local.dart';
import 'package:hollylist_app/data/repositories/auth/auth_repository_remote.dart';
import 'package:hollylist_app/data/services/auth/auth_manager.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required this.remote,
    required this.local,
    required this.globalAuthNotifier,
  });

  final AuthRepositoryRemote remote;
  final AuthRepositoryLocal local;
  final AuthManager globalAuthNotifier;

  /// Demande un code de connexion pour l'email, puis garde l'email et le jeton du code.
  @override
  Future<void> requestLoginCode(String email) async {
    /* Saved first: the login form shows it again, even if the request fails */
    await local.saveEmail(email);

    final String token = await remote.requestLoginCode(email);
    await local.saveLoginToken(token);
  }

  /// Confirme le code reçu par email, puis connecte l'utilisateur avec le JWT obtenu.
  @override
  Future<void> confirmLoginCode(String secret) async {
    final String email = await local.getEmail() ?? '';
    final String token = await local.getLoginToken() ?? '';

    final String jwt = await remote.confirmLoginCode(email, token, secret);
    await globalAuthNotifier.setAuthenticated(jwt);

    /* Useless once the user is logged in. It is kept after a wrong code, so that the user can try again */
    await local.deleteLoginToken();
  }

  /// Récupère l'email de la dernière demande de connexion.
  @override
  Future<String?> getEmail() {
    return local.getEmail();
  }
}
