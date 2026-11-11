import 'package:flollylist_app/data/models/gifts/gift_dto.dart';
import 'package:flollylist_app/data/models/gifts/upsert/gift_upsert_dto.dart';
import 'package:flollylist_app/data/services/api/gifts/gift_api_client.dart';

class GiftRepositoryRemote {
  const GiftRepositoryRemote({required this.giftApiClient});

  final GiftApiClient giftApiClient;

  /// Récupère tous les cadeaux de l'utilisateur depuis l'API.
  Future<List<GiftDto>> getGifts() async {
    final gifts = await giftApiClient.getGifts();
    return gifts.map(GiftDto.fromJson).toList();
  }

  /// Ajoute un cadeau avec l'API.
  Future<GiftDto> addGift(GiftUpsertDto body) async {
    final gift = await giftApiClient.addGift(body.toJson());
    return GiftDto.fromJson(gift);
  }

  /// Modifie un cadeau avec l'API.
  Future<GiftDto> updateGift(int id, GiftUpsertDto body) async {
    final gift = await giftApiClient.updateGift(id, body.toJson());
    return GiftDto.fromJson(gift);
  }

  /// Supprime un cadeau avec l'API.
  Future<void> deleteGift(int id) async {
    await giftApiClient.deleteGift(id);
  }
}
