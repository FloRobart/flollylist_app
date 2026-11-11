import 'package:flollylist_app/data/services/app_lock/app_lock_code_hasher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /* Few iterations: the tests check the logic, not the slowness */
  const hasher = AppLockCodeHasher(iterations: 100);

  group('AppLockCodeHasher', () {
    test('Never stores the code in clear text', () {
      final storedHash = hasher.createHash('1234');

      expect(storedHash, isNot(contains('1234')));
      expect(storedHash, startsWith(r'pbkdf2-sha256$100$'));
    });

    test('Recognizes the right code, and only it', () {
      final storedHash = hasher.createHash('1234');

      expect(hasher.matches('1234', storedHash), isTrue);
      expect(hasher.matches('1235', storedHash), isFalse);
      expect(hasher.matches('', storedHash), isFalse);
    });

    test('Uses a new salt for each hash', () {
      expect(hasher.createHash('1234'), isNot(hasher.createHash('1234')));
    });

    test('Reads the number of iterations from the stored hash', () {
      final storedHash = const AppLockCodeHasher(iterations: 50)
          .createHash('2468');

      expect(hasher.matches('2468', storedHash), isTrue);
    });

    test('Refuses a malformed or foreign stored value, such as the clear code of the former version', () {
      for (final storedHash in [
        '1234',
        r'md5$1$abc$def',
        r'pbkdf2-sha256$0$AAAA$AAAA',
        r'pbkdf2-sha256$100$!!!$AAAA',
      ]) {
        expect(hasher.matches('1234', storedHash), isFalse);
      }
    });
  });
}
