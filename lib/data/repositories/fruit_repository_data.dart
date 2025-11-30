import 'package:fruit_app/data/api/fruit_api.dart';
import 'package:fruit_app/data/local/favorites_storage.dart';
import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/repositories/fruit_repository.dart';

class FruitRepositoryData implements FruitRepository {
  final FruitApi api;

  FruitRepositoryData({required this.api});

  @override
  Future<List<Fruit>> getAllFruits() => api.getAllFruits();

  @override
  Future<List<Fruit>> getFavorites() => FavoritesStorage.loadFavorites();

  @override
  Future<void> saveFavorites(List<Fruit> favorites) =>
      FavoritesStorage.saveFavorites(favorites);
}