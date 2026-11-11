// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_upsert_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GiftUpsertDto _$GiftUpsertDtoFromJson(Map<String, dynamic> json) =>
    _GiftUpsertDto(
      name: json['gift_name'] as String,
      description: json['gift_description'] as String?,
      year: (json['gift_year'] as num?)?.toInt(),
      price: (json['price'] as num).toDouble(),
      link: json['link'] as String?,
      peopleId: (json['people_id'] as num).toInt(),
    );

Map<String, dynamic> _$GiftUpsertDtoToJson(_GiftUpsertDto instance) =>
    <String, dynamic>{
      'gift_name': instance.name,
      'gift_description': instance.description,
      'gift_year': instance.year,
      'price': instance.price,
      'link': instance.link,
      'people_id': instance.peopleId,
    };
