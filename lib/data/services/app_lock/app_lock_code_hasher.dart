import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Transforme le code de verrouillage de l'application en empreinte, pour qu'il ne soit jamais
/// stocké en clair : avant, il l'était, et quiconque lisait le stockage du navigateur le voyait.
///
/// L'empreinte est un PBKDF2-HMAC-SHA256 salé. Elle cache le code (souvent réutilisé ailleurs,
/// comme un code de carte), mais un code de quelques chiffres reste devinable par une machine :
/// le verrouillage protège l'écran, pas les données. Elles restent sur le serveur, derrière le JWT.
///
/// Format stocké : `pbkdf2-sha256$<itérations>$<sel en base64>$<empreinte en base64>`.
class AppLockCodeHasher {
  const AppLockCodeHasher({this.iterations = defaultIterations});

  /* Enough to slow down each try, without freezing the web application, where the whole
     computation runs on the only thread of the page */
  static const int defaultIterations = 10000;
  static const int _saltLength = 16;
  static const String _algorithm = 'pbkdf2-sha256';

  final int iterations;

  /// Calcule l'empreinte d'un code, avec un nouveau sel aléatoire.
  String createHash(String code) {
    final salt = _generateSalt();
    final codeHash = _pbkdf2(code, salt, iterations);

    return [
      _algorithm,
      iterations,
      base64Encode(salt),
      base64Encode(codeHash),
    ].join(r'$');
  }

  /// Indique si un code correspond à une empreinte calculée par [createHash].
  bool matches(String code, String storedHash) {
    final parts = storedHash.split(r'$');
    if (parts.length != 4 || parts[0] != _algorithm) return false;

    final storedIterations = int.tryParse(parts[1]);
    if (storedIterations == null || storedIterations < 1) return false;

    try {
      final salt = base64Decode(parts[2]);
      final expectedHash = base64Decode(parts[3]);

      return _constantTimeEquals(
        _pbkdf2(code, salt, storedIterations),
        expectedHash,
      );
    } on FormatException {
      return false;
    }
  }

  /// Sel aléatoire, tiré par le générateur cryptographique de la plateforme.
  Uint8List _generateSalt() {
    final random = Random.secure();
    return Uint8List.fromList(
      List<int>.generate(_saltLength, (_) => random.nextInt(256)),
    );
  }

  /// PBKDF2-HMAC-SHA256 (RFC 8018), limité à un bloc de 32 octets : la taille de l'empreinte.
  Uint8List _pbkdf2(String code, List<int> salt, int iterationsCount) {
    final hmac = Hmac(sha256, utf8.encode(code));

    /* First block: the salt followed by the index of the block, 1, on four bytes */
    var previousBlock = hmac.convert([...salt, 0, 0, 0, 1]).bytes;
    final result = Uint8List.fromList(previousBlock);

    for (var iteration = 1; iteration < iterationsCount; iteration++) {
      previousBlock = hmac.convert(previousBlock).bytes;
      _xorInto(result, previousBlock);
    }

    return result;
  }

  /// Applique un XOR octet par octet de [bytes] sur [target].
  void _xorInto(Uint8List target, List<int> bytes) {
    for (var index = 0; index < target.length; index++) {
      target[index] ^= bytes[index];
    }
  }

  /// Compare deux empreintes en un temps qui ne dépend pas de leur contenu.
  bool _constantTimeEquals(List<int> first, List<int> second) {
    if (first.length != second.length) return false;

    var difference = 0;
    for (var index = 0; index < first.length; index++) {
      difference |= first[index] ^ second[index];
    }

    return difference == 0;
  }
}
