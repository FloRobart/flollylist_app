import 'package:hollylist_app/data/repositories/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [LoginUseCase].
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return LoginUseCase(authRepository: authRepository);
});

/// Cas d'utilisation pour la demande de connexion de l'utilisateur.
class LoginUseCase {
  LoginUseCase({required this.authRepository});

  final AuthRepository authRepository;

  Future<String?> get getEmail => authRepository.getEmail();

  Future<void> loginRequest(String email) {
    return authRepository.requestLoginCode(email);
  }
}
