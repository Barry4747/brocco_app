import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/recipe.dart';
import '../repositories/browser_repository.dart';

class BrowserState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;
  final String searchQuery;
  final bool isLoading;
  final String? errorMessage;

  const BrowserState({
    this.allRecipes = const [],
    this.filteredRecipes = const [],
    this.searchQuery = '',
    this.isLoading = false,
    this.errorMessage,
  });

  BrowserState copyWith({
    List<Recipe>? allRecipes,
    List<Recipe>? filteredRecipes,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return BrowserState(
      allRecipes: allRecipes ?? this.allRecipes,
      filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class BrowserViewModel extends StateNotifier<BrowserState> {
  final BrowserRepository _repository;

  BrowserViewModel(this._repository) : super(const BrowserState()) {
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final recipes = await _repository.getRecipes();
      state = state.copyWith(
        allRecipes: recipes,
        filteredRecipes: recipes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Nie udało się pobrać przepisów: $e',
      );
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = state.allRecipes;

    // Search
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered.where((r) =>
          r.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (r.description?.toLowerCase().contains(state.searchQuery.toLowerCase()) ?? false)
      ).toList();
    }

    state = state.copyWith(filteredRecipes: filtered);
  }
}

final browserViewModelProvider =
    StateNotifierProvider<BrowserViewModel, BrowserState>((ref) {
  final repository = ref.watch(browserRepositoryProvider);
  return BrowserViewModel(repository);
});
