class Category {
  final String id;
  final String title;
  final String? imageUrl;
  final int unlockCostStars;
  final int totalNodes;

  const Category({
    required this.id,
    required this.title,
    this.imageUrl,
    this.unlockCostStars = 0,
    this.totalNodes = 0,
  });

  bool get isLocked => unlockCostStars > 0;
}
