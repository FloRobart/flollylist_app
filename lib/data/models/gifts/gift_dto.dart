import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_dto.freezed.dart';
part 'gift_dto.g.dart';

/// Un cadeau, tel que l'API le renvoie.
@freezed
abstract class GiftDto with _$GiftDto {
  const factory GiftDto({
    required int id,
    @JsonKey(name: 'gift_name') required String name,
    @JsonKey(name: 'gift_description') required String? description,
    @JsonKey(name: 'gift_year') required int? year,
    required double price,
    required String? link,
    @JsonKey(name: 'people_id') required int peopleId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _GiftDto;

  factory GiftDto.fromJson(Map<String, dynamic> json) =>
      _$GiftDtoFromJson(json);
}
