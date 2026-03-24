import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'isar_provider.dart';
import '../../features/roadmap/models/local/isar_roadmap_node.dart';
import '../../features/roadmap/models/local/isar_completed_node.dart';
import '../../features/home/models/local/isar_unlocked_category.dart';

class RoadmapSyncService {
  final Isar _isar;
  final SupabaseClient _supabase;

  RoadmapSyncService(this._isar, this._supabase);

  Future<void> syncRoadmapData(String userId, String categoryId) async {
    await _syncNodes(categoryId);
    await _syncCompletedNodes(userId, categoryId);
  }

  Future<void> _syncNodes(String categoryId) async {
    final response = await _supabase
        .from('roadmap_nodes')
        .select()
        .eq('category_id', categoryId);

    final rows = response as List;

    await _isar.writeTxn(() async {
      final existing = await _isar.isarRoadmapNodes
          .where()
          .categoryIdEqualTo(categoryId)
          .findAll();
      await _isar.isarRoadmapNodes
          .deleteAll(existing.map((e) => e.id).toList());

      for (final row in rows) {
        final node = IsarRoadmapNode()
          ..supabaseId = row['id'] as String
          ..categoryId = row['category_id'] as String
          ..recipeId = row['recipe_id'] as String?
          ..title = row['title'] as String?
          ..previewImageUrl = row['preview_image_url'] as String?
          ..mapColumn = (row['map_column'] as int?) ?? 0
          ..mapRow = (row['map_row'] as int?) ?? 0
          ..prerequisiteIds = (row['prerequisite_ids'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [];
        await _isar.isarRoadmapNodes.put(node);
      }
    });
  }

  Future<void> _syncCompletedNodes(String userId, String categoryId) async {
    final nodeIds = await _isar.isarRoadmapNodes
        .where()
        .categoryIdEqualTo(categoryId)
        .findAll()
        .then((nodes) => nodes.map((n) => n.supabaseId!).toList());

    if (nodeIds.isEmpty) return;
    
    bool needsSupabaseRepair = false;

    final response = await _supabase
        .from('user_completed_nodes')
        .select()
        .eq('user_id', userId)
        .inFilter('node_id', nodeIds);

    final rows = response as List;

    await _isar.writeTxn(() async {
      final existing = await _isar.isarCompletedNodes
          .where()
          .userIdEqualToAnyNodeId(userId)
          .findAll();
      final toDelete = existing
          .where((e) => nodeIds.contains(e.nodeId))
          .map((e) => e.id)
          .toList();
      await _isar.isarCompletedNodes.deleteAll(toDelete);

      for (final row in rows) {
        final entry = IsarCompletedNode()
          ..userId = userId
          ..nodeId = row['node_id'] as String
          ..starsEarned = (row['stars_earned'] as int?) ?? 1
          ..imageUrl = row['image_url'] as String?;
        await _isar.isarCompletedNodes.put(entry);
      }

      // Heal completed_nodes_count in unlocked category
      final unlockedCats = await _isar.isarUnlockedCategorys
          .where()
          .userIdEqualToAnyCategoryId(userId)
           .findAll();
      var unlockedCat = unlockedCats
          .where((c) => c.categoryId == categoryId)
          .firstOrNull;

      if (unlockedCat == null) {
        final newCat = IsarUnlockedCategory()
          ..userId = userId
          ..categoryId = categoryId
          ..unlockedAt = DateTime.now().toUtc()
          ..completedNodesCount = rows.length;
        await _isar.isarUnlockedCategorys.put(newCat);
        needsSupabaseRepair = true;
      } else if (unlockedCat.completedNodesCount != rows.length) {
        unlockedCat.completedNodesCount = rows.length;
        await _isar.isarUnlockedCategorys.put(unlockedCat);
        needsSupabaseRepair = true;
      }
    });

    if (needsSupabaseRepair) {
      try {
        await _supabase.from('user_unlocked_categories').upsert({
          'user_id': userId,
          'category_id': categoryId,
          'completed_nodes_count': rows.length,
          'unlocked_at': DateTime.now().toIso8601String(),
        // ignoring constraints explicitly if needed, but upsert should work if PK is user_id + category_id
        });
      } catch (_) {}
    }
  }
}

final roadmapSyncServiceProvider = Provider<RoadmapSyncService>((ref) {
  final isar = ref.watch(isarProvider);
  final supabase = Supabase.instance.client;
  return RoadmapSyncService(isar, supabase);
});
