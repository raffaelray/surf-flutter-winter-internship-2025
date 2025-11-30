import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/repositories/fruit_repository.dart';

class GetFavorites {
  final FruitRepository repository;

  GetFavorites(this.repository);

  Future<List<Fruit>> call() => repository.getFavorites();
}