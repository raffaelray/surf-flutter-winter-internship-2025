import 'package:flutter/material.dart';
import 'package:fruit_app/domain/use_cases/sort_option.dart';

class SortScreen extends StatefulWidget {
  final SortOption? selectedSort;
  final Map<String, bool> selectedFilters;

  const SortScreen({
    super.key,
    required this.selectedSort,
    required this.selectedFilters,
  });

  @override
  State<SortScreen> createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen> {
  late SortOption? selectedSort;
  late Map<String, bool> filters;

  @override
  void initState() {
    super.initState();
    selectedSort = widget.selectedSort;
    filters = Map.from(widget.selectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Фильтры')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Сортировка', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            SegmentedButton<SortOption>(
              emptySelectionAllowed: true,
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(
                  value: SortOption.nameAsc,
                  label: Text('Имя A-Z'),
                ),
                ButtonSegment(
                  value: SortOption.nameDesc,
                  label: Text('Имя Z-A'),
                ),
                ButtonSegment(
                  value: SortOption.caloriesAsc,
                  label: Text('Ккал ↑'),
                ),
                ButtonSegment(
                  value: SortOption.caloriesDesc,
                  label: Text('Ккал ↓'),
                ),
              ],
              selected: selectedSort == null ? {} : {selectedSort!},
              onSelectionChanged: (newSet) {
                setState(() {
                  selectedSort = newSet.isEmpty ? null : newSet.first;
                });
              },
            ),

            const SizedBox(height: 24),
            const Text('Фильтры', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                children: filters.keys.map((key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: filters[key],
                    onChanged: (v) {
                      setState(() => filters[key] = v ?? false);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'sort': selectedSort,
                'filters': filters,
              });
            },
            child: const Text("Применить"),
          ),
        ),
      ),
    );
  }
}