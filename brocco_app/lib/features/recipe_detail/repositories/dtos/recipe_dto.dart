class RecipeDto {
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

  const RecipeDto({
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

  factory RecipeDto.fromJson(Map<String, dynamic> json) {
    return RecipeDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      recipePlaintext: json['recipe_plaintext'] as String?,
      imageUrl: json['image_url'] as String?,
      difficultyLevel: json['difficulty_level'] as String?,
      durationMinutes: json['duration_minutes'] as int?,
      youtubeUrl: json['youtube_url'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      category: json['category'] as String?,
      area: json['area'] as String?,
      sourceUrl: json['source_url'] as String?,
    );
  }
}
