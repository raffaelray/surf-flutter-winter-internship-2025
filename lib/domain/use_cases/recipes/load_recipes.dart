import 'package:fruit_app/data/model/recipe_model.dart';
import 'package:fruit_app/domain/repositories/recipes_repository.dart';

class LoadRecipes {
  final RecipesRepository repository;

  LoadRecipes(this.repository);

  Future<List<Recipe>> call() => repository.loadRecipes();
}