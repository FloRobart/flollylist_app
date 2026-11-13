/// Constantes de l'application. Les limites reprennent celles de l'API (hollylist-api), pour
/// qu'un formulaire refuse ce que l'API refuserait.
class Constantes {
  /* People */
  static const int maxNameLength = 255;
  static final DateTime oldestDateOfBirth = DateTime(1900);

  /* Gifts */
  static const int maxGiftNameLength = 255;
  static const int maxGiftDescriptionLength = 2000;
  static const int maxGiftLinkLength = 2048;
  static const double maxGiftPrice = 9999999999.99;
  static const int minGiftYear = 1900;
  static const int maxGiftYear = 2200;

  /* Login: the code sent by email by Floraccess, made of capital letters and digits */
  static const int loginCodeLength = 6;

  /* Profile: the limits of a pseudo at Floraccess */
  static const int minPseudoLength = 3;
  static const int maxPseudoLength = 255;

  /* App lock */
  static const int minAppLockCodeLength = 4;
  static const int maxAppLockCodeLength = 12;
}
