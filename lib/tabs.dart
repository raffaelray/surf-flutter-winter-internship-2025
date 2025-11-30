import 'package:flutter/material.dart';
import 'package:fruit_app/presentation/screens/fruits_list_screen.dart';
import 'package:fruit_app/presentation/screens/favorites_screen.dart';
import 'package:fruit_app/presentation/screens/recipes_screen.dart';
import 'package:fruit_app/presentation/theme/app_colors.dart';
import 'package:fruit_app/presentation/theme/app_theme.dart';

/// Основной виджет
class FruitApp extends StatelessWidget {
  const FruitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainTabs(),
    );
  }
}

/// Главный экран с табами: Фрукты, Избранное, Рецепты
class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _currentIndex = 0; // Индекс выбранной вкладки

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          FruitsListScreen(),
          FavoritesScreen(),
          RecipesScreen(), 
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.grayBlue,
        showUnselectedLabels: true,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: 'Фрукты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Рецепты',
          ),
        ],
      ),
    );
  }
}
