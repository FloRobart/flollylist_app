// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GiftDto _$GiftDtoFromJson(Map<String, dynamic> json) => _GiftDto(
  id: (json['id'] as num).toInt(),
  name: json['gift_name'] as String,
  description: json['gift_description'] as String?,
  year: (json['gift_year'] as num?)?.toInt(),
  price: (json['price'] as num).toDouble(),
  link: json['link'] as String?,
  peopleId: (json['people_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$GiftDtoToJson(_GiftDto instance) => <String, dynamic>{
  'id': instance.id,
  'gift_name': instance.name,
  'gift_description': instance.description,
  'gift_year': instance.year,
  'price': instance.price,
  'link': instance.link,
  'people_id': instance.peopleId,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
