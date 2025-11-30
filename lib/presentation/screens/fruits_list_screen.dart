import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_app/presentation/state/fruits_state.dart';
import 'package:fruit_app/presentation/screens/sort_screen.dart';
import 'package:fruit_app/presentation/screens/fruit_details.dart';
import 'package:fruit_app/presentation/widgets/fruit_card.dart';
import 'package:fruit_app/presentation/widgets/async_state_widget.dart';

class FruitsListScreen extends StatelessWidget {
  const FruitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FruitsListBody(),
    );
  }
}

class FruitsListBody extends StatelessWidget {
  const FruitsListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FruitsState>();

    final fruits = state.filtered;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Фрукты'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SortScreen(
                    selectedSort: state.sortOption,
                    selectedFilters: state.filterOptions,
                  ),
                ),
              );

              if (result != null) {
                state.updateSortAndFilters(
                  sort: result['sort'],
                  filters: result['filters'],
                );
              }
            },
          ),
        ],
      ),
      body: AsyncStateWidget(
        isLoading: state.status == LoadStatus.loading,
        isError: state.status == LoadStatus.error,
        isEmpty: fruits.isEmpty,
        onRetry: () => state.load(),
        emptyWidget: const Center(
          child: Text("Нет фруктов"),
        ),
        child: ListView.builder(
          itemCount: fruits.length,
          itemBuilder: (context, index) {
            final fruit = fruits[index];
            final isFav = state.isFavorite(fruit);
            return FruitCard(
              name: fruit.name,
              family: fruit.family,
              isFavorite: isFav,
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
        ));
  }
}