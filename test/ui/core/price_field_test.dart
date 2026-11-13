import 'package:hollylist_app/ui/core/ui/forms/price_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Price of the forms', () {
    test(
      'Reads a price written with a comma or a point, and an empty field as 0',
      () {
        expect(parsePrice('24,99'), 24.99);
        expect(parsePrice(' 24.99 '), 24.99);
        expect(parsePrice(''), 0);
      },
    );

    test('Refuses an invalid or too high price, but accepts an empty one', () {
      expect(validatePrice(''), isNull);
      expect(validatePrice('12,5'), isNull);
      expect(validatePrice('abc'), isNotNull);
      expect(validatePrice('99999999999'), isNotNull);
    });

    test('Writes a price for the field without useless decimals', () {
      expect(formatPriceForField(0), '');
      expect(formatPriceForField(30), '30');
      expect(formatPriceForField(24.5), '24.50');
    });
  });
}
