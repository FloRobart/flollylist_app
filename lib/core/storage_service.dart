import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/people_model.dart';
import '../models/gift_model.dart';

class StorageService {
  static const String _keyJwt = 'auth_jwt';
  static const String _keyEmail = 'auth_email';
  static const String _keyPeoples = 'data_peoples';
  static const String _keyGifts = 'data_gifts';
  static const String _keyThemeMode = 'app_theme_mode';

  Future<void> saveJwt(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyJwt, token);
  }

  Future<String?> getJwt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyJwt);
  }

  Future<void> clearAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyJwt);
    // On garde l'email pour le pré-remplissage
  }

  Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEmail, email);
  }

  Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail);
  }

  // Cache Data
  Future<void> savePeoples(List<People> peoples) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(peoples.map((e) => e.toJson()).toList());
    await prefs.setString(_keyPeoples, encoded);
  }

  Future<List<People>> getPeoples() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(_keyPeoples);
    if (encoded == null) return [];
    final List<dynamic> decoded = jsonDecode(encoded);
    return decoded.map((e) => People.fromJson(e)).toList();
  }

  Future<void> saveGifts(List<Gift> gifts) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(gifts.map((e) => e.toJson()).toList());
    await prefs.setString(_keyGifts, encoded);
  }

  Future<List<Gift>> getGifts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encoded = prefs.getString(_keyGifts);
    if (encoded == null) return [];
    final List<dynamic> decoded = jsonDecode(encoded);
    return decoded.map((e) => Gift.fromJson(e)).toList();
  }

  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyThemeMode, mode);
  }

  Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyThemeMode);
  }
}