import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../../core/local_db/roadmap_sync_service.dart';
import '../../home/models/category.dart';
import '../../home/repositories/dtos/isar_category.dart';
import '../models/roadmap_data.dart';
import '../models/roadmap_node.dart';
import 'dtos/isar_completed_node.dart';
import 'dtos/isar_roadmap_node.dart';
import '../../profile/repositories/dtos/isar_profile.dart';
import '../../home/repositories/dtos/isar_unlocked_category.dart';

class RoadmapRepository {
  final Isar _isar;
  final RoadmapSyncService _syncService;

  RoadmapRepository(this._isar, this._syncService);

  Future<RoadmapData> getRoadmapDataFromLocal(
    String? userId,
    String categoryId,
  ) async {
    final isarCat = await _isar.isarCategorys
        .where()
        .supabaseIdEqualTo(categoryId)
        .findFirst();

    final category = isarCat != null
        ? Category(
            id: isarCat.supabaseId!,
            title: isarCat.title ?? '',
            imageUrl: isarCat.imageUrl,
            unlockCostStars: isarCat.unlockCostStars,
            totalNodes: isarCat.totalNodes,
          )
        : Category(id: categoryId, title: '');

    final isarNodes = await _isar.isarRoadmapNodes
        .where()
        .categoryIdEqualTo(categoryId)
        .findAll();

    final nodes = isarNodes
        .where((n) => n.supabaseId != null)
        .map(
          (n) => RoadmapNode(
            id: n.supabaseId!,
            categoryId: n.categoryId ?? categoryId,
            recipeId: n.recipeId,
            title: n.title ?? '',
            previewImageUrl: n.previewImageUrl,
            mapColumn: n.mapColumn,
            mapRow: n.mapRow,
            prerequisiteIds: n.prerequisiteIds,
          ),
        )
        .toList();

    Set<String> completedIds = {};
    int stars = 0;

    if (userId != null) {
      final profile = await _isar.isarProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();
      stars = profile?.starsBank ?? 0;

      final nodeIdSet = nodes.map((n) => n.id).toSet();
      final allCompleted = await _isar.isarCompletedNodes
          .where()
          .userIdEqualToAnyNodeId(userId)
          .findAll();
      completedIds = allCompleted
          .where((c) => c.nodeId != null && nodeIdSet.contains(c.nodeId))
          .map((c) => c.nodeId!)
          .toSet();
    }

    return RoadmapData(
      category: category,
      nodes: nodes,
      completedNodeIds: completedIds,
      currentStars: stars,
      completedCount: completedIds.length,
      totalCount: nodes.length,
    );
  }

  Future<RoadmapData> syncAndGetRoadmapData(
    String userId,
    String categoryId,
  ) async {
    await _syncService.syncRoadmapData(userId, categoryId);
    return getRoadmapDataFromLocal(userId, categoryId);
  }

  Future<void> completeNode({
    required String userId,
    required String nodeId,
    required String categoryId,
    required int starsEarned,
    required int xpEarned,
  }) async {
    final supabase = Supabase.instance.client;

    await _isar.writeTxn(() async {
      final completedNode = IsarCompletedNode()
        ..userId = userId
        ..nodeId = nodeId
        ..starsEarned = starsEarned;
      await _isar.isarCompletedNodes.put(completedNode);

      final profile = await _isar.isarProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();

      if (profile != null) {
        profile.starsBank += starsEarned;
        profile.totalXp += xpEarned;
        await _isar.isarProfiles.put(profile);
      }

      var unlockedCat = await _isar.isarUnlockedCategorys
          .where()
          .userIdEqualToAnyCategoryId(userId)
          .filter()
          .categoryIdEqualTo(categoryId)
          .findFirst();

      if (unlockedCat != null) {
        unlockedCat.completedNodesCount += 1;
        await _isar.isarUnlockedCategorys.put(unlockedCat);
      } else {
        final newCat = IsarUnlockedCategory()
          ..userId = userId
          ..categoryId = categoryId
          ..unlockedAt = DateTime.now().toUtc()
          ..completedNodesCount = 1;
        await _isar.isarUnlockedCategorys.put(newCat);
      }
    });

    await supabase.from('user_completed_nodes').upsert({
      'user_id': userId,
      'node_id': nodeId,
      'stars_earned': starsEarned,
    });

    final profileResponse = await supabase
        .from('profiles')
        .select('stars_bank, total_xp')
        .eq('id', userId)
        .single();

    await supabase
        .from('profiles')
        .update({
          'stars_bank': (profileResponse['stars_bank'] as int) + starsEarned,
          'total_xp': (profileResponse['total_xp'] as int) + xpEarned,
        })
        .eq('id', userId);

    final catResponse = await supabase
        .from('user_unlocked_categories')
        .select('completed_nodes_count')
        .eq('user_id', userId)
        .eq('category_id', categoryId)
        .maybeSingle();

    if (catResponse != null) {
      await supabase
          .from('user_unlocked_categories')
          .update({
            'completed_nodes_count':
                (catResponse['completed_nodes_count'] as int) + 1,
          })
          .eq('user_id', userId)
          .eq('category_id', categoryId);
    } else {
      await supabase.from('user_unlocked_categories').insert({
        'user_id': userId,
        'category_id': categoryId,
        'completed_nodes_count': 1,
        'unlocked_at': DateTime.now().toIso8601String(),
      });
    }
  }
}

final roadmapRepositoryProvider = Provider<RoadmapRepository>((ref) {
  final isar = ref.watch(isarProvider);
  final syncService = ref.watch(roadmapSyncServiceProvider);
  return RoadmapRepository(isar, syncService);
});
