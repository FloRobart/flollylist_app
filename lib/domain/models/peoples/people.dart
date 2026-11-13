import 'package:freezed_annotation/freezed_annotation.dart';

part 'people.freezed.dart';

/// Un proche de l'utilisateur, à qui il offre des cadeaux.
@freezed
abstract class People with _$People {
  const People._();

  const factory People({
    required int id,
    required String firstName,
    required String? lastName,
    required DateTime? dateOfBirth,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _People;

  /// Prénom et nom, ou le prénom seul.
  String get fullName {
    final name = lastName;
    if (name == null || name.isEmpty) return firstName;

    return '$firstName $name';
  }

  /// Âge en années révolues à la date [today], ou null sans date de naissance.
  int? ageAt(DateTime today) {
    final birthDate = dateOfBirth;
    if (birthDate == null) return null;

    final hasHadBirthdayThisYear =
        today.month > birthDate.month ||
        (today.month == birthDate.month && today.day >= birthDate.day);
    final age = today.year - birthDate.year;

    return hasHadBirthdayThisYear ? age : age - 1;
  }
}
