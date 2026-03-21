import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RecipeTab extends StatelessWidget {
  final String? recipePlaintext;

  const RecipeTab({super.key, this.recipePlaintext});

  @override
  Widget build(BuildContext context) {
    if (recipePlaintext == null || recipePlaintext!.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Brak przepisu',
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentGreen.withOpacity(0.4)),
      ),
      child: Text(
        recipePlaintext!,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontSize: 15,
          height: 1.6,
        ),
      ),
    );
  }
}
