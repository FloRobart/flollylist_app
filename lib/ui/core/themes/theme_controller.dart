import 'package:flollylist_app/config/shared_preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider du contrôleur de thème (persistant via SharedPreferences).
final themeControllerProvider =
    AsyncNotifierProvider<ThemeController, ThemeMode>(ThemeController.new);

/// Gestionnaire de thème en MVVM (état + persistance).
class ThemeController extends AsyncNotifier<ThemeMode> {
  static const String _key = SharedPreferencesKeys.themeMode;

  @override
  Future<ThemeMode> build() async {
    // Chargement initial depuis le stockage local.
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(_key) ?? 'system';
    return _fromString(stored);
  }

  /// Change le thème et persiste la valeur.
  Future<void> setMode(ThemeMode mode) async {
    state = AsyncData(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }

  ThemeMode _fromString(String value) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
