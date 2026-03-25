class UserUnlockedCategory {
  final String userId;
  final String categoryId;
  final DateTime? unlockedAt;
  final int completedNodesCount;

  const UserUnlockedCategory({
    required this.userId,
    required this.categoryId,
    this.unlockedAt,
    this.completedNodesCount = 0,
  });

  factory UserUnlockedCategory.fromJson(Map<String, dynamic> json) {
    return UserUnlockedCategory(
      userId: json['user_id'] as String,
      categoryId: json['category_id'] as String,
      unlockedAt: json['unlocked_at'] != null
          ? DateTime.parse(json['unlocked_at'] as String)
          : null,
      completedNodesCount: (json['completed_nodes_count'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'category_id': categoryId,
      'completed_nodes_count': completedNodesCount,
    };
  }
}
