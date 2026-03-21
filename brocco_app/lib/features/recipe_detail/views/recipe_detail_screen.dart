import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/main_back_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../viewmodels/recipe_detail_viewmodel.dart';
import 'widgets/description_tab.dart';
import 'widgets/ingredients_tab.dart';
import 'widgets/recipe_tab.dart';
import 'widgets/info_pills_row.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  final String recipeId;

  const RecipeDetailScreen({super.key, required this.recipeId});

  @override
  ConsumerState<RecipeDetailScreen> createState() =>
      _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen> {
  int _selectedTab = 0;

  static const _tabLabels = ['Opis', 'Składniki', 'Przepis'];

  @override
  Widget build(BuildContext context) {
    final detailAsync =
        ref.watch(recipeDetailViewModelProvider(widget.recipeId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: detailAsync.when(
        data: (state) => _buildContent(context, state),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryOrange),
        ),
        error: (err, _) => Center(
          child: Text('Błąd: $err',
              style: const TextStyle(color: Colors.redAccent)),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RecipeDetailState state) {
    final recipe = state.recipe;

    return Column(
      children: [
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Hero image with back button ──
                _buildHeroImage(context, recipe.imageUrl),

                const SizedBox(height: 16),

                // ── Title ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    recipe.title,
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ── Info pills ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InfoPillsRow(
                    difficultyLevel: recipe.difficultyLevel,
                    durationMinutes: recipe.durationMinutes,
                    tags: recipe.tags,
                  ),
                ),

                const SizedBox(height: 20),

                // ── Tab bar ──
                _buildTabBar(),

                const SizedBox(height: 4),

                // ── Tab content ──
                _buildTabContent(state),
              ],
            ),
          ),
        ),

        // ── Bottom button ──
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: PrimaryButton(
            text: 'Gotuj',
            onPressed: () {
              // TODO: implement cooking mode
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, String? imageUrl) {
    return Stack(
      children: [
        // Image
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: imageUrl != null
              ? Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _imagePlaceholder(),
                )
              : _imagePlaceholder(),
        ),

        // Back button
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: MainBackButton(
            onPressed: () => context.pop(),
          ),
        ),
      ],
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 260,
      color: AppColors.accentGreen.withOpacity(0.2),
      child: const Center(
        child: Text('🍽️', style: TextStyle(fontSize: 64)),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.accentGreen.withOpacity(0.4),
          ),
        ),
        child: Row(
          children: List.generate(_tabLabels.length, (index) {
            final isSelected = _selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedTab = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.accentGreen
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _tabLabels[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.primaryText
                          : AppColors.greyText,
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabContent(RecipeDetailState state) {
    switch (_selectedTab) {
      case 0:
        return DescriptionTab(description: state.recipe.description);
      case 1:
        return IngredientsTab(ingredients: state.ingredients);
      case 2:
        return RecipeTab(recipePlaintext: state.recipe.recipePlaintext);
      default:
        return const SizedBox.shrink();
    }
  }
}
