import 'package:isar/isar.dart';

part 'isar_roadmap_node.g.dart';

@collection
class IsarRoadmapNode {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? supabaseId;

  @Index()
  String? categoryId;

  String? recipeId;
  String? title;
  String? previewImageUrl;
  int mapColumn = 0;
  int mapRow = 0;
  List<String> prerequisiteIds = [];
}
