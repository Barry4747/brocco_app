/// Clean App Model representing the home screen state.
/// Used by the ViewModel and Views only.
library;
import 'category.dart';

class HomeData {
  final List<Category> categories;
  final int currentStars;
  final Map<String, int> completedMeals;
  final Map<String, int> totalMeals;
  final Set<String> unlockedIds;

  const HomeData({
    this.categories = const [],
    this.currentStars = 0,
    this.completedMeals = const {},
    this.totalMeals = const {},
    this.unlockedIds = const {},
  });

  HomeData copyWith({
    List<Category>? categories,
    int? currentStars,
    Map<String, int>? completedMeals,
    Map<String, int>? totalMeals,
    Set<String>? unlockedIds,
  }) {
    return HomeData(
      categories: categories ?? this.categories,
      currentStars: currentStars ?? this.currentStars,
      completedMeals: completedMeals ?? this.completedMeals,
      totalMeals: totalMeals ?? this.totalMeals,
      unlockedIds: unlockedIds ?? this.unlockedIds,
    );
  }

  bool isCategoryLocked(Category cat) =>
      cat.unlockCostStars > 0 && !unlockedIds.contains(cat.id);

  int completedFor(String categoryId) => completedMeals[categoryId] ?? 0;

  int totalFor(String categoryId) => totalMeals[categoryId] ?? 0;
}
