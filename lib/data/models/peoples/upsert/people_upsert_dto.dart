import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_upsert_dto.freezed.dart';
part 'people_upsert_dto.g.dart';

/// Un proche, tel que l'API l'attend pour le créer ou le modifier.
@freezed
abstract class PeopleUpsertDto with _$PeopleUpsertDto {
  const factory PeopleUpsertDto({
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String? lastName,
    @JsonKey(name: 'date_of_birth') required String? dateOfBirth,
  }) = _PeopleUpsertDto;

  factory PeopleUpsertDto.fromJson(Map<String, dynamic> json) =>
      _$PeopleUpsertDtoFromJson(json);
}
