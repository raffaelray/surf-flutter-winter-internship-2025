import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/domain/repositories/fruit_repository.dart';

class GetAllFruits {
  final FruitRepository repository;

  GetAllFruits(this.repository);

  Future<List<Fruit>> call() => repository.getAllFruits();
}