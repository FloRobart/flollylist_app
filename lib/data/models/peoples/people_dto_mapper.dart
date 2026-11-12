import 'package:hollylist_app/data/models/peoples/people_dto.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/utils/iso_date.dart';

extension PeopleDtoMapper on PeopleDto {
  People toDomain() {
    final birthDate = dateOfBirth;

    return People(
      id: id,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: birthDate == null ? null : parseIsoDate(birthDate),
      createdAt: DateTime.parse(createdAt).toLocal(),
      updatedAt: DateTime.parse(updatedAt).toLocal(),
    );
  }
}
