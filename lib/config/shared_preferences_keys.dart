/// Clés des valeurs gardées dans les SharedPreferences (le localStorage du navigateur sur le web).
class SharedPreferencesKeys {
  /* Theme */
  static const String themeMode = 'theme_mode';

  /* Auth */
  static const String userEmail = 'email';
  static const String loginToken = 'login_token';
  static const String jwtToken = 'jwt';

  /* App lock: never the code itself, only its hash */
  static const String appLockCodeHash = 'app_lock_code_hash';

  /* Keys of the former version of the application. Two of them were sensitive: the code of the
     application lock, stored in clear text, and a copy of every person and gift of the user. */
  static const List<String> legacyKeys = [
    'auth_jwt',
    'auth_email',
    'data_peoples',
    'data_gifts',
    'app_theme_mode',
    'app_lock_password',
  ];
}
