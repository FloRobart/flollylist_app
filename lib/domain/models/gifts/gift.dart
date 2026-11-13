import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift.freezed.dart';

/// Un cadeau offert, ou à offrir, à un proche.
@freezed
abstract class Gift with _$Gift {
  const factory Gift({
    required int id,
    required String name,
    required String? description,
    required int? year,
    required double price,
    required String? link,
    required int peopleId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Gift;
}
