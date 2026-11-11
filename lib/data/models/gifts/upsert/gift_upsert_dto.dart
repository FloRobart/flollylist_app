import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_upsert_dto.freezed.dart';
part 'gift_upsert_dto.g.dart';

/// Un cadeau, tel que l'API l'attend pour le créer ou le modifier.
@freezed
abstract class GiftUpsertDto with _$GiftUpsertDto {
  const factory GiftUpsertDto({
    @JsonKey(name: 'gift_name') required String name,
    @JsonKey(name: 'gift_description') required String? description,
    @JsonKey(name: 'gift_year') required int? year,
    required double price,
    required String? link,
    @JsonKey(name: 'people_id') required int peopleId,
  }) = _GiftUpsertDto;

  factory GiftUpsertDto.fromJson(Map<String, dynamic> json) =>
      _$GiftUpsertDtoFromJson(json);
}
