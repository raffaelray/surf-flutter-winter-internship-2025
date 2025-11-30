import 'package:flutter/material.dart';
import 'package:fruit_app/data/model/recipe_model.dart';
import 'package:fruit_app/domain/use_cases/recipes/load_recipes.dart';
import 'package:fruit_app/domain/use_cases/recipes/save_recipe.dart';
import 'package:fruit_app/domain/use_cases/recipes/delete_recipe.dart';
import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/use_cases/recipes/create_recipe.dart';

enum RecipesStatus { loading, loaded, error }

class RecipesState extends ChangeNotifier {
  final LoadRecipes loadRecipes;
  final SaveRecipe saveRecipe;
  final DeleteRecipe deleteRecipe;
  final CreateRecipe createRecipeUseCase;

  RecipesStatus status = RecipesStatus.loading;

  List<Recipe> recipes = [];

  RecipesState({
    required this.loadRecipes,
    required this.saveRecipe,
    required this.deleteRecipe,
    required this.createRecipeUseCase,
  });

  Future<void> load() async {
    status = RecipesStatus.loading;
    notifyListeners();

    try {
      recipes = await loadRecipes();
      status = RecipesStatus.loaded;
      notifyListeners();
    } catch (_) {
      status = RecipesStatus.error;
      notifyListeners();
    }
  }

  Future<void> addRecipe(Recipe recipe) async {
    await saveRecipe(recipe, recipes);
    recipes = await loadRecipes();
    notifyListeners();
  }

  Future<void> deleteRecipeById(String id) async {
    await deleteRecipe(id, recipes);
    recipes = await loadRecipes();
    notifyListeners();
  }

  Future<String?> createRecipe({
    required String title,
    required String description,
    required List<int> fruitIds,
  }) async {
    final result = await createRecipeUseCase(
      title: title,
      description: description,
      fruitIds: fruitIds,
      currentRecipes: recipes,
    );

    if (!result.isSuccess) {
      return result.error;
    }

    recipes = await loadRecipes();
    notifyListeners();
    return null;
  }

  List<Fruit> getFruitsForRecipe(Recipe recipe, List<Fruit> allFruits) {
    return allFruits.where((f) => recipe.fruitIds.contains(f.id)).toList();
  }
}