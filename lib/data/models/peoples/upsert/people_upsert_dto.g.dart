// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_upsert_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PeopleUpsertDto _$PeopleUpsertDtoFromJson(Map<String, dynamic> json) =>
    _PeopleUpsertDto(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
    );

Map<String, dynamic> _$PeopleUpsertDtoToJson(_PeopleUpsertDto instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_of_birth': instance.dateOfBirth,
    };
