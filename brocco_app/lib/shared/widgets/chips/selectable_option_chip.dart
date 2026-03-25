import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SelectableOptionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableOptionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryText
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.primaryText
                : AppColors.greyText.withOpacity(0.15),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: AppColors.primaryText.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            if (isSelected)
              BoxShadow(
                color: AppColors.primaryText.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryText,
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
