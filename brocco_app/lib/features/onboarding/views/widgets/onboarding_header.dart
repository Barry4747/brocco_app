import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

/// Nagłówek ekranu onboardingu: duży tytuł + opcjonalny podtytuł.
class OnboardingHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const OnboardingHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 32,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: const TextStyle(
              color: AppColors.greyText,
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}
