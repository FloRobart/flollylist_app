import 'package:dio/dio.dart';

/// Traduit une erreur en message compréhensible pour l'utilisateur.
/// Le détail technique n'est jamais affiché : il n'aiderait pas l'utilisateur.
String describeError(Object error) {
  if (error is! DioException) return 'Une erreur inattendue est survenue.';

  final statusCode = error.response?.statusCode;
  if (statusCode == null) {
    return 'Impossible de joindre le serveur. Vérifiez votre connexion internet.';
  }

  return _messagesByStatusCode[statusCode] ??
      'Le serveur a rencontré une erreur. Réessayez plus tard.';
}

const Map<int, String> _messagesByStatusCode = {
  400: 'Les informations saisies ne sont pas valides.',
  401: 'Votre session a expiré. Reconnectez-vous.',
  403: 'Vous avez atteint le nombre maximal d\'éléments.',
  404: 'Cet élément n\'existe plus. Rechargez la page.',
  429: 'Trop de requêtes. Patientez quelques instants.',
  503: 'Le service est momentanément indisponible. Réessayez plus tard.',
};
