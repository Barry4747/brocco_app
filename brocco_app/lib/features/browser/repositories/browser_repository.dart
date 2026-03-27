import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../shared/models/recipe.dart';
import '../../../shared/repositories/dtos/isar_recipe.dart';
import '../../../core/local_db/isar_provider.dart';

class BrowserRepository {
  final Isar _isar;
  final SupabaseClient _client;

  BrowserRepository(this._isar, this._client);

  Future<List<Recipe>> getRecipes() async {
    final isarRecipes = await _isar.isarRecipes.where().findAll();

    if (isarRecipes.isEmpty) {
      final response = await _client.from('recipes').select();
      final rows = response as List;

      await _isar.writeTxn(() async {
        for (final row in rows) {
          final recipe = IsarRecipe()
            ..supabaseId = row['id'] as String
            ..title = row['title'] as String?
            ..description = row['description'] as String?
            ..recipePlaintext = row['recipe_plaintext'] as String?
            ..imageUrl = row['image_url'] as String?
            ..difficultyLevel = row['difficulty_level'] as String?
            ..durationMinutes = row['duration_minutes'] as int?
            ..youtubeUrl = row['youtube_url'] as String?
            ..tags = (row['tags'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList()
            ..category = row['category'] as String?
            ..area = row['area'] as String?
            ..sourceUrl = row['source_url'] as String?;
          await _isar.isarRecipes.put(recipe);
        }
      });

      final updatedIsarRecipes = await _isar.isarRecipes.where().findAll();
      return updatedIsarRecipes.map(_mapIsarRecipe).toList();
    }

    return isarRecipes.map(_mapIsarRecipe).toList();
  }

  Recipe _mapIsarRecipe(IsarRecipe dto) {
    return Recipe(
      id: dto.supabaseId ?? '',
      title: dto.title ?? '',
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
}

final browserRepositoryProvider = Provider<BrowserRepository>((ref) {
  final isar = ref.watch(isarProvider);
  return BrowserRepository(isar, Supabase.instance.client);
});
