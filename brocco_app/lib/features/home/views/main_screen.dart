import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/pills/stars_pill.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/category_card.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authViewModelProvider);
    final homeAsync = ref.watch(homeViewModelProvider);
    final isLoading = authAsync.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Wybierz swoją ścieżkę',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                  const StarsPill(),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => context.push('/profile'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accentGreen.withValues(alpha: 0.2),
                      ),
                      child: const Icon(Icons.person_outline, color: AppColors.primaryOrange),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.logout, color: AppColors.greyText),
                    onPressed: () {
                      ref.read(authViewModelProvider.notifier).signOut();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 28),

              Expanded(
                child: homeAsync.when(
                  data: (state) {
                    if (state.categories.isEmpty) {
                      return const Center(
                        child: Text(
                          'Brak kategorii do wyświetlenia.',
                          style: TextStyle(
                            color: AppColors.greyText,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final cat = state.categories[index];
                        final locked = state.isCategoryLocked(cat);
                        return CategoryCard(
                          category: cat,
                          completedMeals: state.completedFor(cat.id),
                          totalMeals: state.totalFor(cat.id),
                          currentStars: state.currentStars,
                          isLocked: locked,
                          onTap: locked
                              ? () => ref
                                    .read(homeViewModelProvider.notifier)
                                    .unlockCategory(cat.id)
                              : () {
                                  context.go('/roadmap/${cat.id}');
                                },
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryOrange,
                    ),
                  ),
                  error: (err, _) => Center(
                    child: Text(
                      'Błąd: $err',
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
