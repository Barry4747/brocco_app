import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../../core/local_db/global_sync_service.dart';
import '../../profile/repositories/dtos/isar_profile.dart';
import '../models/category.dart';
import '../models/home_data.dart';
import 'dtos/isar_category.dart';
import 'dtos/isar_unlocked_category.dart';

class HomeRepository {
  final Isar _isar;
  final GlobalSyncService _syncService;

  HomeRepository(this._isar, this._syncService);

  Future<HomeData> getHomeDataFromLocal(String? userId) async {
    final isarCats = await _isar.isarCategorys.where().findAll();
    final categories =
        isarCats
            .where((c) => c.supabaseId != null)
            .map(
              (c) => Category(
                id: c.supabaseId!,
                title: c.title ?? '',
                imageUrl: c.imageUrl,
                unlockCostStars: c.unlockCostStars,
                totalNodes: c.totalNodes,
              ),
            )
            .toList()
          ..sort((a, b) => a.unlockCostStars.compareTo(b.unlockCostStars));

    int stars = 0;
    Set<String> unlockedIds = {};
    List<IsarUnlockedCategory> unlockedList = [];

    if (userId != null) {
      final profile = await _isar.isarProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();
      stars = profile?.starsBank ?? 0;

      unlockedList = await _isar.isarUnlockedCategorys
          .where()
          .userIdEqualToAnyCategoryId(userId)
          .findAll();
      unlockedIds = unlockedList
          .where((u) => u.categoryId != null)
          .map((u) => u.categoryId!)
          .toSet();
    }

    final completed = <String, int>{};
    final totals = <String, int>{};
    for (final cat in categories) {
      totals[cat.id] = cat.totalNodes;
      final unlockedCat = unlockedList
          .where((u) => u.categoryId == cat.id)
          .firstOrNull;
      completed[cat.id] = unlockedCat?.completedNodesCount ?? 0;
    }

    return HomeData(
      categories: categories,
      currentStars: stars,
      completedMeals: completed,
      totalMeals: totals,
      unlockedIds: unlockedIds,
    );
  }

  Future<HomeData> syncAndGetHomeData(String userId) async {
    await _syncService.syncAll(userId);
    return getHomeDataFromLocal(userId);
  }

  Future<void> unlockCategory({
    required String userId,
    required String categoryId,
    required int starsCost,
  }) async {
    await _isar.writeTxn(() async {
      final profile = await _isar.isarProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();
      if (profile != null) {
        profile.starsBank -= starsCost;
        await _isar.isarProfiles.put(profile);
      }

      final entry = IsarUnlockedCategory()
        ..userId = userId
        ..categoryId = categoryId
        ..unlockedAt = DateTime.now().toUtc();
      await _isar.isarUnlockedCategorys.put(entry);
    });

    try {
      await Supabase.instance.client.rpc(
        'unlock_category_secure',
        params: {'target_category_id': categoryId},
      );
    } catch (_) {}
  }
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final isar = ref.read(isarProvider);
  final syncService = ref.read(globalSyncServiceProvider);
  return HomeRepository(isar, syncService);
});
