import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fruit_app/data/model/recipe_model.dart';

class RecipesStorage {
  static const _key = 'saved_recipes';

  static Future<void> saveRecipes(List<Recipe> recipes) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = recipes.map((r) => json.encode(r.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<Recipe>> loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList
        .map((jsonStr) => Recipe.fromJson(json.decode(jsonStr)))
        .toList();
  }
}