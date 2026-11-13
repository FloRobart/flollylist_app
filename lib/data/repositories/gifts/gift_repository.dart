import 'package:hollylist_app/data/repositories/gifts/gift_repository_impl.dart';
import 'package:hollylist_app/data/repositories/gifts/gift_repository_remote.dart';
import 'package:hollylist_app/data/services/api/gifts/gift_api_client.dart';
import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [GiftRepository].
final giftRepositoryProvider = Provider<GiftRepository>((ref) {
  final remote = GiftRepositoryRemote(
    giftApiClient: ref.read(giftApiClientProvider),
  );

  return GiftRepositoryImpl(remote: remote);
});

/// Repository interface for the gifts of the user.
abstract class GiftRepository {
  Future<List<Gift>> getGifts();
  Future<Gift> addGift(GiftUpsert gift);
  Future<Gift> updateGift(int id, GiftUpsert gift);
  Future<void> deleteGift(int id);
}
