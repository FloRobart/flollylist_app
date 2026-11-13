import 'package:hollylist_app/data/models/gifts/gift_dto_mapper.dart';
import 'package:hollylist_app/data/repositories/gifts/gift_repository.dart';
import 'package:hollylist_app/data/repositories/gifts/gift_repository_remote.dart';
import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert_mapper.dart';

/// Converts the gifts between the format of the API and the one of the application.
/// Nothing is kept on the device: the gifts must stay out of reach of the other users of the device.
class GiftRepositoryImpl implements GiftRepository {
  const GiftRepositoryImpl({required this.remote});

  final GiftRepositoryRemote remote;

  @override
  Future<List<Gift>> getGifts() async {
    final giftsDto = await remote.getGifts();
    return giftsDto.map((giftDto) => giftDto.toDomain()).toList();
  }

  @override
  Future<Gift> addGift(GiftUpsert gift) async {
    final giftDto = await remote.addGift(gift.toDto());
    return giftDto.toDomain();
  }

  @override
  Future<Gift> updateGift(int id, GiftUpsert gift) async {
    final giftDto = await remote.updateGift(id, gift.toDto());
    return giftDto.toDomain();
  }

  @override
  Future<void> deleteGift(int id) {
    return remote.deleteGift(id);
  }
}
