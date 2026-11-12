import 'package:hollylist_app/data/repositories/peoples/people_repository_impl.dart';
import 'package:hollylist_app/data/repositories/peoples/people_repository_remote.dart';
import 'package:hollylist_app/data/services/api/peoples/people_api_client.dart';
import 'package:hollylist_app/domain/models/peoples/people.dart';
import 'package:hollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Fournit une instance de [PeopleRepository].
final peopleRepositoryProvider = Provider<PeopleRepository>((ref) {
  final remote = PeopleRepositoryRemote(
    peopleApiClient: ref.read(peopleApiClientProvider),
  );

  return PeopleRepositoryImpl(remote: remote);
});

/// Repository interface for the people of the user.
abstract class PeopleRepository {
  Future<List<People>> getPeoples();
  Future<People> addPeople(PeopleUpsert people);
  Future<People> updatePeople(int id, PeopleUpsert people);
  Future<void> deletePeople(int id);
}
