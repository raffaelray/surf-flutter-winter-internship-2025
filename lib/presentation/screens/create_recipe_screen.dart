import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fruit_app/presentation/state/fruits_state.dart';
import 'package:fruit_app/presentation/state/recipes_state.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({super.key});

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final Set<int> _selectedFruitIds = {};

  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final fruitsState = context.watch<FruitsState>();
    final recipesState = context.read<RecipesState>();

    final favoriteFruits = fruitsState.favorites;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Создание рецепта'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Название рецепта'),
              const SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Введите название",
                ),
              ),

              const SizedBox(height: 20),

              const Text('Описание (необязательно)'),
              const SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Описание рецепта",
                ),
              ),

              const SizedBox(height: 20),

              const Text('Добавьте фрукты в рецепт'),
              const SizedBox(height: 8),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: favoriteFruits.length,
                itemBuilder: (context, index) {
                  final fruit = favoriteFruits[index];
                  final isSelected = _selectedFruitIds.contains(fruit.id);

                  return CheckboxListTile(
                    title: Text(fruit.name),
                    value: isSelected,
                    onChanged: (v) {
                      setState(() {
                        if (v == true) {
                          _selectedFruitIds.add(fruit.id);
                        } else {
                          _selectedFruitIds.remove(fruit.id);
                        }
                      });
                    },
                  );
                },
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _isSaving
                ? null
                : () async {
                    setState(() => _isSaving = true);

                    final error = await recipesState.createRecipe(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      fruitIds: _selectedFruitIds.toList(),
                    );

                    setState(() => _isSaving = false);

                    if (!mounted) return;
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                      return;
                    }

                    Navigator.pop(context);
                  },
            child: _isSaving
                ? const CircularProgressIndicator()
                : const Text("Сохранить"),
          ),
        ),
      ),
    );
  }
}