import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/main_back_button.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../viewmodels/recipe_detail_viewmodel.dart';
import '../widgets/description_tab.dart';
import '../widgets/ingredients_tab.dart';
import '../widgets/recipe_tab.dart';
import '../widgets/info_pills_row.dart';

final _selectedTabProvider = StateProvider.autoDispose<int>((ref) => 0);

class RecipeDetailScreen extends ConsumerWidget {
  final String recipeId;
  final String? nodeId;
  final String? categoryId;
  final String? recipeTitle;

  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
    this.nodeId,
    this.categoryId,
    this.recipeTitle,
  });

  static const _tabLabels = ['Opis', 'Składniki', 'Przepis'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(recipeDetailViewModelProvider(recipeId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: detailAsync.when(
        data: (state) => _buildContent(context, ref, state),
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryOrange),
        ),
        error: (err, _) => Center(
          child: Text(
            'Błąd: $err',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    RecipeDetailState state,
  ) {
    final recipe = state.recipe;
    final selectedTab = ref.watch(_selectedTabProvider);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroImage(context, recipe.imageUrl),
                const SizedBox(height: 16),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: InfoPillsRow(
                    difficultyLevel: recipe.difficultyLevel,
                    durationMinutes: recipe.durationMinutes,
                    tags: recipe.tags,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTabBar(ref, selectedTab),
                const SizedBox(height: 4),
                _buildTabContent(state, selectedTab),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: PrimaryButton(
            text: 'Rozpocznij gotowanie',
            onPressed: () {
              if (nodeId != null && categoryId != null) {
                final encodedTitle = Uri.encodeComponent(recipeTitle ?? '');
                final encodedRecipeText = Uri.encodeComponent(
                  recipe.recipePlaintext ?? '',
                );
                context.replace(
                  '/game/play?recipeId=$recipeId&recipeText=$encodedRecipeText&nodeId=$nodeId&categoryId=$categoryId&recipeTitle=$encodedTitle',
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, String? imageUrl) {
    return Stack(
      children: [
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
                  errorBuilder: (_, _, _) => _imagePlaceholder(),
                )
              : _imagePlaceholder(),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          child: MainBackButton(onPressed: () => context.pop()),
        ),
      ],
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: double.infinity,
      height: 260,
      color: AppColors.accentGreen.withValues(alpha: 0.2),
      child: const Center(child: Text('🍽️', style: TextStyle(fontSize: 64))),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int selectedTab) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.accentGreen.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: List.generate(_tabLabels.length, (index) {
            final isSelected = selectedTab == index;
            return Expanded(
              child: GestureDetector(
                onTap: () =>
                    ref.read(_selectedTabProvider.notifier).state = index,
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
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
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

  Widget _buildTabContent(RecipeDetailState state, int selectedTab) {
    switch (selectedTab) {
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
