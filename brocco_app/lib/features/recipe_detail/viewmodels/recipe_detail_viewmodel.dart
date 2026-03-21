import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';

class RecipeDetailState {
  final Recipe recipe;
  final List<Ingredient> ingredients;

  const RecipeDetailState({
    required this.recipe,
    this.ingredients = const [],
  });
}

class RecipeDetailViewModel
    extends FamilyAsyncNotifier<RecipeDetailState, String> {
  @override
  Future<RecipeDetailState> build(String recipeId) async {
    final supabase = Supabase.instance.client;

    // Fetch recipe
    final recipeResponse = await supabase
        .from('recipes')
        .select()
        .eq('id', recipeId)
        .single();
    final recipe = Recipe.fromJson(recipeResponse);

    // Fetch ingredients ordered by sort_order
    final ingredientsResponse = await supabase
        .from('ingredients')
        .select()
        .eq('recipe_id', recipeId)
        .order('sort_order', ascending: true);
    final ingredients = (ingredientsResponse as List)
        .map((e) => Ingredient.fromJson(e))
        .toList();

    return RecipeDetailState(
      recipe: recipe,
      ingredients: ingredients,
    );
  }
}

final recipeDetailViewModelProvider = AsyncNotifierProvider.family<
    RecipeDetailViewModel, RecipeDetailState, String>(
  () => RecipeDetailViewModel(),
);
