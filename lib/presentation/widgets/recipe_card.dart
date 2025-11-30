import 'package:flutter/material.dart';
import 'package:fruit_app/data/model/fruit_model.dart';
import 'package:fruit_app/data/model/recipe_model.dart';
import 'package:fruit_app/presentation/theme/app_colors.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final List<Fruit> recipeFruits;
  final Map<String, num> totalNutrition;
  final VoidCallback onDelete;

  const RecipeCard({
    super.key,
    required this.recipe,
    required this.recipeFruits,
    required this.totalNutrition,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: AppColors.yellow.withValues(alpha: 0.15),
      shadowColor: AppColors.yellow.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.grayBlue),
                  onPressed: onDelete,
                ),
              ],
            ),

            if (recipe.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  recipe.description,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),

            const SizedBox(height: 8),

            Text(
              "Состав: ${recipeFruits.map((f) => f.name).join(', ')}",
              style: const TextStyle(color: AppColors.textPrimary),
            ),

            const SizedBox(height: 8),

            Text("Калории: ${totalNutrition['calories']} kcal"),
            Text("Жиры: ${totalNutrition['fat']!.toStringAsFixed(1)} г"),
            Text("Сахар: ${totalNutrition['sugar']!.toStringAsFixed(1)} г"),
            Text("Углеводы: ${totalNutrition['carbohydrates']!.toStringAsFixed(1)} г"),
            Text("Белки: ${totalNutrition['protein']!.toStringAsFixed(1)} г"),
          ],
        ),
      ),
    );
  }
}