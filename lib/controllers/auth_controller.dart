import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../core/storage_service.dart';
import '../models/user_profile_model.dart';

class AuthController with ChangeNotifier {
  final StorageService _storage = StorageService();
  String? _jwt;
  String? _tempToken; // Token reçu après la demande de login
  String? _currentUserEmail;
  bool _isLoading = false;

  bool get isAuthenticated => _jwt != null;
  bool get isLoading => _isLoading;
  String? get currentEmail => _currentUserEmail;

  UserProfile? _userProfile;
  UserProfile? get userProfile => _userProfile;

  // Extrait proprement un token JWT depuis diverses formes de réponse API
  String _extractToken(dynamic data) {
    if (data == null) return '';
    if (data is String) return data;
    if (data is Map) {
      if (data.containsKey('jwt')) return data['jwt'].toString();
      if (data.containsKey('token')) return data['token'].toString();
      if (data.containsKey('data')) {
        final d = data['data'];
        if (d is String) return d;
        if (d is Map) {
          if (d.containsKey('jwt')) return d['jwt'].toString();
          if (d.containsKey('token')) return d['token'].toString();
        }
      }
      // Fallback: trouver la première valeur chaîne utile
      for (final v in data.values) {
        if (v is String) return v;
        if (v is Map) {
          if (v.containsKey('jwt')) return v['jwt'].toString();
          if (v.containsKey('token')) return v['token'].toString();
        }
      }
      return data.toString();
    }
    return data.toString();
  }

  Future<void> checkLoginStatus() async {
    _jwt = await _storage.getJwt();
    _currentUserEmail = await _storage.getEmail();
    notifyListeners();
  }

  // 1. Demande de connexion ou Inscription
  Future<bool> requestLogin(String email, {String? pseudo}) async {
    _isLoading = true;
    notifyListeners();
    try {
      final isRegister = pseudo != null && pseudo.isNotEmpty;
      final url = Uri.parse(isRegister ? ApiConstants.register : ApiConstants.loginRequest);
      
      final body = isRegister 
          ? {'email': email, 'pseudo': pseudo}
          : {'email': email};

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Enregistrement de l'email pour usage futur
        await _storage.saveEmail(email);
        _currentUserEmail = email;
        
        final data = jsonDecode(response.body);
        final tokenExtracted = _extractToken(data);

        if (isRegister) {
          // CAS INSCRIPTION : L'API renvoie le JWT final (peut-être {"jwt":"..."})
          _jwt = tokenExtracted;
          await _storage.saveJwt(tokenExtracted);
        } else {
          // CAS CONNEXION : L'API renvoie un token temporaire pour la validation
          _tempToken = tokenExtracted;
        }
        
        return true;
      } else {
        print("Erreur Login Request: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Erreur Exception: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 2. Confirmation du code
  Future<bool> confirmLogin(String code) async {
    _isLoading = true;
    notifyListeners();
    try {
      final url = Uri.parse(ApiConstants.loginConfirm);
      final body = {
        'email': _currentUserEmail,
        'token': _tempToken,
        'secret': code, // Le code à 6 chiffres
        'ip': '127.0.0.1' // Valeur dummy ou récupérer l'IP réelle si nécessaire
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
         // L'API retourne le JWT directement ou dans un objet
        final data = jsonDecode(response.body);
        final token = _extractToken(data);

        _jwt = token;
        await _storage.saveJwt(token);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _storage.clearAuth();
    _jwt = null;
    notifyListeners();
  }

  // Récupérer les infos du profil (GET /users)
  Future<void> fetchProfile() async {
    if (_jwt == null) return;
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(ApiConstants.me), // '/users'
        headers: {'Authorization': 'Bearer $_jwt'},
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        _userProfile = UserProfile.fromJson(data);
        // On met à jour l'email stocké localement au cas où
        await _storage.saveEmail(_userProfile!.email);
      } else if (response.statusCode == 401 || response.statusCode == 404) {
        // Si l'API indique que l'utilisateur n'existe pas ou n'est pas autorisé,
        // on force la déconnexion locale (suppression du JWT) pour forcer la
        // redirection vers la page de login côté UI.
        await logout();
      } else {
        // Pour les autres erreurs, on se contente de logger
        print("Erreur fetchProfile (status ${response.statusCode}): ${response.body}");
      }
    } catch (e) {
      print("Erreur fetchProfile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Mettre à jour le profil (PUT /users)
  // Note: L'API demande 'email' et 'pseudo' dans le body selon UserUpdateSchema
  Future<bool> updateProfile(String newPseudo) async {
    if (_jwt == null || _userProfile == null) return false;
    _isLoading = true;
    notifyListeners();

    try {
      final body = {
        'email': _userProfile!.email, // L'email ne change pas mais est requis
        'pseudo': newPseudo,
      };

      final response = await http.put(
        Uri.parse(ApiConstants.me),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_jwt'
        },
        body: jsonEncode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // L'API peut renvoyer un nouveau token (JWTResponse) — on l'extrait et on le sauvegarde
        try {
          final data = jsonDecode(response.body);
          final newToken = _extractToken(data);
          if (newToken.isNotEmpty) {
            _jwt = newToken;
            await _storage.saveJwt(newToken);
          }
        } catch (e) {
          // Si le body n'est pas JSON ou n'a pas de token, on l'ignore
        }

        // Mise à jour de l'objet local pour l'affichage
        _userProfile = UserProfile(
          id: _userProfile!.id,
          email: _userProfile!.email,
          pseudo: newPseudo,
          isConnected: _userProfile!.isConnected,
          isVerifiedEmail: _userProfile!.isVerifiedEmail,
          createdAt: _userProfile!.createdAt,
        );
        return true;
      }
    } catch (e) {
      print("Erreur updateProfile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  // Déconnexion complète (POST /users/logout)
  Future<void> logoutServer() async {
    if (_jwt != null) {
      try {
        await http.post(
          Uri.parse('${ApiConstants.baseUrlAuth}/users/logout'),
          headers: {'Authorization': 'Bearer $_jwt'},
        );
      } catch (e) {
        // On ignore les erreurs serveur à la déconnexion, on déconnecte localement quoi qu'il arrive
      }
    }
    await logout(); // Méthode locale existante qui vide le storage
  }
}