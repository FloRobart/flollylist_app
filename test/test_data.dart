import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';

/* Shared builders of the tests: only the fields that matter to a test are given */

final DateTime testDate = DateTime(2026, 11, 9);

People buildPeople({
  required int id,
  String firstName = 'Alice',
  String? lastName,
  DateTime? dateOfBirth,
}) {
  return People(
    id: id,
    firstName: firstName,
    lastName: lastName,
    dateOfBirth: dateOfBirth,
    createdAt: testDate,
    updatedAt: testDate,
  );
}

Gift buildGift({
  required int id,
  required int peopleId,
  int? year = 2026,
  double price = 0,
  String name = 'Cadeau',
}) {
  return Gift(
    id: id,
    name: name,
    description: null,
    year: year,
    price: price,
    link: null,
    peopleId: peopleId,
    createdAt: testDate,
    updatedAt: testDate,
  );
}
