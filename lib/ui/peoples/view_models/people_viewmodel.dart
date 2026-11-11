import 'package:flollylist_app/data/services/auth/auth_manager.dart';
import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:flollylist_app/domain/use_cases/peoples/people_usecase.dart';
import 'package:flollylist_app/ui/gifts/view_models/gift_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider d'état asynchrone des proches de l'utilisateur.
final peopleViewModelProvider =
    AsyncNotifierProvider<PeopleViewModel, List<People>>(PeopleViewModel.new);

/// ViewModel pour la gestion de l'état des proches.
class PeopleViewModel extends AsyncNotifier<List<People>> {
  PeopleUseCase get _useCase => ref.read(peopleUseCaseProvider);

  List<People> get _currentPeoples => state.value ?? <People>[];

  @override
  Future<List<People>> build() async {
    /* Rebuilt at each login and logout: the people of a user never stay after its session */
    final authStatus = ref.watch(authNotifierProvider);
    if (authStatus != AuthStatus.authenticated) return <People>[];

    return _useCase.getPeoples();
  }

  /// Recharge la liste depuis l'API, en gardant l'ancienne à l'écran pendant le chargement.
  /// En cas d'échec, l'erreur est levée et l'ancienne liste reste affichée.
  Future<void> refresh() async {
    final peoples = await _useCase.getPeoples();
    state = AsyncData(peoples);
  }

  /// Crée un proche côté serveur, puis l'ajoute à la liste.
  Future<People> addPeople(PeopleUpsert people) async {
    final createdPeople = await _useCase.addPeople(people);
    state = AsyncData([..._currentPeoples, createdPeople]);
    return createdPeople;
  }

  /// Modifie un proche côté serveur, puis le remplace dans la liste.
  Future<void> editPeople(int id, PeopleUpsert people) async {
    final updatedPeople = await _useCase.updatePeople(id, people);
    state = AsyncData(
      _currentPeoples
          .map((current) => current.id == id ? updatedPeople : current)
          .toList(),
    );
  }

  /// Supprime un proche côté serveur, puis le retire de la liste avec ses cadeaux.
  Future<void> deletePeople(int id) async {
    await _useCase.deletePeople(id);
    state = AsyncData(
      _currentPeoples.where((people) => people.id != id).toList(),
    );
    ref.read(giftViewModelProvider.notifier).forgetGiftsOf(id);
  }
}
