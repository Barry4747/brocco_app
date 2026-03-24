import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/remote/roadmap_node.dart';

class RoadmapNodeTile extends StatelessWidget {
  final RoadmapNode node;
  final bool isCompleted;
  final bool isUnlocked;

  const RoadmapNodeTile({
    super.key,
    required this.node,
    required this.isCompleted,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = !isCompleted && !isUnlocked;

    return GestureDetector(
      onTap: isLocked
          ? null
          : () {
              if (node.recipeId != null) {
                final encodedTitle = Uri.encodeComponent(node.title);
                context.push('/recipe/${node.recipeId}?nodeId=${node.id}&categoryId=${node.categoryId}&recipeTitle=$encodedTitle');
              }
            },
      child: SizedBox(
        width: 120,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: isLocked
                        ? Colors.white.withValues(alpha: 0.6)
                        : Colors.white,
                    border: Border.all(
                      color: isCompleted || isUnlocked
                          ? AppColors.accentGreen
                          : AppColors.greyText.withValues(alpha: 0.3),
                      width: isCompleted ? 2.5 : 1.5,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: node.previewImageUrl != null
                        ? ColorFiltered(
                            colorFilter: isLocked
                                ? const ColorFilter.mode(
                                    Colors.grey, BlendMode.saturation)
                                : const ColorFilter.mode(
                                    Colors.transparent, BlendMode.dst),
                            child: Image.network(
                              node.previewImageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _nodePlaceholder(isLocked),
                            ),
                          )
                        : _nodePlaceholder(isLocked),
                  ),
                ),
                if (isCompleted)
                  Positioned(
                    top: -8,
                    right: -8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryOrange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'gotowe',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.check, color: Colors.white, size: 12),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              node.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isLocked ? AppColors.greyText : AppColors.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nodePlaceholder(bool locked) {
    return Container(
      color: locked
          ? AppColors.greyText.withValues(alpha: 0.1)
          : AppColors.accentGreen.withValues(alpha: 0.15),
      child: Center(
        child: Text(
          '🍽️',
          style: TextStyle(
            fontSize: 32,
            color: locked ? Colors.grey : null,
          ),
        ),
      ),
    );
  }
}
