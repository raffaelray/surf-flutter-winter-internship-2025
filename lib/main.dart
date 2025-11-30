import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_app/tabs.dart';

// data
import 'package:fruit_app/data/api/fruit_api.dart';
import 'package:fruit_app/data/repositories/fruit_repository_data.dart';
import 'package:fruit_app/data/repositories/recipes_repository_data.dart';

// domain use-cases
import 'package:fruit_app/domain/use_cases/fruits/get_all_fruits.dart';
import 'package:fruit_app/domain/use_cases/favorites/get_favorites.dart';
import 'package:fruit_app/domain/use_cases/favorites/save_favorites.dart';
import 'package:fruit_app/domain/use_cases/favorites/toggle_favorite.dart';
import 'package:fruit_app/domain/use_cases/fruits/filter_fruits.dart';
import 'package:fruit_app/domain/use_cases/fruits/sort_fruits.dart';

import 'package:fruit_app/domain/use_cases/recipes/load_recipes.dart';
import 'package:fruit_app/domain/use_cases/recipes/save_recipe.dart';
import 'package:fruit_app/domain/use_cases/recipes/delete_recipe.dart';
import 'package:fruit_app/domain/use_cases/recipes/create_recipe.dart';

// presentation
import 'package:fruit_app/presentation/state/fruits_state.dart';
import 'package:fruit_app/presentation/state/recipes_state.dart';

void main() {
  // data layer
  final fruitApi = FruitApi();
  final fruitRepo = FruitRepositoryData(api: fruitApi);
  final recipesRepo = RecipesRepositoryData();

  // domain use-cases
  final getAllFruits = GetAllFruits(fruitRepo);
  final getFavorites = GetFavorites(fruitRepo);
  final saveFavorites = SaveFavorites(fruitRepo);
  final toggleFavorite = ToggleFavorite();
  final filterFruits = FilterFruits();
  final sortFruits = SortFruits();

  final loadRecipes = LoadRecipes(recipesRepo);
  final saveRecipe = SaveRecipe(recipesRepo);
  final deleteRecipe = DeleteRecipe(recipesRepo);
  final createRecipe = CreateRecipe(saveRecipe: saveRecipe, loadRecipes: loadRecipes);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FruitsState(
            getAllFruits: getAllFruits,
            getFavorites: getFavorites,
            saveFavorites: saveFavorites,
            toggleFavoriteUseCase: toggleFavorite,
            filterFruits: filterFruits,
            sortFruits: sortFruits
          )..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecipesState(
            loadRecipes: loadRecipes,
            saveRecipe: saveRecipe,
            deleteRecipe: deleteRecipe,
            createRecipeUseCase: createRecipe
          )..load(),
        ),
      ],
      child: const FruitApp(),
    ),
  );
}