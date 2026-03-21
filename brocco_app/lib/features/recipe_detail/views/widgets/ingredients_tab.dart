import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/ingredient.dart';

class IngredientsTab extends StatefulWidget {
  final List<Ingredient> ingredients;

  const IngredientsTab({super.key, required this.ingredients});

  @override
  State<IngredientsTab> createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  final Set<String> _checked = {};

  @override
  Widget build(BuildContext context) {
    if (widget.ingredients.isEmpty) {
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.accentGreen.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'POTRZEBNE SKŁADNIKI (${widget.ingredients.length})',
            style: TextStyle(
              color: AppColors.greyText,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),

          // Ingredient rows
          ...widget.ingredients.map((ingredient) {
            final isChecked = _checked.contains(ingredient.id);
            return _buildIngredientRow(ingredient, isChecked);
          }),
        ],
      ),
    );
  }

  Widget _buildIngredientRow(Ingredient ingredient, bool isChecked) {
    return InkWell(
      onTap: () {
        setState(() {
          if (isChecked) {
            _checked.remove(ingredient.id);
          } else {
            _checked.add(ingredient.id);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            // Checkbox
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isChecked
                    ? AppColors.accentGreen
                    : Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isChecked
                      ? AppColors.accentGreen
                      : AppColors.greyText.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 14),

            // Name
            Expanded(
              child: Text(
                ingredient.name,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  decoration:
                      isChecked ? TextDecoration.lineThrough : null,
                ),
              ),
            ),

            // Amount pill
            if (ingredient.formattedAmount.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withOpacity(0.15),
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
