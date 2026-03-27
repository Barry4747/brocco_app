import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'pushable_3d_button.dart';

class OnboardingBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const OnboardingBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Pushable3DButton(
      onPressed: onTap,
      backgroundColor: Colors.white,
      shadowColor: AppColors.accentGreen,
      shadowOffset: 4.0,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.accentGreen, width: 2.0),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: AppColors.primaryText,
          ),
          SizedBox(width: 8),
          Text(
            'Wstecz',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
