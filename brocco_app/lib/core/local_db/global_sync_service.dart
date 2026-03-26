import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'isar_provider.dart';
import '../../features/home/repositories/dtos/isar_category.dart';
import '../../features/home/repositories/dtos/isar_unlocked_category.dart';
import 'dart:math' as math;
import '../../features/profile/repositories/dtos/isar_profile.dart';
import '../../features/roadmap/repositories/dtos/isar_completed_node.dart';
import '../../features/roadmap/repositories/dtos/isar_roadmap_node.dart';
import '../../features/onboarding/repositories/dtos/isar_allergy.dart';
import '../../features/onboarding/repositories/dtos/isar_cuisine.dart';
import '../../features/onboarding/repositories/dtos/isar_ingredient.dart';
import '../../features/settings/repositories/dtos/isar_user_ux_preferences.dart';

class GlobalSyncService {
  final Isar _isar;
  final SupabaseClient _supabase;

  GlobalSyncService(this._isar, this._supabase);

  Future<void> syncAll(String userId) async {
    try {
      await Future.wait([
        _syncCategories(),
        _syncProfile(userId),
        _syncUnlockedCategories(userId),
        _syncAllCompletedNodes(userId),
        _syncAllRoadmapNodes(),
        _syncDictionaries(),
        _syncUserUxPreferences(userId),
      ]);
    } catch (e) {
      print('Błąd synchronizacji (aplikacja w trybie offline): $e');
    }
  }

  Future<void> _syncCategories() async {
    final response = await _supabase.from('categories').select();
    final rows = response as List;

    await _isar.writeTxn(() async {
      await _isar.isarCategorys.clear();
      for (final row in rows) {
        final cat = IsarCategory()
          ..supabaseId = row['id'] as String
          ..title = row['title'] as String?
          ..imageUrl = row['image_url'] as String?
          ..unlockCostStars = (row['unlock_cost_stars'] as int?) ?? 0
          ..totalNodes = (row['total_nodes'] as int?) ?? 0;
        await _isar.isarCategorys.put(cat);
      }
    });
  }

  Future<void> _syncProfile(String userId) async {
    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();

    if (response == null) return;

    await _isar.writeTxn(() async {
      var profile = await _isar.isarProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();

      profile ??= IsarProfile()..supabaseUserId = userId;

      profile
        ..username = response['username'] as String?
        ..avatarUrl = response['avatar_url'] as String?
        ..cookingLevel = response['cooking_level'] as String?
        ..starsBank = (response['stars_bank'] as int?) ?? 0
        ..totalXp = (response['total_xp'] as int?) ?? 0
        ..currentStreak = (response['current_streak'] as int?) ?? 0;

      await _isar.isarProfiles.put(profile);
    });
  }

  Future<void> _syncUnlockedCategories(String userId) async {
    final response = await _supabase
        .from('user_unlocked_categories')
        .select()
        .eq('user_id', userId);

    final rows = response as List;

    await _isar.writeTxn(() async {
      final existing = await _isar.isarUnlockedCategorys
          .where()
          .userIdEqualToAnyCategoryId(userId)
          .findAll();
      await _isar.isarUnlockedCategorys.deleteAll(
        existing.map((e) => e.id).toList(),
      );

      for (final row in rows) {
        final categoryId = row['category_id'] as String;
        final existingCat = existing
            .where((e) => e.categoryId == categoryId)
            .firstOrNull;
        final incomingCount = (row['completed_nodes_count'] as int?) ?? 0;
        final resolvedCount = existingCat != null
            ? math.max(existingCat.completedNodesCount, incomingCount)
            : incomingCount;

        final entry = IsarUnlockedCategory()
          ..userId = userId
          ..categoryId = categoryId
          ..unlockedAt = row['unlocked_at'] != null
              ? DateTime.parse(row['unlocked_at'] as String)
              : null
          ..completedNodesCount = resolvedCount;
        await _isar.isarUnlockedCategorys.put(entry);
      }
    });
  }

  Future<void> _syncAllCompletedNodes(String userId) async {
    final response = await _supabase
        .from('user_completed_nodes')
        .select()
        .eq('user_id', userId);

    final rows = response as List;

    await _isar.writeTxn(() async {
      final existing = await _isar.isarCompletedNodes
          .where()
          .userIdEqualToAnyNodeId(userId)
          .findAll();
      await _isar.isarCompletedNodes.deleteAll(
        existing.map((e) => e.id).toList(),
      );

      for (final row in rows) {
        final entry = IsarCompletedNode()
          ..userId = userId
          ..nodeId = row['node_id'] as String
          ..starsEarned = (row['stars_earned'] as int?) ?? 1
          ..imageUrl = row['image_url'] as String?;
        await _isar.isarCompletedNodes.put(entry);
      }
    });
  }

  Future<void> _syncAllRoadmapNodes() async {
    final response = await _supabase.from('roadmap_nodes').select();
    final rows = response as List;

    await _isar.writeTxn(() async {
      await _isar.isarRoadmapNodes.clear();
      for (final row in rows) {
        final node = IsarRoadmapNode()
          ..supabaseId = row['id'] as String
          ..categoryId = row['category_id'] as String
          ..recipeId = row['recipe_id'] as String?
          ..title = row['title'] as String?
          ..previewImageUrl = row['preview_image_url'] as String?
          ..mapColumn = (row['map_column'] as int?) ?? 0
          ..mapRow = (row['map_row'] as int?) ?? 0
          ..prerequisiteIds =
              (row['prerequisite_ids'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [];
        await _isar.isarRoadmapNodes.put(node);
      }
    });
  }

  Future<void> _syncDictionaries() async {
    final futures = await Future.wait([
      _supabase.from('allergies').select('id, name'),
      _supabase.from('cuisines').select('id, name'),
      _supabase.from('ingredients').select('id, name'),
    ]);

    final allergiesRows = futures[0] as List;
    final cuisinesRows = futures[1] as List;
    final ingredientsRows = futures[2] as List;

    await _isar.writeTxn(() async {
      await _isar.isarAllergys.clear();
      await _isar.isarCuisines.clear();
      await _isar.isarIngredients.clear();

      for (final row in allergiesRows) {
        final item = IsarAllergy()
          ..supabaseId = row['id'] as String
          ..name = row['name'] as String;
        await _isar.isarAllergys.put(item);
      }

      for (final row in cuisinesRows) {
        final item = IsarCuisine()
          ..supabaseId = row['id'] as String
          ..name = row['name'] as String;
        await _isar.isarCuisines.put(item);
      }

      for (final row in ingredientsRows) {
        final item = IsarIngredient()
          ..supabaseId = row['id'] as String
          ..name = row['name'] as String;
        await _isar.isarIngredients.put(item);
      }
    });
  }

  Future<void> _syncUserUxPreferences(String userId) async {
    final response = await _supabase
        .from('user_ux_preferences')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) return;

    await _isar.writeTxn(() async {
      var isar = await _isar.isarUserUxPreferences
          .where()
          .userIdEqualTo(userId)
          .findFirst();

      isar ??= IsarUserUxPreferences()..userId = userId;

      isar
        ..keepScreenOn = (response['keep_screen_on'] as bool?) ?? true
        ..timerAlarms = (response['timer_alarms'] as bool?) ?? true
        ..mascotSounds = (response['mascot_sounds'] as bool?) ?? true;

      await _isar.isarUserUxPreferences.put(isar);
    });
  }
}

final globalSyncServiceProvider = Provider<GlobalSyncService>((ref) {
  final isar = ref.watch(isarProvider);
  final supabase = Supabase.instance.client;
  return GlobalSyncService(isar, supabase);
});
