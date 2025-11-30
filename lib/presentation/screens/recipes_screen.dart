import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_app/presentation/state/recipes_state.dart';
import 'package:fruit_app/presentation/screens/create_recipe_screen.dart';
import 'package:fruit_app/presentation/state/fruits_state.dart';
import 'package:fruit_app/domain/use_cases/recipes/calculate_nutrition.dart';
import 'package:fruit_app/presentation/widgets/async_state_widget.dart';
import 'package:fruit_app/presentation/widgets/recipe_card.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesState = context.watch<RecipesState>();
    final fruitsState = context.watch<FruitsState>();

    final recipes = recipesState.recipes;
    final fruits = fruitsState.all;

    final isLoading =
      recipesState.status == RecipesStatus.loading ||
      fruitsState.status == LoadStatus.loading;

    final isError =
      recipesState.status == RecipesStatus.error ||
      fruitsState.status == LoadStatus.error;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateRecipeScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: AsyncStateWidget(
        isLoading: isLoading,
        isError: isError,
        isEmpty: recipes.isEmpty,
        onRetry: () {
          recipesState.load();
          fruitsState.load();
        },
        emptyWidget: const Center(
          child: Text('Создайте свой первый рецепт'),
        ),
        child: ListView.builder(
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final recipe = recipes[index];
            final recipeFruits = recipesState.getFruitsForRecipe(recipe, fruits);
            final totalNutrition = CalculateNutrition()(recipeFruits);

            return RecipeCard(
              recipe: recipe,
              recipeFruits: recipeFruits,
              totalNutrition: totalNutrition,
              onDelete: () => recipesState.deleteRecipeById(recipe.id),
            );
          },
        ),
    ));
  }
}