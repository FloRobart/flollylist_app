import 'package:flutter/material.dart';
import '../core/storage_service.dart';

class ThemeController with ChangeNotifier {
  ThemeController() {
    _loadThemeMode();
  }

  final StorageService _storage = StorageService();
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  List<ThemeMode> get availableModes => const [ThemeMode.system, ThemeMode.light, ThemeMode.dark];
  String get currentLabel => labelForMode(_themeMode);

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    await _storage.saveThemeMode(_modeToString(mode));
  }

  String labelForMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Clair';
      case ThemeMode.dark:
        return 'Sombre';
      case ThemeMode.system:
      default:
        return 'Auto';
    }
  }

  Future<void> _loadThemeMode() async {
    final stored = await _storage.getThemeMode();
    if (stored == null) return;
    _themeMode = _stringToMode(stored);
    notifyListeners();
  }

  ThemeMode _stringToMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  String _modeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
      default:
        return 'system';
    }
  }
}
