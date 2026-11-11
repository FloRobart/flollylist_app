/* Validateurs des champs de formulaire. Chacun retourne le message d'erreur, ou null si la
   valeur est valide. Les limites sont celles de l'API, pour qu'elle ne refuse jamais un formulaire validé. */

/// Texte obligatoire, d'au plus [maxLength] caractères une fois les espaces retirés.
String? validateRequiredText(String? value, {required int maxLength}) {
  final trimmedValue = value?.trim() ?? '';
  if (trimmedValue.isEmpty) return 'Ce champ est obligatoire';

  return validateOptionalText(trimmedValue, maxLength: maxLength);
}

/// Texte facultatif, d'au plus [maxLength] caractères une fois les espaces retirés.
String? validateOptionalText(String? value, {required int maxLength}) {
  final trimmedValue = value?.trim() ?? '';
  if (trimmedValue.length > maxLength) return '$maxLength caractères maximum';

  return null;
}

/// Adresse email : la vérification complète est faite par le serveur d'authentification.
String? validateEmail(String? value) {
  final trimmedValue = value?.trim() ?? '';
  if (trimmedValue.isEmpty) return 'L\'adresse email est obligatoire';

  final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  if (!emailPattern.hasMatch(trimmedValue)) return 'Adresse email invalide';

  return null;
}

/// Retire les espaces d'un texte, et le remplace par null s'il est vide : l'API stocke ainsi
/// un champ facultatif laissé vide.
String? emptyToNull(String value) {
  final trimmedValue = value.trim();
  return trimmedValue.isEmpty ? null : trimmedValue;
}
