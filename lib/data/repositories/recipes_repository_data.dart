import 'package:fruit_app/data/local/recipes_storage.dart';
import 'package:fruit_app/data/model/recipe_model.dart';
import 'package:fruit_app/domain/repositories/recipes_repository.dart';

class RecipesRepositoryData implements RecipesRepository {
  @override
  Future<List<Recipe>> loadRecipes() => RecipesStorage.loadRecipes();

  @override
  Future<void> saveRecipes(List<Recipe> recipes) =>
      RecipesStorage.saveRecipes(recipes);
}