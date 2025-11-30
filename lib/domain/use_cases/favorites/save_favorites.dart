import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/repositories/fruit_repository.dart';

class SaveFavorites {
  final FruitRepository repository;

  SaveFavorites(this.repository);

  Future<void> call(List<Fruit> favorites) => repository.saveFavorites(favorites);
}