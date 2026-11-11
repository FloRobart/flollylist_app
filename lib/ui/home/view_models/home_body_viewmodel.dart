import 'package:flollylist_app/domain/models/gifts/gift.dart';
import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/ui/gifts/view_models/gifts_by_year.dart';

/// Calculs de la page d'accueil : les proches triés, et les cadeaux de l'année de chacun.
class HomeBodyViewmodel {
  HomeBodyViewmodel({
    required List<People> peoples,
    required List<Gift> gifts,
    required this.year,
  }) : sortedPeoples = sortPeoplesByName(peoples),
       _giftsOfYearByPeople = _groupGiftsOfYearByPeople(gifts, year);

  /// L'année affichée : celle en cours.
  final int year;

  /// Les proches, par ordre alphabétique.
  final List<People> sortedPeoples;

  final Map<int, List<Gift>> _giftsOfYearByPeople;

  /// Les cadeaux de l'année pour un proche.
  List<Gift> giftsOfYear(int peopleId) =>
      _giftsOfYearByPeople[peopleId] ?? const [];

  /// Le prix total des cadeaux de l'année pour un proche.
  double totalOfYear(int peopleId) => sumGiftPrices(giftsOfYear(peopleId));

  /// Le prix total des cadeaux de l'année, pour tous les proches.
  double get totalOfYearForEveryone {
    return _giftsOfYearByPeople.values.fold(
      0,
      (total, gifts) => total + sumGiftPrices(gifts),
    );
  }

  /// Le nombre de cadeaux de l'année, pour tous les proches.
  int get giftsCountOfYear {
    return _giftsOfYearByPeople.values.fold(
      0,
      (count, gifts) => count + gifts.length,
    );
  }

  /// Le nombre de proches qui n'ont encore aucun cadeau cette année.
  int get peoplesWithoutGiftCount {
    return sortedPeoples
        .where((people) => giftsOfYear(people.id).isEmpty)
        .length;
  }

  static Map<int, List<Gift>> _groupGiftsOfYearByPeople(
    List<Gift> gifts,
    int year,
  ) {
    final giftsByPeople = <int, List<Gift>>{};
    for (final gift in gifts.where((gift) => gift.year == year)) {
      giftsByPeople.putIfAbsent(gift.peopleId, () => <Gift>[]).add(gift);
    }

    return giftsByPeople;
  }
}

/// Trie les proches par prénom puis par nom, sans tenir compte des majuscules.
List<People> sortPeoplesByName(List<People> peoples) {
  return [...peoples]..sort(
    (first, second) =>
        first.fullName.toLowerCase().compareTo(second.fullName.toLowerCase()),
  );
}
