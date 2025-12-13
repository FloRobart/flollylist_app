import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // Les valeurs sont lues depuis le fichier .env au démarrage.
  static String get baseUrlAuth => dotenv.env['BASE_URL_AUTH'] ?? 'http://localhost:26001';
  static String get baseUrlData => dotenv.env['BASE_URL_DATA'] ?? 'http://localhost:26004';

  // Endpoints Users
  static String get loginRequest => '$baseUrlAuth/users/login/request';
  static String get loginConfirm => '$baseUrlAuth/users/login/confirm';
  static String get register => '$baseUrlAuth/users';
  static String get me => '$baseUrlAuth/users';

  // Endpoints Data
  static String get peoples => '$baseUrlData/peoples';
  static String get gifts => '$baseUrlData/gifts';
}
