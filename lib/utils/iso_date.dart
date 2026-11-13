/// Écrit une date au format "YYYY-MM-DD" de l'API, sans heure ni fuseau horaire : une date de
/// naissance est un jour du calendrier, qui ne doit pas changer d'un fuseau à l'autre.
String formatIsoDate(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');

  return '$year-$month-$day';
}

/// Lit une date "YYYY-MM-DD" de l'API, à minuit dans le fuseau de l'appareil.
DateTime parseIsoDate(String isoDate) {
  final parts = isoDate.split('-').map(int.parse).toList();
  return DateTime(parts[0], parts[1], parts[2]);
}
