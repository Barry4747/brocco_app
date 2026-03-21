import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../home/models/category.dart';
import '../models/roadmap_node.dart';

// ──────────────────────────────────────────────
// MOCK – stars and progress (replace when real data is available)
// ──────────────────────────────────────────────
const int mockRoadmapStars = 12;
const Set<String> mockCompletedNodeIds = {};
// ──────────────────────────────────────────────

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

  /// A node is unlocked if all its prerequisites are completed (or it has none).
  bool isNodeUnlocked(RoadmapNode node) {
    if (node.prerequisiteIds.isEmpty) return true;
    return node.prerequisiteIds.every((id) => completedNodeIds.contains(id));
  }
}

class RoadmapViewModel extends FamilyAsyncNotifier<RoadmapState, String> {
  @override
  Future<RoadmapState> build(String categoryId) async {
    final supabase = Supabase.instance.client;

    // Fetch category
    final catResponse = await supabase
        .from('categories')
        .select()
        .eq('id', categoryId)
        .single();
    final category = Category.fromJson(catResponse);

    // Fetch roadmap nodes for this category
    final nodesResponse = await supabase
        .from('roadmap_nodes')
        .select()
        .eq('category_id', categoryId);
    final nodes = (nodesResponse as List)
        .map((e) => RoadmapNode.fromJson(e))
        .toList();

    final completedCount =
        nodes.where((n) => mockCompletedNodeIds.contains(n.id)).length;

    return RoadmapState(
      category: category,
      nodes: nodes,
      completedNodeIds: mockCompletedNodeIds,
      currentStars: mockRoadmapStars,
      completedCount: completedCount,
      totalCount: nodes.length,
    );
  }
}

final roadmapViewModelProvider =
    AsyncNotifierProvider.family<RoadmapViewModel, RoadmapState, String>(
  () => RoadmapViewModel(),
);
