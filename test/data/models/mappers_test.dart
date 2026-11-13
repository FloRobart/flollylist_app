import 'package:hollylist_app/data/models/gifts/gift_dto.dart';
import 'package:hollylist_app/data/models/gifts/gift_dto_mapper.dart';
import 'package:hollylist_app/data/models/peoples/people_dto.dart';
import 'package:hollylist_app/data/models/peoples/people_dto_mapper.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert_mapper.dart';
import 'package:hollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:hollylist_app/domain/models/peoples/upsert/people_upsert_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('People mappers', () {
    test('Reads a person of the API, with its date of birth as a day of the calendar', () {
      final people = PeopleDto.fromJson({
        'id': 1,
        'first_name': 'Alice',
        'last_name': null,
        'date_of_birth': '1990-05-12',
        'user_id': 42,
        'created_at': '2026-11-01T10:00:00.000Z',
        'updated_at': '2026-11-01T10:00:00.000Z',
      }).toDomain();

      expect(people.firstName, 'Alice');
      expect(people.lastName, isNull);
      expect(people.dateOfBirth, DateTime(1990, 5, 12));
    });

    test(
      'Sends the date of birth as "YYYY-MM-DD", without time nor time zone',
      () {
        final json = PeopleUpsert(
          firstName: 'Alice',
          lastName: null,
          dateOfBirth: DateTime(1990, 5, 2),
        ).toDto().toJson();

        expect(json, {
          'first_name': 'Alice',
          'last_name': null,
          'date_of_birth': '1990-05-02',
        });
      },
    );
  });

  group('Gift mappers', () {
    test('Reads a gift of the API, even with a price without decimals', () {
      final gift = GiftDto.fromJson({
        'id': 1,
        'gift_name': 'Puzzle',
        'gift_description': null,
        'gift_year': 2026,
        'price': 30,
        'link': 'https://example.com',
        'people_id': 3,
        'user_id': 42,
        'created_at': '2026-11-01T10:00:00.000Z',
        'updated_at': '2026-11-01T10:00:00.000Z',
      }).toDomain();

      expect(gift.price, 30.0);
      expect(gift.peopleId, 3);
    });

    test('Sends the names of fields expected by the API, never the user', () {
      final json = const GiftUpsert(
        name: 'Puzzle',
        description: null,
        year: null,
        price: 24.99,
        link: null,
        peopleId: 3,
      ).toDto().toJson();

      expect(json, {
        'gift_name': 'Puzzle',
        'gift_description': null,
        'gift_year': null,
        'price': 24.99,
        'link': null,
        'people_id': 3,
      });
    });
  });
}
