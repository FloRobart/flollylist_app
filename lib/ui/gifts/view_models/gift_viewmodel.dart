import 'package:hollylist_app/data/services/auth/auth_manager.dart';
import 'package:hollylist_app/domain/models/gifts/gift.dart';
import 'package:hollylist_app/domain/models/gifts/upsert/gift_upsert.dart';
import 'package:hollylist_app/domain/use_cases/gifts/gift_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider d'état asynchrone des cadeaux de l'utilisateur, pour tous ses proches.
final giftViewModelProvider = AsyncNotifierProvider<GiftViewModel, List<Gift>>(
  GiftViewModel.new,
);

/// ViewModel pour la gestion de l'état des cadeaux.
class GiftViewModel extends AsyncNotifier<List<Gift>> {
  GiftUseCase get _useCase => ref.read(giftUseCaseProvider);

  List<Gift> get _currentGifts => state.value ?? <Gift>[];

  @override
  Future<List<Gift>> build() async {
    /* Rebuilt at each login and logout: the gifts of a user never stay after its session */
    final authStatus = ref.watch(authNotifierProvider);
    if (authStatus != AuthStatus.authenticated) return <Gift>[];

    return _useCase.getGifts();
  }

  /// Recharge la liste depuis l'API, en gardant l'ancienne à l'écran pendant le chargement.
  /// En cas d'échec, l'erreur est levée et l'ancienne liste reste affichée.
  Future<void> refresh() async {
    final gifts = await _useCase.getGifts();
    state = AsyncData(gifts);
  }

  /// Crée un cadeau côté serveur, puis l'ajoute à la liste.
  Future<Gift> addGift(GiftUpsert gift) async {
    final createdGift = await _useCase.addGift(gift);
    state = AsyncData([..._currentGifts, createdGift]);
    return createdGift;
  }

  /// Modifie un cadeau côté serveur, puis le remplace dans la liste.
  Future<void> editGift(int id, GiftUpsert gift) async {
    final updatedGift = await _useCase.updateGift(id, gift);
    state = AsyncData(
      _currentGifts
          .map((current) => current.id == id ? updatedGift : current)
          .toList(),
    );
  }

  /// Supprime un cadeau côté serveur, puis le retire de la liste.
  Future<void> deleteGift(int id) async {
    await _useCase.deleteGift(id);
    state = AsyncData(_currentGifts.where((gift) => gift.id != id).toList());
  }

  /// Retire de la liste les cadeaux d'un proche supprimé : la base les a supprimés avec lui.
  void forgetGiftsOf(int peopleId) {
    state = AsyncData(
      _currentGifts.where((gift) => gift.peopleId != peopleId).toList(),
    );
  }
}
