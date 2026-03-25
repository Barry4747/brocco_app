import '../../home/models/category.dart';
import 'roadmap_node.dart';

class RoadmapData {
  final Category category;
  final List<RoadmapNode> nodes;
  final Set<String> completedNodeIds;
  final int currentStars;
  final int completedCount;
  final int totalCount;

  const RoadmapData({
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
