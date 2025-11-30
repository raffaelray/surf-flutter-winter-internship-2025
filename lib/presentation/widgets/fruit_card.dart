import 'package:flutter/material.dart';
import 'package:fruit_app/presentation/theme/app_colors.dart';

class FruitCard extends StatelessWidget {
  final String name; // Название фрукта
  final String family; // Семейство
  final bool isFavorite; // В избранном или нет
  final VoidCallback onTap; // Открытие деталки
  final VoidCallback onToggleFavorite; // Изменение избранного

  const FruitCard({
    super.key,
    required this.name,
    required this.family,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.surface,
      shadowColor: AppColors.orange.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),

        title: Text(
          name,
          textAlign: TextAlign.center,              // ← центрируем
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        subtitle: Text(
          family,
          textAlign: TextAlign.center,             // ← тоже центрируем
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),

        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? AppColors.orange : AppColors.grayBlue,
            size: 28,
          ),
          onPressed: onToggleFavorite,
        ),

        onTap: onTap,
      ),
    );
  }
}