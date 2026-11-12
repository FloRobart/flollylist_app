import 'package:hollylist_app/domain/models/gifts/gift.dart';

/// Les cadeaux d'une même année. [year] est null pour les cadeaux sans année.
class GiftYearGroup {
  const GiftYearGroup({required this.year, required this.gifts});

  final int? year;
  final List<Gift> gifts;

  /// Somme des prix des cadeaux de l'année.
  double get totalPrice => sumGiftPrices(gifts);
}

/// Groupe les cadeaux par année, de la plus récente à la plus ancienne, les cadeaux sans année à la fin.
/// Dans une année, les cadeaux gardent leur ordre de création.
List<GiftYearGroup> groupGiftsByYear(Iterable<Gift> gifts) {
  final giftsByYear = <int?, List<Gift>>{};
  for (final gift in gifts) {
    giftsByYear.putIfAbsent(gift.year, () => <Gift>[]).add(gift);
  }

  final years = giftsByYear.keys.toList()..sort(_compareYearsNewestFirst);

  return [
    for (final year in years)
      GiftYearGroup(year: year, gifts: giftsByYear[year]!),
  ];
}

/// Somme des prix d'une liste de cadeaux.
double sumGiftPrices(Iterable<Gift> gifts) {
  return gifts.fold(0, (total, gift) => total + gift.price);
}

/// Ordre des années : la plus récente d'abord, l'absence d'année en dernier.
int _compareYearsNewestFirst(int? first, int? second) {
  if (first == second) return 0;
  if (first == null) return 1;
  if (second == null) return -1;

  return second.compareTo(first);
}
