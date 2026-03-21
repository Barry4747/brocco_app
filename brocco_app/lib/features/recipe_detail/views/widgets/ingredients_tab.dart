import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/ingredient.dart';

final _checkedIngredientsProvider =
    StateProvider.autoDispose<Set<String>>((ref) => {});

class IngredientsTab extends ConsumerWidget {
  final List<Ingredient> ingredients;

  const IngredientsTab({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ingredients.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            'Brak składników',
            style: TextStyle(color: AppColors.greyText, fontSize: 16),
          ),
        ),
      );
    }

    final checked = ref.watch(_checkedIngredientsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'POTRZEBNE SKŁADNIKI (${ingredients.length})',
            style: const TextStyle(
              color: AppColors.greyText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          ...ingredients.map((ingredient) {
            final isChecked = checked.contains(ingredient.id);
            return _buildIngredientRow(ref, ingredient, isChecked);
          }),
        ],
      ),
    );
  }

  Widget _buildIngredientRow(
      WidgetRef ref, Ingredient ingredient, bool isChecked) {
    return InkWell(
      onTap: () {
        final notifier = ref.read(_checkedIngredientsProvider.notifier);
        final current = ref.read(_checkedIngredientsProvider);
        if (isChecked) {
          notifier.state = {...current}..remove(ingredient.id);
        } else {
          notifier.state = {...current, ingredient.id};
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isChecked ? AppColors.accentGreen : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isChecked
                      ? AppColors.accentGreen
                      : AppColors.greyText.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                ingredient.name,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            if (ingredient.formattedAmount.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  ingredient.formattedAmount,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
