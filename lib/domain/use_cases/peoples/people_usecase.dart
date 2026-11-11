import 'package:flollylist_app/data/repositories/peoples/people_repository.dart';
import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [PeopleUseCase].
final peopleUseCaseProvider = Provider<PeopleUseCase>((ref) {
  return PeopleUseCase(repository: ref.read(peopleRepositoryProvider));
});

/// Cas d'utilisation de la gestion des proches.
class PeopleUseCase {
  PeopleUseCase({required this.repository});

  final PeopleRepository repository;

  /*=====*/
  /* GET */
  /*=====*/
  Future<List<People>> getPeoples() {
    return repository.getPeoples();
  }

  /*======*/
  /* POST */
  /*======*/
  Future<People> addPeople(PeopleUpsert people) {
    return repository.addPeople(people);
  }

  /*=====*/
  /* PUT */
  /*=====*/
  Future<People> updatePeople(int id, PeopleUpsert people) {
    return repository.updatePeople(id, people);
  }

  /*========*/
  /* DELETE */
  /*========*/
  Future<void> deletePeople(int id) {
    return repository.deletePeople(id);
  }
}
