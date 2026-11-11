import 'package:flollylist_app/ui/gifts/view_models/gifts_by_year.dart';
import 'package:flollylist_app/ui/gifts/widgets/gift_year_field.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_data.dart';

void main() {
  group('groupGiftsByYear', () {
    test(
      'Sorts the years from the newest, with the gifts without year at the end',
      () {
        final groups = groupGiftsByYear([
          buildGift(id: 1, peopleId: 1, year: 2024),
          buildGift(id: 2, peopleId: 1, year: null),
          buildGift(id: 3, peopleId: 1, year: 2026),
          buildGift(id: 4, peopleId: 1, year: 2024),
        ]);

        expect(groups.map((group) => group.year), [2026, 2024, null]);
        expect(groups[1].gifts.map((gift) => gift.id), [1, 4]);
      },
    );

    test('Adds up the prices of each year', () {
      final groups = groupGiftsByYear([
        buildGift(id: 1, peopleId: 1, price: 10.5),
        buildGift(id: 2, peopleId: 1, price: 4.5),
      ]);

      expect(groups.single.totalPrice, 15);
    });

    test('Returns no group without gift', () {
      expect(groupGiftsByYear([]), isEmpty);
    });
  });

  group('giftYearOptions', () {
    test('Offers the next year and the 20 previous ones, then no year', () {
      final options = giftYearOptions(null, 2026);

      expect(options.first, 2027);
      expect(options[options.length - 2], 2006);
      expect(options.last, isNull);
    });

    test('Always offers the year already chosen, even far in the past', () {
      expect(giftYearOptions(1995, 2026), contains(1995));
    });
  });
}
