import 'package:isar/isar.dart';

part 'isar_unlocked_category.g.dart';

@collection
class IsarUnlockedCategory {
  Id id = Isar.autoIncrement;

  @Index(composite: [CompositeIndex('categoryId')], unique: true)
  String? userId;

  String? categoryId;
  DateTime? unlockedAt;
  int completedNodesCount = 0;
}
