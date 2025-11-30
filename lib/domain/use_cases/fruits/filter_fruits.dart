import 'package:fruit_app/data/model/fruit_model.dart';

class FilterFruits {
  List<Fruit> call(List<Fruit> fruits, Map<String, bool> filters) {
    var result = [...fruits];

    if (filters['Завтрак'] == true) {
      result = result.where((f) =>
        f.nutritions.calories >= 40 &&
        f.nutritions.calories <= 80 &&
        f.nutritions.carbohydrates >= 10 &&
        f.nutritions.sugar <= 12 &&
        f.nutritions.fat <= 0.5
      ).toList();
    }
    if (filters['Тренировка'] == true) {
      result = result.where((f) =>
        f.nutritions.calories >= 50 &&
        f.nutritions.calories <= 100 &&
        f.nutritions.carbohydrates >= 12 &&
        f.nutritions.fat <= 0.3
      ).toList();
    }
    if (filters['Сытость'] == true) {
      result = result.where((f) =>
        f.nutritions.calories >= 50 &&
        f.nutritions.calories <= 90 &&
        f.nutritions.carbohydrates >= 10 &&
        f.nutritions.carbohydrates <= 15 &&
        f.nutritions.sugar <= 10 &&
        f.nutritions.protein >= 0.5
      ).toList();
    }
    if (filters['Перекус'] == true) {
      result = result.where((f) =>
        f.nutritions.calories <= 50 &&
        f.nutritions.sugar <= 7 &&
        f.nutritions.fat <= 0.4
      ).toList();
    }
    if (filters['Диета'] == true) {
      result = result.where((f) =>
        f.nutritions.calories <= 40 &&
        f.nutritions.sugar <= 6 &&
        f.nutritions.fat <= 0.3
      ).toList();
    }

    return result;
  }
}