import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MainProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const MainProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                widthFactor: currentStep / totalSteps,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '$currentStep/$totalSteps',
          style: const TextStyle(color: AppColors.greyText, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}