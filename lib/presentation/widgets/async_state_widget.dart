import 'package:flutter/material.dart';
import 'package:fruit_app/presentation/theme/app_colors.dart';

class AsyncStateWidget extends StatelessWidget {
  final bool isLoading;
  final bool isError;
  final bool isEmpty;
  final VoidCallback? onRetry;
  final Widget child;
  final Widget? emptyWidget;

  const AsyncStateWidget({
    super.key,
    required this.isLoading,
    required this.isError,
    required this.isEmpty,
    required this.child,
    this.onRetry,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Произошла ошибка',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: 160,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                ),
                onPressed: onRetry,
                child: const Text('Перезагрузить', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      );
    }

    if (isEmpty) {
      return emptyWidget ??
          const Center(
            child: Text("Ничего нет"),
          );
    }

    return child;
  }
}