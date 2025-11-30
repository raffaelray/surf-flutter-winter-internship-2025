import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/use_cases/sort_option.dart';

class SortFruits {
  List<Fruit> call(List<Fruit> fruits, SortOption? option) {
    if (option == null) return fruits;
    final result = [...fruits];

    switch (option) {
      case SortOption.nameAsc:
        result.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.nameDesc:
        result.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOption.caloriesAsc:
        result.sort((a, b) => a.nutritions.calories.compareTo(b.nutritions.calories));
        break;
      case SortOption.caloriesDesc:
        result.sort((a, b) => b.nutritions.calories.compareTo(a.nutritions.calories));
        break;
    }

    return result;
  }
}