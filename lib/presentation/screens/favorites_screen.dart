import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_app/presentation/state/fruits_state.dart';
import 'package:fruit_app/presentation/widgets/fruit_card.dart';
import 'package:fruit_app/presentation/screens/fruit_details.dart';
import 'package:fruit_app/presentation/widgets/async_state_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FruitsState>();

    final favoriteFruits = state.favorites;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Избранное')),
      body: AsyncStateWidget(
        isLoading: state.status == LoadStatus.loading,
        isError: state.status == LoadStatus.error,
        isEmpty: favoriteFruits.isEmpty,
        onRetry: () => state.load(),
        emptyWidget: const Center(
          child: Text('Вы пока ничего не добавили в избранное'),
        ),
        child: ListView.builder(
          itemCount: favoriteFruits.length,
          itemBuilder: (context, index) {
            final fruit = favoriteFruits[index];
            return FruitCard(
              name: fruit.name,
              family: fruit.family,
              isFavorite: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FruitDetailsScreen(fruit: fruit),
                  ),
                );
              },
              onToggleFavorite: () => state.toggleFavorite(fruit),
            );
          },
        ),
      ),

    );
  }
}