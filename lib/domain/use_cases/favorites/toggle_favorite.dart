import 'package:fruit_app/data/model/fruit_model.dart';

class ToggleFavorite {
  List<Fruit> call(List<Fruit> current, Fruit fruit) {
    final updated = [...current];
    final exists = updated.any((f) => f.id == fruit.id);

    if (exists) {
      updated.removeWhere((f) => f.id == fruit.id);
    } else {
      updated.add(fruit);
    }

    return updated;
  }
}