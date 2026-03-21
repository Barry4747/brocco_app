import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class InfoPillsRow extends StatelessWidget {
  final String? difficultyLevel;
  final int? durationMinutes;
  final List<String>? tags;

  const InfoPillsRow({
    super.key,
    this.difficultyLevel,
    this.durationMinutes,
    this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: [
        if (difficultyLevel != null && difficultyLevel!.isNotEmpty)
          _buildPill(
            child: Text(
              'Poziom: $difficultyLevel',
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        if (durationMinutes != null)
          _buildPill(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: AppColors.primaryText,
                ),
                const SizedBox(width: 4),
                Text(
                  '$durationMinutes min',
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        if (tags != null)
          ...tags!.map(
            (tag) => _buildPill(
              child: Text(
                tag,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPill({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryText.withOpacity(0.2),
          width: 1.2,
        ),
      ),
      child: child,
    );
  }
}
