class Category {
  final String id;
  final String title;
  final String? imageUrl;
  final int unlockCostStars;

  const Category({
    required this.id,
    required this.title,
    this.imageUrl,
    this.unlockCostStars = 0,
  });

  bool get isLocked => unlockCostStars > 0;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String?,
      unlockCostStars: (json['unlock_cost_stars'] as int?) ?? 0,
    );
  }
}
