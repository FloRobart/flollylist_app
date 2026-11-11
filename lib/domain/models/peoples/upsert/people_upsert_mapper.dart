import 'package:flollylist_app/data/models/peoples/upsert/people_upsert_dto.dart';
import 'package:flollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:flollylist_app/utils/iso_date.dart';

extension PeopleUpsertMapper on PeopleUpsert {
  PeopleUpsertDto toDto() {
    final birthDate = dateOfBirth;

    return PeopleUpsertDto(
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: birthDate == null ? null : formatIsoDate(birthDate),
    );
  }
}
