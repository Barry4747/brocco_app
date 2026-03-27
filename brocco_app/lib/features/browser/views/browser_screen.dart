import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodels/browser_viewmodel.dart';
import '../widgets/recipe_browser_card.dart';

class BrowserScreen extends ConsumerWidget {
  const BrowserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserState = ref.watch(browserViewModelProvider);
    final viewModel = ref.read(browserViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF5),
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Text(
                    'Odkrywaj przepisy',
                    style: TextStyle(
                      color: Color(0xFF003D2B),
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

            // Search Input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.accentGreen.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: viewModel.setSearchQuery,
                  decoration: const InputDecoration(
                    hintText: 'Czego dzisiaj szukasz, Szefie?',
                    hintStyle: TextStyle(color: AppColors.greyText, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: AppColors.greyText),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Results Counter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Znaleziono ${browserState.filteredRecipes.length} przepisy',
                  style: const TextStyle(
                    color: AppColors.greyText,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Recipes List
            Expanded(
              child: browserState.isLoading
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primaryOrange))
                  : browserState.errorMessage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              browserState.errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                          itemCount: browserState.filteredRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = browserState.filteredRecipes[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: RecipeBrowserCard(recipe: recipe),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
