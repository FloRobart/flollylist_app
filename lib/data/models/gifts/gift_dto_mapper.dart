import 'package:flollylist_app/data/models/gifts/gift_dto.dart';
import 'package:flollylist_app/domain/models/gifts/gift.dart';

extension GiftDtoMapper on GiftDto {
  Gift toDomain() {
    return Gift(
      id: id,
      name: name,
      description: description,
      year: year,
      price: price,
      link: link,
      peopleId: peopleId,
      createdAt: DateTime.parse(createdAt).toLocal(),
      updatedAt: DateTime.parse(updatedAt).toLocal(),
    );
  }
}
