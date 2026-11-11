import 'dart:convert';

/// Lecture du contenu (payload) d'un JWT, sans vérifier sa signature : seul le serveur peut la
/// vérifier. L'application s'en sert uniquement pour connaître la date d'expiration et l'email.
class JwtPayload {
  const JwtPayload._(this._claims);

  final Map<String, dynamic> _claims;

  /// Décode le payload d'un JWT. Retourne null si le JWT est mal formé, au lieu de lever une
  /// exception : un JWT illisible dans le stockage ne doit pas bloquer le démarrage.
  static JwtPayload? tryParse(String jwt) {
    final parts = jwt.split('.');
    if (parts.length != 3) return null;

    try {
      final decodedPayload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final claims = jsonDecode(decodedPayload);
      if (claims is! Map<String, dynamic>) return null;

      return JwtPayload._(claims);
    } on FormatException {
      return null;
    }
  }

  /// Email de l'utilisateur, s'il est présent dans le JWT.
  String? get email {
    final email = _claims['email'];
    return email is String ? email : null;
  }

  /// Nombre de secondes avant l'expiration du JWT, 0 s'il n'a pas de date d'expiration.
  int secondsBeforeExpiration({DateTime? now}) {
    final expiration = _claims['exp'];
    if (expiration is! num) return 0;

    final currentSeconds =
        (now ?? DateTime.now()).millisecondsSinceEpoch ~/ 1000;
    return expiration.toInt() - currentSeconds;
  }
}
