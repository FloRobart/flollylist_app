import 'package:flollylist_app/domain/models/gifts/gift.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_upsert.freezed.dart';

/// Les informations d'un cadeau saisies dans le formulaire, pour le créer ou le modifier.
@freezed
abstract class GiftUpsert with _$GiftUpsert {
  const factory GiftUpsert({
    required String name,
    required String? description,
    required int? year,
    required double price,
    required String? link,
    required int peopleId,
  }) = _GiftUpsert;

  /// Les informations d'un cadeau existant, pour le recréer à l'identique (annulation d'une suppression).
  factory GiftUpsert.fromGift(Gift gift) {
    return GiftUpsert(
      name: gift.name,
      description: gift.description,
      year: gift.year,
      price: gift.price,
      link: gift.link,
      peopleId: gift.peopleId,
    );
  }
}
