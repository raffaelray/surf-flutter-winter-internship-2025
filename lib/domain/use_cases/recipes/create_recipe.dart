import 'package:fruit_app/data/model/recipe_model.dart';
import 'package:fruit_app/domain/use_cases/recipes/save_recipe.dart';
import 'package:fruit_app/domain/use_cases/recipes/load_recipes.dart';

class CreateRecipeResult {
  final Recipe? recipe;
  final String? error;

  const CreateRecipeResult.success(this.recipe) : error = null;
  const CreateRecipeResult.error(this.error) : recipe = null;

  bool get isSuccess => recipe != null;
}

class CreateRecipe {
  final SaveRecipe saveRecipe;
  final LoadRecipes loadRecipes;

  CreateRecipe({
    required this.saveRecipe,
    required this.loadRecipes,
  });

  Future<CreateRecipeResult> call({
    required String title,
    required String description,
    required List<int> fruitIds,
    required List<Recipe> currentRecipes,
  }) async {
    if (title.trim().isEmpty) {
      return const CreateRecipeResult.error("Название рецепта обязательно");
    }
    if (fruitIds.isEmpty) {
      return const CreateRecipeResult.error("Выберите хотя бы один фрукт");
    }

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      fruitIds: fruitIds,
    );

    await saveRecipe(newRecipe, currentRecipes);

    final updated = await loadRecipes();

    return const CreateRecipeResult.success(null).copyWithRecipe(newRecipe, updated);
  }
}

extension on CreateRecipeResult {
  CreateRecipeResult copyWithRecipe(Recipe recipe, List<Recipe> updated) {
    return CreateRecipeResult.success(recipe);
  }
}