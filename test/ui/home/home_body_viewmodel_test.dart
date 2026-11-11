import 'package:flollylist_app/ui/home/view_models/home_body_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_data.dart';

void main() {
  final viewModel = HomeBodyViewmodel(
    year: 2026,
    peoples: [
      buildPeople(id: 1, firstName: 'zoé'),
      buildPeople(id: 2, firstName: 'Alice'),
      buildPeople(id: 3, firstName: 'Bob'),
    ],
    gifts: [
      buildGift(id: 1, peopleId: 1, year: 2026, price: 20),
      buildGift(id: 2, peopleId: 1, year: 2026, price: 5.5),
      buildGift(id: 3, peopleId: 2, year: 2026, price: 30),
      /* Another year: never counted in 2026 */
      buildGift(id: 4, peopleId: 3, year: 2025, price: 100),
    ],
  );

  group('HomeBodyViewmodel', () {
    test('Sorts the people by name, whatever the case', () {
      expect(viewModel.sortedPeoples.map((people) => people.firstName), [
        'Alice',
        'Bob',
        'zoé',
      ]);
    });

    test('Counts only the gifts of the year', () {
      expect(viewModel.giftsOfYear(1).length, 2);
      expect(viewModel.totalOfYear(1), 25.5);
      expect(viewModel.giftsOfYear(3), isEmpty);
      expect(viewModel.totalOfYear(3), 0);
    });

    test('Adds up the year for everyone', () {
      expect(viewModel.totalOfYearForEveryone, 55.5);
      expect(viewModel.giftsCountOfYear, 3);
    });

    test('Finds the people still without gift this year', () {
      expect(viewModel.peoplesWithoutGiftCount, 1);
    });
  });

  group('People', () {
    test('Gives the age in full years', () {
      final people = buildPeople(id: 1, dateOfBirth: DateTime(1990, 11, 10));

      expect(people.ageAt(DateTime(2026, 11, 9)), 35);
      expect(people.ageAt(DateTime(2026, 11, 10)), 36);
      expect(buildPeople(id: 2).ageAt(DateTime(2026)), isNull);
    });

    test('Writes the full name, or the first name alone', () {
      expect(
        buildPeople(id: 1, firstName: 'Alice', lastName: 'Martin').fullName,
        'Alice Martin',
      );
      expect(buildPeople(id: 2, firstName: 'Alice').fullName, 'Alice');
    });
  });
}
