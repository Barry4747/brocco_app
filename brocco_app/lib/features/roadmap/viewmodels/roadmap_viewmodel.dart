import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/local_db/isar_provider.dart';
import '../../../core/local_db/roadmap_sync_service.dart';
import '../../home/models/local/isar_category.dart';
import '../models/local/isar_roadmap_node.dart';
import '../models/local/isar_completed_node.dart';
import '../../../shared/models/user_profile.dart';
import '../../home/models/remote/category.dart';
import '../models/remote/roadmap_node.dart';

class RoadmapState {
  final Category category;
  final List<RoadmapNode> nodes;
  final Set<String> completedNodeIds;
  final int currentStars;
  final int completedCount;
  final int totalCount;

  const RoadmapState({
    required this.category,
    this.nodes = const [],
    this.completedNodeIds = const {},
    this.currentStars = 0,
    this.completedCount = 0,
    this.totalCount = 0,
  });

  bool get isEmpty => nodes.isEmpty;

  bool isNodeCompleted(String nodeId) => completedNodeIds.contains(nodeId);

  bool isNodeUnlocked(RoadmapNode node) {
    if (node.prerequisiteIds.isEmpty) return true;
    return node.prerequisiteIds.every((id) => completedNodeIds.contains(id));
  }
}

class RoadmapViewModel extends FamilyAsyncNotifier<RoadmapState, String> {
  @override
  Future<RoadmapState> build(String categoryId) async {
    final isar = ref.read(isarProvider);
    final userId = Supabase.instance.client.auth.currentUser?.id;

    final localState = await _readFromIsar(isar, userId, categoryId);
    state = AsyncValue.data(localState);

    if (userId != null) {
      _syncInBackground(isar, userId, categoryId);
    }

    return localState;
  }

  Future<RoadmapState> _readFromIsar(
      Isar isar, String? userId, String categoryId) async {
    final isarCat = await isar.isarCategorys
        .where()
        .supabaseIdEqualTo(categoryId)
        .findFirst();

    final category = isarCat != null
        ? Category(
            id: isarCat.supabaseId!,
            title: isarCat.title ?? '',
            imageUrl: isarCat.imageUrl,
            unlockCostStars: isarCat.unlockCostStars,
          )
        : Category(id: categoryId, title: '');

    final isarNodes = await isar.isarRoadmapNodes
        .where()
        .categoryIdEqualTo(categoryId)
        .findAll();

    final nodes = isarNodes
        .where((n) => n.supabaseId != null)
        .map((n) => RoadmapNode(
              id: n.supabaseId!,
              categoryId: n.categoryId ?? categoryId,
              recipeId: n.recipeId,
              title: n.title ?? '',
              previewImageUrl: n.previewImageUrl,
              mapColumn: n.mapColumn,
              mapRow: n.mapRow,
              prerequisiteIds: n.prerequisiteIds,
            ))
        .toList();

    Set<String> completedIds = {};
    int stars = 0;

    if (userId != null) {
      final profile = await isar.userProfiles
          .where()
          .supabaseUserIdEqualTo(userId)
          .findFirst();
      stars = profile?.starsBank ?? 0;

      final nodeIdSet = nodes.map((n) => n.id).toSet();
      final allCompleted = await isar.isarCompletedNodes
          .where()
          .userIdEqualToAnyNodeId(userId)
          .findAll();
      completedIds = allCompleted
          .where((c) => c.nodeId != null && nodeIdSet.contains(c.nodeId))
          .map((c) => c.nodeId!)
          .toSet();
    }

    return RoadmapState(
      category: category,
      nodes: nodes,
      completedNodeIds: completedIds,
      currentStars: stars,
      completedCount: completedIds.length,
      totalCount: nodes.length,
    );
  }

  Future<void> _syncInBackground(
      Isar isar, String userId, String categoryId) async {
    try {
      final syncService = ref.read(roadmapSyncServiceProvider);
      await syncService.syncRoadmapData(userId, categoryId);

      final updatedState = await _readFromIsar(isar, userId, categoryId);
      state = AsyncValue.data(updatedState);
    } catch (_) {}
  }
}

final roadmapViewModelProvider =
    AsyncNotifierProvider.family<RoadmapViewModel, RoadmapState, String>(
      () => RoadmapViewModel(),
    );
