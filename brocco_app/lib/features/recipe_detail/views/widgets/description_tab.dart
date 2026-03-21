import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DescriptionTab extends StatelessWidget {
  final String? description;

  const DescriptionTab({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    if (description == null || description!.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Brak opisu',
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
        border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.4)),
      ),
      child: Text(
        description!,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontSize: 15,
          height: 1.6,
        ),
      ),
    );
  }
}
