import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';
import '../models/ingredient.dart';
import 'dtos/recipe_dto.dart';
import 'dtos/ingredient_dto.dart';

class RecipeDetailRepository {
  final SupabaseClient _client;

  RecipeDetailRepository(this._client);

  /// Fetches a recipe and its ingredients from Supabase,
  /// maps DTOs to clean App Models, and returns them.
  Future<({Recipe recipe, List<Ingredient> ingredients})> getRecipeDetail(
      String recipeId) async {
    final recipeResponse = await _client
        .from('recipes')
        .select()
        .eq('id', recipeId)
        .single();
    final recipeDto = RecipeDto.fromJson(recipeResponse);

    final ingredientsResponse = await _client
        .from('ingredients')
        .select()
        .eq('recipe_id', recipeId)
        .order('sort_order', ascending: true);
    final ingredientDtos = (ingredientsResponse as List)
        .map((e) => IngredientDto.fromJson(e))
        .toList();

    return (
      recipe: _mapRecipe(recipeDto),
      ingredients: ingredientDtos.map(_mapIngredient).toList(),
    );
  }

  Recipe _mapRecipe(RecipeDto dto) {
    return Recipe(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      recipePlaintext: dto.recipePlaintext,
      imageUrl: dto.imageUrl,
      difficultyLevel: dto.difficultyLevel,
      durationMinutes: dto.durationMinutes,
      youtubeUrl: dto.youtubeUrl,
      tags: dto.tags,
      category: dto.category,
      area: dto.area,
      sourceUrl: dto.sourceUrl,
    );
  }

  Ingredient _mapIngredient(IngredientDto dto) {
    return Ingredient(
      id: dto.id,
      name: dto.name,
      amount: dto.amount,
      unit: dto.unit,
      sortOrder: dto.sortOrder,
    );
  }
}

final recipeDetailRepositoryProvider = Provider<RecipeDetailRepository>((ref) {
  return RecipeDetailRepository(Supabase.instance.client);
});
