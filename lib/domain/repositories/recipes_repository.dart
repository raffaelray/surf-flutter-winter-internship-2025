import 'package:fruit_app/data/model/recipe_model.dart';

abstract class RecipesRepository {
  Future<List<Recipe>> loadRecipes();
  Future<void> saveRecipes(List<Recipe> recipes);
}