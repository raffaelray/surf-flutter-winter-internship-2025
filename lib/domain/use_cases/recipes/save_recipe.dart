import 'package:fruit_app/data/model/recipe_model.dart';
import 'package:fruit_app/domain/repositories/recipes_repository.dart';

class SaveRecipe {
  final RecipesRepository repository;

  SaveRecipe(this.repository);

  Future<void> call(Recipe recipe, List<Recipe> current) async {
    final updated = [...current, recipe];
    await repository.saveRecipes(updated);
  }
}