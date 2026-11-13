/// Écrit un nombre suivi du mot au singulier ou au pluriel : « 0 cadeau », « 1 cadeau », « 2 cadeaux ».
/// En français, zéro et un prennent le singulier.
String pluralize(int count, String singular, String plural) {
  return '$count ${count > 1 ? plural : singular}';
}
