import 'package:isar/isar.dart';

part 'isar_category.g.dart';

@collection
class IsarCategory {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  String? supabaseId;

  String? title;
  String? imageUrl;
  int unlockCostStars = 0;
}
