class UserCompletedNode {
  final String userId;
  final String nodeId;
  final int starsEarned;
  final DateTime? completedAt;

  const UserCompletedNode({
    required this.userId,
    required this.nodeId,
    this.starsEarned = 1,
    this.completedAt,
  });

  factory UserCompletedNode.fromJson(Map<String, dynamic> json) {
    return UserCompletedNode(
      userId: json['user_id'] as String,
      nodeId: json['node_id'] as String,
      starsEarned: (json['stars_earned'] as int?) ?? 1,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'node_id': nodeId,
      'stars_earned': starsEarned,
    };
  }
}
