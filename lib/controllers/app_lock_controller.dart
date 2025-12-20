import 'package:flutter/foundation.dart';

import '../core/storage_service.dart';

class AppLockController extends ChangeNotifier {
  AppLockController({StorageService? storageService})
      : _storageService = storageService ?? StorageService() {
    _loadPassword();
  }

  final StorageService _storageService;
  bool _isLoading = true;
  bool _isUnlocked = false;
  String? _storedPassword;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isUnlocked => _isUnlocked;
  bool get needsSetup => _storedPassword == null;
  String? get errorMessage => _errorMessage;

  Future<void> _loadPassword() async {
    _storedPassword = await _storageService.getAppPassword();
    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> submitPassword(String rawInput) async {
    final password = rawInput.trim();
    if (password.isEmpty) {
      _setError('Le mot de passe est requis.');
      return;
    }
    if (password.length > 255) {
      _setError('Maximum 255 chiffres.');
      return;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(password)) {
      _setError('Utilise uniquement des chiffres.');
      return;
    }

    if (_storedPassword == null) {
      await _storageService.saveAppPassword(password);
      _storedPassword = password;
      _unlock();
      return;
    }

    if (password == _storedPassword) {
      _unlock();
    } else {
      _setError('Mot de passe incorrect.');
    }
  }

  void lock() {
    if (!_isUnlocked) return;
    _isUnlocked = false;
    notifyListeners();
  }

  void _unlock() {
    _errorMessage = null;
    _isUnlocked = true;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
