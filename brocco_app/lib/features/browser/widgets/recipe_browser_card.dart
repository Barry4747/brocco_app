import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/models/recipe.dart';

class RecipeBrowserCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeBrowserCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        '/recipe/${recipe.id}?recipeTitle=${Uri.encodeComponent(recipe.title)}',
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.accentGreen.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryText.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroImage(context),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      color: Color(0xFF003D2B),
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (recipe.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      recipe.description!,
                      style: const TextStyle(
                        color: AppColors.greyText,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: (recipe.tags ?? [])
                                .map((tag) => _buildSmallTag(tag))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildDifficultyRating(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
          child: recipe.imageUrl != null
              ? Image.network(
                  recipe.imageUrl!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),

        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF7941D),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'NOWE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 10,
              ),
            ),
          ),
        ),

        Positioned(
          top: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 14,
                  color: Color(0xFF003D2B),
                ),
                const SizedBox(width: 4),
                Text(
                  '${recipe.durationMinutes ?? 0} min',
                  style: const TextStyle(
                    color: Color(0xFF003D2B),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: double.infinity,
      height: 180,
      color: AppColors.accentGreen.withOpacity(0.2),
      child: const Center(
        child: Icon(Icons.restaurant, size: 40, color: AppColors.accentGreen),
      ),
    );
  }

  Widget _buildSmallTag(String tag) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF2FAF5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.accentGreen),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Color(0xFF0F4A3F),
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildDifficultyRating() {
    final diff = recipe.difficultyLevel?.toLowerCase() ?? 'średni';
    int stars = 2;
    String label = 'Średni';
    Color color = const Color(0xFFF7941D);

    if (diff.contains('łatwy') || diff.contains('low')) {
      stars = 1;
      label = 'Łatwy';
    } else if (diff.contains('trudny') || diff.contains('high')) {
      stars = 3;
      label = 'Trudny';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: List.generate(3, (index) {
            final isFilled = index < stars;
            return Icon(
              Icons.star,
              size: 14,
              color: isFilled ? color : color.withOpacity(0.2),
            );
          }),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
