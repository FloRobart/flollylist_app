/// Définition centralisée des routes de l'application.
class AppRoutes {
  AppRoutes._();

  /* Loading: while the state of the session and of the lock is read from the storage */
  static const String loading = '/loading';

  /* Home */
  static const String home = '/';

  /* Auth */
  static const String login = '/login';
  static const String codeEntry = '/code_entry';

  /* App lock */
  static const String appLock = '/lock';

  /* Profile */
  static const String profile = '/profile';

  /* People */
  static const String peopleDetails = '/peoples/:id';
  static String peopleDetailsOf(int peopleId) => '/peoples/$peopleId';
}
