class RoadmapNode {
  final String id;
  final String categoryId;
  final String? recipeId;
  final String title;
  final String? previewImageUrl;
  final int mapColumn;
  final int mapRow;
  final List<String> prerequisiteIds;

  const RoadmapNode({
    required this.id,
    required this.categoryId,
    this.recipeId,
    required this.title,
    this.previewImageUrl,
    required this.mapColumn,
    required this.mapRow,
    this.prerequisiteIds = const [],
  });
}
