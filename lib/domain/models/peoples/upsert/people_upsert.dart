import 'package:freezed_annotation/freezed_annotation.dart';

part 'people_upsert.freezed.dart';

/// Les informations d'un proche saisies dans le formulaire, pour le créer ou le modifier.
@freezed
abstract class PeopleUpsert with _$PeopleUpsert {
  const factory PeopleUpsert({
    required String firstName,
    required String? lastName,
    required DateTime? dateOfBirth,
  }) = _PeopleUpsert;
}
