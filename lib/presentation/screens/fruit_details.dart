import 'package:flutter/material.dart';
import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:provider/provider.dart';
import 'package:fruit_app/presentation/state/fruits_state.dart';
import 'package:fruit_app/presentation/theme/app_colors.dart';

class FruitDetailsScreen extends StatelessWidget {
  final Fruit fruit; // передаём фрукт из списка

  const FruitDetailsScreen({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FruitsState>();
    final isFav = state.isFavorite(fruit);

    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Family: ${fruit.family}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Genus: ${fruit.genus}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Order: ${fruit.order}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            const Text('Nutrition:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Calories: ${fruit.nutritions.calories} kcal'),
            Text('Fat: ${fruit.nutritions.fat} g'),
            Text('Sugar: ${fruit.nutritions.sugar} g'),
            Text('Carbohydrates: ${fruit.nutritions.carbohydrates} g'),
            Text('Protein: ${fruit.nutritions.protein} g'),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: 54,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: isFav ? AppColors.orange : AppColors.blue,
                foregroundColor: isFav ? Colors.white : Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                state.toggleFavorite(fruit);
              },
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                size: 28,
              ),
              label: Text(
                isFav ? 'Убрать из избранного' : 'Добавить в избранное',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),

    );
  }
}