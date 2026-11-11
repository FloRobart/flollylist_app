import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_dto.freezed.dart';
part 'people_dto.g.dart';

/// Un proche, tel que l'API le renvoie.
@freezed
abstract class PeopleDto with _$PeopleDto {
  const factory PeopleDto({
    required int id,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String? lastName,
    @JsonKey(name: 'date_of_birth') required String? dateOfBirth,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _PeopleDto;

  factory PeopleDto.fromJson(Map<String, dynamic> json) =>
      _$PeopleDtoFromJson(json);
}
