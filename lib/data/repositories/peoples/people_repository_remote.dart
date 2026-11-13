import 'package:hollylist_app/data/models/peoples/people_dto.dart';
import 'package:hollylist_app/data/models/peoples/upsert/people_upsert_dto.dart';
import 'package:hollylist_app/data/services/api/peoples/people_api_client.dart';

class PeopleRepositoryRemote {
  const PeopleRepositoryRemote({required this.peopleApiClient});

  final PeopleApiClient peopleApiClient;

  /// Récupère tous les proches de l'utilisateur depuis l'API.
  Future<List<PeopleDto>> getPeoples() async {
    final peoples = await peopleApiClient.getPeoples();
    return peoples.map(PeopleDto.fromJson).toList();
  }

  /// Ajoute un proche avec l'API.
  Future<PeopleDto> addPeople(PeopleUpsertDto body) async {
    final people = await peopleApiClient.addPeople(body.toJson());
    return PeopleDto.fromJson(people);
  }

  /// Modifie un proche avec l'API.
  Future<PeopleDto> updatePeople(int id, PeopleUpsertDto body) async {
    final people = await peopleApiClient.updatePeople(id, body.toJson());
    return PeopleDto.fromJson(people);
  }

  /// Supprime un proche, avec tous ses cadeaux, avec l'API.
  Future<void> deletePeople(int id) async {
    await peopleApiClient.deletePeople(id);
  }
}
