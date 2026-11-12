import 'dart:convert';

import 'package:hollylist_app/data/services/auth/jwt_payload.dart';
import 'package:flutter_test/flutter_test.dart';

/// Builds an unsigned JWT with the given claims: the application never checks the signature.
String buildJwt(Map<String, dynamic> claims) {
  String encode(Map<String, dynamic> part) =>
      base64Url.encode(utf8.encode(jsonEncode(part))).replaceAll('=', '');

  return '${encode({'alg': 'HS256'})}.${encode(claims)}.signature';
}

void main() {
  final now = DateTime.utc(2026, 11, 9, 12);
  final nowInSeconds = now.millisecondsSinceEpoch ~/ 1000;

  group('JwtPayload', () {
    test('Reads the email and the time left before the expiration', () {
      final payload = JwtPayload.tryParse(
        buildJwt({'email': 'user@hollylist.fr', 'exp': nowInSeconds + 60}),
      );

      expect(payload, isNotNull);
      expect(payload!.email, 'user@hollylist.fr');
      expect(payload.secondsBeforeExpiration(now: now), 60);
    });

    test('Considers a token without expiration as expired', () {
      final payload = JwtPayload.tryParse(
        buildJwt({'email': 'user@hollylist.fr'}),
      );

      expect(payload!.secondsBeforeExpiration(now: now), 0);
    });

    test('Returns null for a malformed token, instead of throwing', () {
      for (final jwt in [
        '',
        'not-a-jwt',
        'a.b',
        'a.%%%.c',
        'a.${base64Url.encode(utf8.encode('[1,2]'))}.c',
      ]) {
        expect(JwtPayload.tryParse(jwt), isNull, reason: jwt);
      }
    });
  });
}
