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

  factory RoadmapNode.fromJson(Map<String, dynamic> json) {
    return RoadmapNode(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      recipeId: json['recipe_id'] as String?,
      title: json['title'] as String,
      previewImageUrl: json['preview_image_url'] as String?,
      mapColumn: json['map_column'] as int,
      mapRow: json['map_row'] as int,
      prerequisiteIds: (json['prerequisite_ids'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
