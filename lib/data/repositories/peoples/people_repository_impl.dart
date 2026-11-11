import 'package:flollylist_app/data/models/peoples/people_dto_mapper.dart';
import 'package:flollylist_app/data/repositories/peoples/people_repository.dart';
import 'package:flollylist_app/data/repositories/peoples/people_repository_remote.dart';
import 'package:flollylist_app/domain/models/peoples/people.dart';
import 'package:flollylist_app/domain/models/peoples/upsert/people_upsert.dart';
import 'package:flollylist_app/domain/models/peoples/upsert/people_upsert_mapper.dart';

/// Converts the people between the format of the API and the one of the application.
/// Nothing is kept on the device: the gifts must stay out of reach of the other users of the device.
class PeopleRepositoryImpl implements PeopleRepository {
  const PeopleRepositoryImpl({required this.remote});

  final PeopleRepositoryRemote remote;

  @override
  Future<List<People>> getPeoples() async {
    final peoplesDto = await remote.getPeoples();
    return peoplesDto.map((peopleDto) => peopleDto.toDomain()).toList();
  }

  @override
  Future<People> addPeople(PeopleUpsert people) async {
    final peopleDto = await remote.addPeople(people.toDto());
    return peopleDto.toDomain();
  }

  @override
  Future<People> updatePeople(int id, PeopleUpsert people) async {
    final peopleDto = await remote.updatePeople(id, people.toDto());
    return peopleDto.toDomain();
  }

  @override
  Future<void> deletePeople(int id) {
    return remote.deletePeople(id);
  }
}
