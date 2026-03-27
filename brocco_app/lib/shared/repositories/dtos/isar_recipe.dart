import 'package:isar/isar.dart';

part 'isar_recipe.g.dart';

@collection
@Name('Recipe')
class IsarRecipe {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? supabaseId;

  String? title;
  String? description;
  String? recipePlaintext;
  String? imageUrl;
  String? difficultyLevel;
  int? durationMinutes;
  String? youtubeUrl;
  List<String>? tags;
  String? category;
  String? area;
  String? sourceUrl;
}
