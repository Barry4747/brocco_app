class UserUnlockedCategory {
  final String userId;
  final String categoryId;
  final DateTime? unlockedAt;

  const UserUnlockedCategory({
    required this.userId,
    required this.categoryId,
    this.unlockedAt,
  });

  factory UserUnlockedCategory.fromJson(Map<String, dynamic> json) {
    return UserUnlockedCategory(
      userId: json['user_id'] as String,
      categoryId: json['category_id'] as String,
      unlockedAt: json['unlocked_at'] != null
          ? DateTime.parse(json['unlocked_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'category_id': categoryId,
    };
  }
}
