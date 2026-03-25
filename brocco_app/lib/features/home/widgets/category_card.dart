import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/main_progress_bar.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final int completedMeals;
  final int totalMeals;
  final int currentStars;
  final bool isLocked;
  final VoidCallback? onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.completedMeals,
    required this.totalMeals,
    required this.currentStars,
    required this.isLocked,
    this.onTap,
  });

  bool get _canAfford => currentStars >= category.unlockCostStars;

  @override
  Widget build(BuildContext context) {
    if (isLocked) {
      return _buildLockedCard();
    }
      return _buildUnlockedCard();
  }

  Widget _buildUnlockedCard() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.accentGreen, width: 1.5),
          borderRadius: BorderRadius.circular(20),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 160,
              child: category.imageUrl != null
                  ? Image.network(
                      category.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _imagePlaceholder(),
                    )
                  : _imagePlaceholder(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MainProgressBar(
                    currentStep: completedMeals,
                    totalSteps: totalMeals,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$completedMeals/$totalMeals Ukończonych potraw',
                    style: const TextStyle(
                      color: AppColors.greyText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLockedCard() {
    final overlayOpacity = _canAfford ? 0.45 : 0.7;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: _canAfford
                ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
                : const ColorFilter.mode(Colors.grey, BlendMode.saturation),
            child: category.imageUrl != null
                ? Image.network(
                    category.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: overlayOpacity * 0.6),
                  Colors.black.withValues(alpha: overlayOpacity),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  category.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: PrimaryButton(
                    text: 'Odblokuj za ${category.unlockCostStars} ⭐',
                    onPressed: _canAfford ? onTap : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.accentGreen.withValues(alpha: 0.3),
      child: const Center(
        child: Text('🍽️', style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
