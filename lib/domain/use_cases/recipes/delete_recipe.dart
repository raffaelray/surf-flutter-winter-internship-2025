import 'package:fruit_app/domain/repositories/recipes_repository.dart';

class DeleteRecipe {
  final RecipesRepository repository;

  DeleteRecipe(this.repository);

  Future<List> call(String id, List current) async {
    final updated = [...current]..removeWhere((r) => r.id == id);
    await repository.saveRecipes(updated.cast());
    return updated;
  }
}