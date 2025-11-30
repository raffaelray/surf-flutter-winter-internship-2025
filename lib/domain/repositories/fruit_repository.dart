import 'package:fruit_app/data/model/fruit_model.dart';

abstract class FruitRepository {
  Future<List<Fruit>> getAllFruits();
  Future<List<Fruit>> getFavorites();
  Future<void> saveFavorites(List<Fruit> favorites);
}