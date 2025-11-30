import 'package:fruit_app/data/model/fruit_model.dart';

class CalculateNutrition {
  Map<String, num> call(List<Fruit> fruits) {
    final result = {
      'calories': 0,
      'fat': 0.0,
      'sugar': 0.0,
      'carbohydrates': 0.0,
      'protein': 0.0,
    };

    for (final f in fruits) {
      result['calories'] = result['calories']! + f.nutritions.calories;
      result['fat'] = result['fat']! + f.nutritions.fat;
      result['sugar'] = result['sugar']! + f.nutritions.sugar;
      result['carbohydrates'] =
          result['carbohydrates']! + f.nutritions.carbohydrates;
      result['protein'] = result['protein']! + f.nutritions.protein;
    }

    return result;
  }
}