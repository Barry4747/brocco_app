import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';

// ──────────────────────────────────────────────
// MOCK DATA – change these values freely to test
// ──────────────────────────────────────────────
const int mockCurrentStars = 19;

/// categoryId → completedMeals
const Map<String, int> mockCompletedMeals = {
  // Will be matched to the first unlocked category found.
  // Add more entries keyed by real Supabase category IDs.
};

/// categoryId → totalMeals
const Map<String, int> mockTotalMeals = {};

/// Fallback values when a category is not in the maps above.
const int mockDefaultCompleted = 3;
const int mockDefaultTotal = 16;
// ──────────────────────────────────────────────

class HomeState {
  final List<Category> categories;
  final int currentStars;
  final Map<String, int> completedMeals;
  final Map<String, int> totalMeals;
  final Set<String> unlockedIds;

  const HomeState({
    this.categories = const [],
    this.currentStars = 0,
    this.completedMeals = const {},
    this.totalMeals = const {},
    this.unlockedIds = const {},
  });

  HomeState copyWith({
    List<Category>? categories,
    int? currentStars,
    Map<String, int>? completedMeals,
    Map<String, int>? totalMeals,
    Set<String>? unlockedIds,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      currentStars: currentStars ?? this.currentStars,
      completedMeals: completedMeals ?? this.completedMeals,
      totalMeals: totalMeals ?? this.totalMeals,
      unlockedIds: unlockedIds ?? this.unlockedIds,
    );
  }

  /// A category is locked if it has a cost AND hasn't been unlocked yet.
  bool isCategoryLocked(Category cat) =>
      cat.unlockCostStars > 0 && !unlockedIds.contains(cat.id);

  int completedFor(String categoryId) =>
      completedMeals[categoryId] ?? mockDefaultCompleted;

  int totalFor(String categoryId) => totalMeals[categoryId] ?? mockDefaultTotal;
}

class HomeViewModel extends AsyncNotifier<HomeState> {
  @override
  Future<HomeState> build() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('categories').select();

    final categories =
        (response as List).map((e) => Category.fromJson(e)).toList()
          ..sort((a, b) => a.unlockCostStars.compareTo(b.unlockCostStars));

    // Build mocked progress maps – merge defaults with explicit mocks
    final completed = <String, int>{};
    final totals = <String, int>{};
    for (final cat in categories) {
      completed[cat.id] = mockCompletedMeals[cat.id] ?? mockDefaultCompleted;
      totals[cat.id] = mockTotalMeals[cat.id] ?? mockDefaultTotal;
    }

    return HomeState(
      categories: categories,
      currentStars: mockCurrentStars,
      completedMeals: completed,
      totalMeals: totals,
    );
  }

  /// Deducts stars and marks the category as unlocked.
  void unlockCategory(String categoryId) {
    final current = state.valueOrNull;
    if (current == null) return;

    final cat = current.categories.firstWhere((c) => c.id == categoryId);
    if (current.currentStars < cat.unlockCostStars) return;

    state = AsyncValue.data(
      current.copyWith(unlockedIds: {...current.unlockedIds, categoryId}),
    );
  }
}

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeState>(
  () => HomeViewModel(),
);
