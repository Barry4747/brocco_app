import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'isar_provider.dart';
import 'collections/isar_category.dart';
import 'collections/isar_unlocked_category.dart';
import 'dart:math' as math;
import '../../shared/models/user_profile.dart';

class GlobalSyncService {
  final Isar _isar;
  final SupabaseClient _supabase;

  GlobalSyncService(this._isar, this._supabase);

  Future<void> syncAll(String userId) async {
    await Future.wait([
      _syncCategories(),
      _syncProfile(userId),
      _syncUnlockedCategories(userId),
    ]);
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
      var profile = await _isar.userProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();

      profile ??= UserProfile()..supabaseUserId = userId;

      profile
        ..username = response['username'] as String?
        ..avatarUrl = response['avatar_url'] as String?
        ..cookingLevel = response['cooking_level'] as String?
        ..starsBank = (response['stars_bank'] as int?) ?? 0
        ..totalXp = (response['total_xp'] as int?) ?? 0
        ..currentStreak = (response['current_streak'] as int?) ?? 0;

      await _isar.userProfiles.put(profile);
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
      await _isar.isarUnlockedCategorys
          .deleteAll(existing.map((e) => e.id).toList());

      for (final row in rows) {
        final categoryId = row['category_id'] as String;
        final existingCat = existing.where((e) => e.categoryId == categoryId).firstOrNull;
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
}

final globalSyncServiceProvider = Provider<GlobalSyncService>((ref) {
  final isar = ref.watch(isarProvider);
  final supabase = Supabase.instance.client;
  return GlobalSyncService(isar, supabase);
});
