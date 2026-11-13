import 'package:hollylist_app/data/models/gifts/upsert/gift_upsert_dto.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';

extension GiftUpsertMapper on GiftUpsert {
  GiftUpsertDto toDto() {
    return GiftUpsertDto(
      name: name,
      description: description,
      year: year,
      price: price,
      link: link,
      peopleId: peopleId,
    );
  }
}
