import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart'; 

class OnboardingBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Row(
        mainAxisSize: MainAxisSize.min, 
        children: [
          Icon(Icons.arrow_back, size: 16, color: AppColors.greyText),
          SizedBox(width: 4),
          Text(
            'Back',
            style: TextStyle(color: AppColors.greyText, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}