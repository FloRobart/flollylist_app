class ApiConstants {
  // Remplacez par l'URL de votre API locale ou distante
  static const String baseUrlAuth = 'http://192.168.1.91:26001'; 
  static const String baseUrlData = 'http://192.168.1.91:26004';
  
  // Endpoints Users
  static const String loginRequest = '$baseUrlAuth/users/login/request';
  static const String loginConfirm = '$baseUrlAuth/users/login/confirm';
  static const String register = '$baseUrlAuth/users';
  static const String me = '$baseUrlAuth/users';
  
  // Endpoints Data
  static const String peoples = '$baseUrlData/peoples';
  static const String gifts = '$baseUrlData/gifts';
}