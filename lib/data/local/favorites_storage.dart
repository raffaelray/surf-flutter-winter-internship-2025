import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fruit_app/data/model/fruit_model.dart';

class FavoritesStorage {
  static const _key = 'favorite_fruits';

  static Future<void> saveFavorites(List<Fruit> fruits) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = fruits.map((f) => json.encode(f.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<Fruit>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList
        .map((jsonStr) => Fruit.fromJson(json.decode(jsonStr)))
        .toList();
  }
}