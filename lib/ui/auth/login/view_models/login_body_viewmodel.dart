import 'package:hollylist_app/domain/use_cases/auth/login/login_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [LoginBodyViewModel].
final loginBodyViewModelProvider = Provider<LoginBodyViewModel>((ref) {
  return LoginBodyViewModel(loginUseCase: ref.read(loginUseCaseProvider));
});

/// Fournit l'email par défaut pour l'écran de connexion : celui de la dernière connexion.
/// Relu à chaque affichage de l'écran, pour ne jamais proposer un ancien email.
final authInitialEmailProvider = FutureProvider.autoDispose<String?>((
  ref,
) async {
  final viewModel = ref.read(loginBodyViewModelProvider);
  return viewModel.getEmail;
});

/// ViewModel pour la logique de l'écran de connexion.
class LoginBodyViewModel {
  LoginBodyViewModel({required this.loginUseCase});

  final LoginUseCase loginUseCase;

  Future<String?> get getEmail => loginUseCase.getEmail;

  /// Demande l'envoi d'un code de connexion. Retourne false si la demande a échoué.
  Future<bool> loginRequest(String email) async {
    try {
      await loginUseCase.loginRequest(email.trim());
      return true;
    } catch (error) {
      debugPrint('Login request failed: $error');
      return false;
    }
  }
}
