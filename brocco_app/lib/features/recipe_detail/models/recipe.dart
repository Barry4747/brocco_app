class Recipe {
  final String id;
  final String title;
  final String? description;
  final String? recipePlaintext;
  final String? imageUrl;
  final String? difficultyLevel;
  final int? durationMinutes;
  final String? youtubeUrl;
  final List<String>? tags;
  final String? category;
  final String? area;
  final String? sourceUrl;

  const Recipe({
    required this.id,
    required this.title,
    this.description,
    this.recipePlaintext,
    this.imageUrl,
    this.difficultyLevel,
    this.durationMinutes,
    this.youtubeUrl,
    this.tags,
    this.category,
    this.area,
    this.sourceUrl,
  });
}
