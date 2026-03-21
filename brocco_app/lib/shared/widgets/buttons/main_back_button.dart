import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MainBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const MainBackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.accentGreen, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.arrow_back_rounded,
          color: AppColors.primaryText,
          size: 22,
        ),
      ),
    );
  }
}
