import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../core/storage_service.dart';
import '../models/people_model.dart';
import '../models/gift_model.dart';
import '../core/api_client.dart';

class DataController with ChangeNotifier {
  final ApiClient _api = ApiClient();
  final StorageService _storage = StorageService();
  List<People> _peoples = [];
  List<Gift> _gifts = [];
  bool _isLoading = false;

  List<People> get peoples => _peoples;
  
  // Helper pour organiser les données pour la vue
  // Retourne une map: { PeopleId: { Year: [Gifts] } }
  Map<int, Map<String, List<Gift>>> getGiftsByPeopleAndYear() {
    Map<int, Map<String, List<Gift>>> result = {};
    
    for (var people in _peoples) {
        result[people.id] = {};
        
        // Initialiser avec "Autre" par défaut ou vide
        // Filtrer les cadeaux pour cette personne
        var peopleGifts = _gifts.where((g) => g.personId == people.id).toList();
        
        for (var gift in peopleGifts) {
            String yearKey = gift.year != null ? gift.year.toString() : "Autre";
            if (!result[people.id]!.containsKey(yearKey)) {
                result[people.id]![yearKey] = [];
            }
            result[people.id]![yearKey]!.add(gift);
        }
    }
    return result;
  }

  Future<void> initData() async {
    _isLoading = true;
    notifyListeners();
    
    // 1. Charger depuis le cache local
    _peoples = await _storage.getPeoples();
    _gifts = await _storage.getGifts();
    notifyListeners();

    // 2. Fetch API si token dispo
    final jwt = await _storage.getJwt();
    if (jwt != null) {
        await fetchData(jwt);
    }
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchData(String jwt) async {
    try {
      // L'appel est beaucoup plus propre
      final dataPeople = await _api.get(ApiConstants.peoples);
      if (dataPeople != null) {
        _peoples = (dataPeople as List).map((json) => People.fromJson(json)).toList();
        await _storage.savePeoples(_peoples);
      }

      final dataGifts = await _api.get(ApiConstants.gifts);
      if (dataGifts != null) {
        _gifts = (dataGifts as List).map((json) => Gift.fromJson(json)).toList();
        await _storage.saveGifts(_gifts);
      }
      
      notifyListeners();
    } catch (e) {
      print("Erreur sync: $e");
    }
  }

  // --- CRUD Peoples ---
  Future<bool> addPeople(Map<String, dynamic> data) async {
    final jwt = await _storage.getJwt();
    if (jwt == null) return false;

    // Mapping pour l'API (basé sur peoples.schema.ts)
    final apiBody = {
      'first_name': data['first_name'],
      'last_name': data['last_name'],
      'date_of_birth': data['date_of_birth'],
    };

    try {
      final response = await _api.post(ApiConstants.peoples, body: apiBody);
      // Le client a déjà décodé le JSON et vérifié les erreurs (throw si != 2xx)
      final newPeople = People.fromJson(response);
      _peoples.add(newPeople);
      await _storage.savePeoples(_peoples);
      notifyListeners();
      return true;
    } catch (e) {
      print("Erreur addPeople: $e");
      return false;
    }
  }

  Future<bool> updatePeople(int id, Map<String, dynamic> data) async {
    final jwt = await _storage.getJwt();
    if (jwt == null) return false;

    final apiBody = {
      'first_name': data['first_name'],
      'last_name': data['last_name'],
      'date_of_birth': data['date_of_birth'],
      'user_id': 1,
    };

    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.peoples}/$id'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
        body: jsonEncode(apiBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final index = _peoples.indexWhere((p) => p.id == id);
        if (index != -1) {
          _peoples[index] = People.fromJson(jsonDecode(response.body));
          await _storage.savePeoples(_peoples);
          notifyListeners();
        }
        return true;
      }
    } catch (e) {
      print("Erreur updatePeople: $e");
    }
    return false;
  }

  Future<void> deletePeople(int id) async {
    final jwt = await _storage.getJwt();
    if (jwt == null) return;
    
    // Optimiste : on supprime localement tout de suite pour la réactivité
    final backup = List<People>.from(_peoples);
    _peoples.removeWhere((p) => p.id == id);
    _gifts.removeWhere((g) => g.personId == id); // Nettoyage cascade local
    notifyListeners();

    try {
      final response = await http.delete(
        Uri.parse('${ApiConstants.peoples}/$id'),
        headers: {'Authorization': 'Bearer $jwt'},
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
         await _storage.savePeoples(_peoples);
         await _storage.saveGifts(_gifts);
      } else {
        // Rollback si échec
        _peoples = backup;
        notifyListeners();
      }
    } catch (e) {
      _peoples = backup;
      notifyListeners();
    }
  }

  // --- CRUD Gifts ---
  Future<bool> addGift(Map<String, dynamic> data) async {
    final jwt = await _storage.getJwt();
    if (jwt == null) return false;

    final apiBody = {
      'gift_name': data['name'],
      'gift_description': data['description'],
      'gift_year': data['year'],
      'link': data['link'],
      'price': data['price'],
      'people_id': data['people_id'],
    };

    try {
      final response = await http.post(
        Uri.parse(ApiConstants.gifts),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
        body: jsonEncode(apiBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final newGift = Gift.fromJson(jsonDecode(response.body));
        _gifts.add(newGift);
        await _storage.saveGifts(_gifts);
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("Erreur addGift: $e");
    }
    return false;
  }

  Future<bool> updateGift(int id, Map<String, dynamic> data) async {
    final jwt = await _storage.getJwt();
    if (jwt == null) return false;

    final apiBody = {
      'gift_name': data['name'],
      'gift_description': data['description'],
      'gift_year': data['year'],
      'link': data['link'],
      'price': data['price'],
      'people_id': data['people_id'],
    };

    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.gifts}/$id'),
        headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwt'},
        body: jsonEncode(apiBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final index = _gifts.indexWhere((g) => g.id == id);
        if (index != -1) {
          _gifts[index] = Gift.fromJson(jsonDecode(response.body));
          await _storage.saveGifts(_gifts);
          notifyListeners();
        }
        return true;
      }
    } catch (e) {
      print("Erreur updateGift: $e");
    }
    return false;
  }
  
  Future<void> deleteGift(int id) async {
     final jwt = await _storage.getJwt();
     if(jwt == null) return;
     
     final backup = List<Gift>.from(_gifts);
     _gifts.removeWhere((g) => g.id == id);
     notifyListeners();
     
     try {
       final response = await http.delete(
         Uri.parse('${ApiConstants.gifts}/$id'),
         headers: {'Authorization': 'Bearer $jwt'},
       );
       if(response.statusCode >= 200 && response.statusCode < 300) {
         await _storage.saveGifts(_gifts);
       } else {
         _gifts = backup;
         notifyListeners();
       }
     } catch (e) {
       _gifts = backup;
       notifyListeners();
     }
  }
}