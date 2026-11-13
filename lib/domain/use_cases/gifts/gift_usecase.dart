import 'package:hollylist_app/data/repositories/gifts/gift_repository.dart';
import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [GiftUseCase].
final giftUseCaseProvider = Provider<GiftUseCase>((ref) {
  return GiftUseCase(repository: ref.read(giftRepositoryProvider));
});

/// Cas d'utilisation de la gestion des cadeaux.
class GiftUseCase {
  GiftUseCase({required this.repository});

  final GiftRepository repository;

  /*=====*/
  /* GET */
  /*=====*/
  Future<List<Gift>> getGifts() {
    return repository.getGifts();
  }

  /*======*/
  /* POST */
  /*======*/
  Future<Gift> addGift(GiftUpsert gift) {
    return repository.addGift(gift);
  }

  /*=====*/
  /* PUT */
  /*=====*/
  Future<Gift> updateGift(int id, GiftUpsert gift) {
    return repository.updateGift(id, gift);
  }

  /*========*/
  /* DELETE */
  /*========*/
  Future<void> deleteGift(int id) {
    return repository.deleteGift(id);
  }
}
