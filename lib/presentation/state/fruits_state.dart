import 'package:flutter/material.dart';
import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/use_cases/sort_option.dart';
import 'package:fruit_app/domain/use_cases/fruits/get_all_fruits.dart';
import 'package:fruit_app/domain/use_cases/favorites/get_favorites.dart';
import 'package:fruit_app/domain/use_cases/favorites/save_favorites.dart';
import 'package:fruit_app/domain/use_cases/favorites/toggle_favorite.dart';
import 'package:fruit_app/domain/use_cases/fruits/filter_fruits.dart';
import 'package:fruit_app/domain/use_cases/fruits/sort_fruits.dart';

enum LoadStatus { loading, loaded, error }

class FruitsState extends ChangeNotifier {
  final GetAllFruits getAllFruits;
  final GetFavorites getFavorites;
  final SaveFavorites saveFavorites;
  final ToggleFavorite toggleFavoriteUseCase;
  final FilterFruits filterFruits;
  final SortFruits sortFruits;
  bool isFavorite(Fruit fruit) => favorites.any((f) => f.id == fruit.id);

  LoadStatus status = LoadStatus.loading;

  List<Fruit> all = [];
  List<Fruit> filtered = [];
  List<Fruit> favorites = [];

  SortOption? sortOption;
  Map<String, bool> filterOptions = {
    'Завтрак': false,
    'Тренировка': false,
    'Сытость': false,
    'Перекус': false,
    'Диета': false,
  };

  FruitsState({
    required this.getAllFruits,
    required this.getFavorites,
    required this.saveFavorites,
    required this.toggleFavoriteUseCase,
    required this.filterFruits,
    required this.sortFruits,
  });

  Future<void> load() async {
    status = LoadStatus.loading;
    notifyListeners();

    try {
      all = await getAllFruits();
      favorites = await getFavorites();

      sortOption = SortOption.nameAsc;
      applyFiltersAndSort();

      status = LoadStatus.loaded;
      notifyListeners();
    } catch (_) {
      status = LoadStatus.error;
      notifyListeners();
    }
  }

  void applyFiltersAndSort() {
    // domain use-cases do the actual work
    filtered = filterFruits(all, filterOptions);
    filtered = sortFruits(filtered, sortOption);
    notifyListeners();
  }

  Future<void> toggleFavorite(Fruit fruit) async {
    favorites = toggleFavoriteUseCase(favorites, fruit);
    await saveFavorites(favorites);
    notifyListeners();
  }

  void updateSortAndFilters({
    SortOption? sort,
    Map<String, bool>? filters,
  }) {
    if (sort != null) sortOption = sort;
    if (filters != null) filterOptions = filters;

    applyFiltersAndSort();
  }
}