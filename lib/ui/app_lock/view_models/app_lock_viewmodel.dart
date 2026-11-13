import 'package:hollylist_app/config/constantes.dart';
import 'package:hollylist_app/domain/use_cases/app_lock/app_lock_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance d'[AppLockViewModel].
final appLockViewModelProvider = Provider<AppLockViewModel>((ref) {
  return AppLockViewModel(appLockUseCase: ref.read(appLockUseCaseProvider));
});

/// ViewModel de l'écran de verrouillage.
class AppLockViewModel {
  AppLockViewModel({required this.appLockUseCase});

  final AppLockUseCase appLockUseCase;

  /// Définit un nouveau code. Le routeur ouvre ensuite l'application.
  Future<void> setCode(String code) => appLockUseCase.setCode(code);

  /// Déverrouille l'application. Retourne false si le code est faux.
  Future<bool> unlock(String code) => appLockUseCase.unlock(code);

  /// Code oublié : déconnecte l'utilisateur, qui définira un nouveau code après s'être reconnecté.
  Future<void> forgetCode() => appLockUseCase.forgetCode();
}

/// Un code de verrouillage valide : uniquement des chiffres, de la longueur autorisée.
String? validateAppLockCode(String? value) {
  final code = value ?? '';
  if (code.isEmpty) return 'Le code est obligatoire';
  if (!RegExp(r'^\d+$').hasMatch(code)) return 'Uniquement des chiffres';

  final isTooShort = code.length < Constantes.minAppLockCodeLength;
  final isTooLong = code.length > Constantes.maxAppLockCodeLength;
  if (isTooShort || isTooLong) {
    return 'Entre ${Constantes.minAppLockCodeLength} et ${Constantes.maxAppLockCodeLength} chiffres';
  }

  return null;
}
