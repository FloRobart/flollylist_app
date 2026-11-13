import 'package:hollylist_app/domain/use_cases/auth/code_entry/code_entry_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [CodeEntryBodyViewModel].
final codeEntryBodyViewModelProvider = Provider<CodeEntryBodyViewModel>((ref) {
  return CodeEntryBodyViewModel(
    codeEntryUseCase: ref.read(codeEntryUseCaseProvider),
  );
});

/// Fournit l'email auquel le code a été envoyé, pour l'afficher.
final codeEntryEmailProvider = FutureProvider.autoDispose<String?>((ref) {
  return ref.read(codeEntryBodyViewModelProvider).codeEntryUseCase.getEmail;
});

/// ViewModel de la saisie du code de connexion reçu par email.
class CodeEntryBodyViewModel {
  CodeEntryBodyViewModel({required this.codeEntryUseCase});

  final CodeEntryUseCase codeEntryUseCase;

  /// Vérifie le code. Retourne false s'il est faux ou expiré.
  /// En cas de succès, le routeur quitte de lui-même l'écran de connexion.
  Future<bool> verifyCode(String code) async {
    try {
      await codeEntryUseCase.verifyCode(normalizeLoginCode(code));
      return true;
    } catch (error) {
      debugPrint('Code verification failed: $error');
      return false;
    }
  }

  /// Envoie un nouveau code. Retourne false si l'envoi a échoué.
  Future<bool> resendCode() async {
    try {
      await codeEntryUseCase.resendCode();
      return true;
    } catch (error) {
      debugPrint('Code sending failed: $error');
      return false;
    }
  }
}

/// Retire les espaces d'un code de connexion et le met en majuscules, comme dans l'email reçu.
String normalizeLoginCode(String code) {
  return code.replaceAll(RegExp(r'\s+'), '').toUpperCase();
}
